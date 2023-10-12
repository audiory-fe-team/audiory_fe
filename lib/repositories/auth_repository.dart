import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audiory_v0/models/Profile.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as logDev;

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/AuthUser.dart';
import 'package:audiory_v0/providers/auth_provider.dart';
import 'package:dio/dio.dart';

import '../core/network/dio_client.dart';
import '../core/network/dio_exceptions.dart';
import '../core/network/constant/endpoints.dart';

final authServiceProvider = Provider<AuthRepository>((_) => AuthRepository());

class AuthRepository extends ChangeNotifier {
  late DioClient _dioClient;

  bool isLoading = false;
  bool isBack = false;
  String message = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  String token = '';

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String baseURL = Endpoints().toString();
  String authUrl = Endpoints().auth;

  Timer? _timer;

  Future<dynamic> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse('${Endpoints().auth}/login');
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print('fcmToken $fcmToken');
    }
    Map<String, String> body = {
      'username_or_email': email,
      'password': password,
      'registration_token': fcmToken as String
    };
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    const storage = FlutterSecureStorage();

    try {
      final response =
          await http.post(url, headers: header, body: jsonEncode(body));
      if (kDebugMode) {
        print('res');
        print(response.body);
      }
      final token = jsonDecode(response.body)['data'];

      storage.write(key: 'jwt', value: token);

      print('JWT  $token');
      print('DECODED  ${JwtDecoder.decode(token)}');
      Map<String, String> header2 = {
        "Content-type": "application/json,,charset=UTF-8",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      };

      var uri = Uri.parse('${Endpoints().user}/me');
      var res = await http.get(uri, headers: header2);
      print('res2 ${res.body}');
      if (res.statusCode == 200) {
        print('yeah');
        storage.write(key: 'currentUser', value: res.body.toString());
        return res;
      }
    } on Exception catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return err;
    }
  }

  Future<Profile?> signUp({
    required String email,
    required String username,
    required String password,
    required String fullname,
    required String code,
  }) async {
    Map<String, dynamic> body = {
      'email': email,
      'username': username,
      'full_name': fullname,
      'password': password,
      'verification_code': code
    };
    var url = Uri.parse(Endpoints().user);
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    try {
      final response =
          await http.post(url, headers: header, body: jsonEncode(body));
      if (kDebugMode) {
        print('res');
        print(response.body);
      }
      return Profile.fromJson(
          jsonDecode(response.body)['data'] ?? jsonDecode(''));
    } on Exception catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return null;
    }
  }

  Future<dynamic> verifyEmail({
    required String email,
    String? username,
    String? fullname,
  }) async {
    Map<String, String> body = {'email': email};
    var url = Uri.parse('${Endpoints().auth}/send-verification-email');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    try {
      final response =
          await http.post(url, headers: header, body: jsonEncode(body));
      if (kDebugMode) {
        print('res');
        print(response.body);
      }

      return response.statusCode;
    } on Exception catch (err) {}
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<bool> singOut() async {
    const storage = FlutterSecureStorage();
    storage.deleteAll();
    await _firebaseAuth.signOut();
    return true;
  }

  //Google Sign In
  Future<UserServer?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? gUser = await googleSignIn.signIn();

      if (gUser != null) {
        //begin interactive sign in process;

        //obtain auth detail from request
        final GoogleSignInAuthentication gAuth = await gUser!.authentication;
        //create a new credentiall for user

        final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken, idToken: gAuth.idToken);

        //sign in
        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        IdTokenResult tokenResult =
            await FirebaseAuth.instance.currentUser!.getIdTokenResult();

        String idToken = tokenResult.token!;

        print('jwt $idToken');

        User? user = userCredential.user;
        if (user != null) {
          final url = Uri.parse("$authUrl/login-with-google");
          Map<String, String> header = {
            "Content-type": "application/json,charset=UTF-8",
            "Accept": "application/json",
            "Authorization": 'Bearer $idToken'
          };
          final fcmToken = await FirebaseMessaging.instance.getToken();
          Map<String, String> body = {'registration_token': fcmToken as String};
          print('token ${fcmToken}');

          final response =
              await http.post(url, headers: header, body: jsonEncode(body));

          print('res for login google');
          print(response.body);

          if (response.statusCode == 200) {
            final token = jsonDecode(response.body)['data'];

            //save token
            const storage = FlutterSecureStorage();

            print('jwt ${token}');

            //Set the user to auth provider
            AuthProvider authProvider = AuthProvider();
            authProvider.setUser(currentUser);
            await getUserDetails(authProvider);
          }
        }
      }
      return null;
    } on Exception catch (err) {}
    return null;
  }

  Future<void> getUserDetails(AuthProvider authProvider) async {
    var client = http.Client();
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'jwt');
    if (value != null) {
      var headers = <String, String>{
        'Authorization': 'Bearer $value',
        'Content-Type': 'application/json; charset=UTF-8'
      };
      var uri = Uri.parse('${Endpoints().user}/me');
      var response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        var json = response.body;
        storage.write(key: 'currentUser', value: response.body.toString());
        authProvider = AuthProvider();
        authProvider
            .setUserDetails(UserServer.fromJson(jsonDecode(json)['data']));
      }
    }
  }

  //get user profile
  Future<void> getUserProfile(String userId) async {
    try {
      const storage = FlutterSecureStorage();
      String? value = await storage.read(key: 'jwt');
      if (value != null) {
        var headers = <String, String>{
          // 'Authorization': 'Bearer $value',
          'Content-Type': 'application/json; charset=UTF-8'
        };
        var response = await _dioClient.get(
            '${Endpoints().user}/$userId/profile',
            options: Options(headers: headers));

        if (response.statusCode == 200) {
          final result = response.data['data'];
          final userProfile = UserServer.fromJson(result);
          final authProvider = AuthProvider();
          authProvider.setUserDetails(userProfile);
        }
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      if (kDebugMode) {
        print(errorMessage);
      }

      rethrow;
    }
  }

  Future<Profile> getMyInfo() async {
    final url = Uri.parse('${Endpoints().user}/me');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }

    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody)['data'];
      return Profile.fromJson(result);
    } else {
      throw Exception('Failed to load user info');
    }
  }

  Future<UserServer> getMyUserById() async {
    final url = Uri.parse('${Endpoints().user}/me');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }

    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      try {
        final result = jsonDecode(responseBody)['data'];
        print('cast userserver');
        print(UserServer.fromJson(result));
        return UserServer.fromJson(result);
      } catch (e) {
        print('hhhhh $e');
        throw e;
      }
    } else {
      throw Exception('Failed to load user info');
    }
  }
}
