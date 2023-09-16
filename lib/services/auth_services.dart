import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audiory_v0/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as logDev;

import 'package:jwt_decoder/jwt_decoder.dart';

import '../core/network/constant/endpoints.dart';
import '../core/network/dio_client.dart';
import '../core/network/dio_exceptions.dart';
import '../models/AuthUser.dart';

final authServiceProvider = Provider<AuthService>((_) => AuthService());

class AuthService extends ChangeNotifier {
  late DioClient _dioClient;

  bool isLoading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  String token = '';

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String baseURL = "http://34.71.125.94:3500/api";
  String authrUrl = "http://34.71.125.94:3500/api/auth";

  Timer? _timer;

  //for auth

  Future<dynamic> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse('$authrUrl/login');
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print('fcmToken $fcmToken');
    }
    Map<String, String> body = {
      'username_or_email': email,
      'password': password,
      'registration_token ': fcmToken.toString()
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
      var decodedToken = JwtDecoder.decode(token)['user_id'];
      print('decodedToek : $decodedToken');
      print('decodedToek : ${JwtDecoder.decode(token)}');
      storage.write(key: 'jwt', value: token);
      Map<String, String> header2 = {
        "Content-type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      };

      var uri = Uri.parse('$baseURL/users/$decodedToken');
      var res = await http.get(uri, headers: header2);

      if (res.statusCode == 200) {
        storage.write(key: 'currentUser', value: res.body.toString());
        return response;
      }
    } on Exception catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return err;
    }
  }

  Future<dynamic> signUp({
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
    var url = Uri.parse('$baseURL/users');
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
    } on Exception catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<dynamic> verifyEmail({
    required String email,
    String? username,
    String? fullname,
  }) async {
    Map<String, String> body = {
      'email': email,
    };
    var url = Uri.parse('$authrUrl/send-verification-email');
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
      return response;
    } on Exception catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
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
      print('gUser $gUser');

      if (gUser != null) {
        //begin interactive sign in process;

        //obtain auth detail from request
        final GoogleSignInAuthentication gAuth = await gUser!.authentication;
        //create a new credentiall for user
        print('gAuth $gAuth');

        final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken, idToken: gAuth.idToken);
        print('gAuth $credential');

        //sign in
        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        print('usercredential $userCredential');

        IdTokenResult tokenResult =
            await FirebaseAuth.instance.currentUser!.getIdTokenResult();
        logDev.log(tokenResult.token.toString(), name: 'token');

        String idToken = tokenResult.token!;

        User? user = userCredential.user;
        print('user $user');
        if (user != null) {
          final url = Uri.parse("$authrUrl/login-with-google");
          Map<String, String> header = {
            "Content-type": "application/json",
            "Accept": "application/json",
            "Authorization": idToken
          };

          final response = await http.post(url, headers: header);

          if (kDebugMode) {
            print('res');
            print(response.body);
          }

          if (response.statusCode == 200) {
            final token = jsonDecode(response.body)['data'];

            //save token
            const storage = FlutterSecureStorage();
            storage.write(key: 'jwt', value: token);

            //Set the user to auth provider
            AuthProvider authProvider = AuthProvider();
            authProvider.setUser(currentUser);
            await getUserDetails(authProvider);

            // return fetchUserInformation(decodedToken['user_id'], token);
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
      var json = JwtDecoder.decode(value);
      print('jwt $json');
      String id = json['user_id'];
      var headers = <String, String>{
        'Authorization': 'Bearer $value',
        'Content-Type': 'application/json; charset=UTF-8'
      };
      var uri = Uri.parse('$baseURL/users/$id');
      var response = await client.get(uri, headers: headers);
      if (kDebugMode) {
        print('response google ${response}');
      }
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
        var response = await _dioClient.get('${Endpoints().user}/$userId',
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
}
