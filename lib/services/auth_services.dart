import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  String token = '';

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
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
    const baseURL = "http://34.101.77.146:3500/api";
    final authrUrl = baseURL + "/auth";
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
        print('token');
        print(idToken);

        User? user = userCredential.user;
        if (user != null) {
          final url = Uri.parse(authrUrl + "/login-with-google");
          Map<String, String> header = {
            "Content-type": "application/json",
            "Accept": "application/json",
            "Authorization": 'Bearer ${idToken}'
          };

          final response = await http.post(url, headers: header);
          print('res');
          print(response.body);
        }
      }
    } on Exception catch (err) {
      print(err);
    }
  }
}
