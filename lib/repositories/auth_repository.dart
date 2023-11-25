import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/streak/streak_model.dart';
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
      'registration_token': fcmToken ?? ''
    };
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    const storage = FlutterSecureStorage();

    try {
      final response =
          await http.post(url, headers: header, body: jsonEncode(body));
      if (response.statusCode != 200) {
        return null;
      }
      final token = jsonDecode(response.body)['data'];

      storage.write(key: 'jwt', value: token);

      Map<String, String> header2 = {
        "Content-type": "application/json,,charset=UTF-8",
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      };

      var uri = Uri.parse('${Endpoints().user}/me');
      var res = await http.get(uri, headers: header2);

      if (res.statusCode == 200) {
        storage.write(key: 'currentUser', value: res.body.toString());
        return res;
      }
    } on Exception catch (err) {
      print(err);
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

  Future<dynamic> forgotPassword({
    required String email,
  }) async {
    Map<String, String> body = {'email': email};
    var url = Uri.parse('${Endpoints().auth}/forgot-password');
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    try {
      final response =
          await http.post(url, headers: header, body: jsonEncode(body));
      if (response.statusCode == 200) {
      } else {
        throw Exception();
      }
    } catch (e) {}
  }

  Future<dynamic> resetPassword(
      {required String resetToken, required String password}) async {
    var dio = Dio();
    var url = '${Endpoints().auth}/reset-password/$resetToken';
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    Map<String, String> body = {'password': password};
    final response = await dio.patch(url,
        options: Options(headers: header), data: jsonEncode(body));
    if (kDebugMode) {
      print('res for reset pass');
      print(response);
    }
    if (response.statusCode == 200) {
    } else {
      return Exception();
    }
  }

  Future<dynamic> checkResetPassword({
    required String resetToken,
  }) async {
    var dio = Dio();
    var url = '${Endpoints().auth}/reset-password/$resetToken';
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    final response = await dio.get(url, options: Options(headers: header));
    if (kDebugMode) {
      print('res for reset pass');
      print(response);
    }
    if (response.statusCode == 200) {
    } else {
      return Exception();
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
  Future<AuthUser?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? gUser = await googleSignIn.signIn();

      if (gUser != null) {
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

        User? user = userCredential.user;
        if (user != null) {
          final url = Uri.parse("$authUrl/login-with-google");
          Map<String, String> header = {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": idToken //no Bearer
          };
          final fcmToken = await FirebaseMessaging.instance.getToken();
          Map<String, String> body = {'registration_token': fcmToken ?? ''};

          final response =
              await http.post(url, headers: header, body: jsonEncode(body));

          if (kDebugMode) {
            print('response body');
            print(header);
            print(body);

            print(utf8.decode(response.bodyBytes));
          }

          if (response.statusCode == 200) {
            print('RES FOR GG ${response}');
            final token = jsonDecode(response.body)['data'];
            //save token
            const storage = FlutterSecureStorage();
            storage.write(key: 'jwt', value: token);
          }
        }
      }
      return null;
    } on Exception catch (err) {}
    return null;
  }

  //get user profile
  Future<Profile?> getOtherUserProfile(String userId) async {
    var url = Uri.parse('${Endpoints().user}/$userId/profile');
    try {
      const storage = FlutterSecureStorage();
      String? value = await storage.read(key: 'jwt');

      if (value != null) {
        var headers = <String, String>{
          'Authorization': 'Bearer $value',
          'Accept': 'application/json'
        };
        final response = await http.get(url, headers: headers);
        final responseBody = utf8.decode(response.bodyBytes);
        if (response.statusCode == 200) {
          final result = jsonDecode(responseBody)['data'];
          return Profile.fromJson(result);
        } else {
          return null;
        }
      }
    } on DioException catch (e) {}
    return null;
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

  Future<List<Streak>?> getMyStreak() async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');

    String userId = JwtDecoder.decode(jwtToken ?? '')['user_id'];
    print('userId $userId');
    final url = Uri.parse('${Endpoints().user}/$userId/streak');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };

    final response = await http.get(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final List<dynamic> result =
          jsonDecode(responseBody)['data']['rewards'] ?? [];

      return result.map((e) => Streak.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load user info');
    }
  }

  Future<dynamic> receiveReward() async {
    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'jwt');
    String userId = JwtDecoder.decode(jwtToken ?? '')['user_id'];
    final url = Uri.parse('${Endpoints().user}/$userId/daily-reward');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };
    if (jwtToken != null) {
      headers['Authorization'] = 'Bearer $jwtToken';
    }

    final response = await http.post(url, headers: headers);
    final responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load user info');
    }
  }

  Future<AuthUser> getMyUserById() async {
    final url = Uri.parse('${Endpoints().user}/me');

    // Create headers with the JWT token if it's available
    Map<String, String> headers = {
      "Content-type": "application/json",
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
        return AuthUser.fromJson(result);
      } catch (e) {
        rethrow;
      }
    } else {
      throw Exception('Failed to load user info');
    }
  }
}
