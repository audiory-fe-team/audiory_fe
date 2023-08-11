import 'dart:async';
import 'dart:convert';

import 'package:audiory_v0/models/body/signin_body.dart';
import 'package:audiory_v0/models/body/signup_body.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as logDev;

class Auth extends ChangeNotifier {
  bool isLoading = false;
  bool isBack = false;
  String message = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  String token = '';

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String baseURL = "http://34.121.234.163:3500/api";
  String authrUrl = "http://34.121.234.163:3500/api/auth";

  Timer? _timer;
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
    var url = Uri.parse(baseURL + '/users');
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
    isLoading = true;
    notifyListeners();

    final GoogleSignIn? _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? gUser = await _googleSignIn!.signIn();
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
        // print('token');
        // print(idToken);
        // debugPrint(idToken);

        User? user = userCredential.user;
        if (user != null) {
          final url = Uri.parse(authrUrl + "/login-with-google");
          Map<String, String> header = {
            "Content-type": "application/json",
            "Accept": "application/json",
            "Authorization": idToken
          };

          final response = await http.post(url, headers: header);

          print('res');
          print(response.body);

          if (response.statusCode == 200) {
            isBack = true;
            isLoading = false;
            notifyListeners();
          }
        }
      }
    } on Exception catch (err) {
      print(err);
    }
    isLoading = false;
    notifyListeners();
  }
}
