import 'dart:async';
import 'dart:convert';

import 'package:audiory_v0/models/body/signin_body.dart';
import 'package:audiory_v0/models/body/signup_body.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/User.dart';

class Auth extends ChangeNotifier {
  bool isLoading = false;
  bool isBack = false;
  String message = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  AuthUser? authUser;

  String token = '';

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String authrUrl = "${dotenv.get('API_BASE_URL')}/auth";

  // Timer? _timer;
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();

    SignInBody body =
        new SignInBody(username_or_email: email, password: password);
    var url = Uri.parse(authrUrl + '/login');
    print(body);
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    try {
      final response = await http.post(url,
          headers: header, body: jsonEncode(body.toJson()));
      print('res');
      print(response.body);
      if (response.statusCode == 200) {
        isBack = true;
      }
      if (response.statusCode == 401) {
        message = jsonDecode(response.body)['message'];
      }
      isLoading = false;
    } on Exception catch (err) {
      print(err);
      message = err.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> signUp({
    required String email,
    required String username,
    required String password,
    required String fullname,
  }) async {
    isLoading = true;
    notifyListeners();

    SignUpBody body = new SignUpBody(
        email: email,
        username: username,
        full_name: fullname,
        password: password);
    var url = Uri.parse('${dotenv.get('API_BASE_URL')}/users');
    print(body);
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    try {
      final response = await http.post(url,
          headers: header, body: jsonEncode(body.toJson()));

      if (response.statusCode == 200) {
        isBack = true;
      }
      if (response.statusCode == 401) {
        message = jsonDecode(response.body)['message'];
      }
      isLoading = false;
    } on Exception catch (err) {
      message = err.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> singOut() async {
    await _firebaseAuth.signOut();
  }

  //Google Sign In
  Future<void> signInWithGoogle() async {
    final GoogleSignIn? _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? gUser = await _googleSignIn!.signIn();
      if (gUser != null) {
        //begin interactive sign in process;

        //obtain auth detail from request
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
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
          final url = Uri.parse("$authrUrl/login-with-google");
          Map<String, String> header = {
            "Content-type": "application/json",
            "Accept": "application/json",
            "Authorization": idToken
          };

          final response = await http.post(url, headers: header);

          print('res');
          print(response.body);

          if (response.statusCode == 200) {
            final token = jsonDecode(response.body)['data'];

            print('su');
            print(token);

            Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

            print(decodedToken);
            print(decodedToken['id']);
            print(decodedToken['username']);
            print(user.email);
            print(user.photoURL);

            authUser = AuthUser(
                id: decodedToken['id']! ?? 'id',
                username: decodedToken['username']! ?? 'username',
                email: user.email as String,
                profilePhoto: user.photoURL as String,
                role: 'user');

            authUser!.id = decodedToken['id'];
            authUser!.username = decodedToken['username'];
            authUser!.email = user.email as String;
            authUser!.profilePhoto = user.photoURL as String;
            authUser!.role = 'user';
            notifyListeners();
            print('authuser');
            print(authUser);

            final storage = new FlutterSecureStorage();
            await storage.write(key: 'authUser', value: authUser.toString());
          }
        }
      }
    } on Exception catch (err) {
      print(err);
    }
  }
}
