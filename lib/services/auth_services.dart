import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

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
  signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtain auth detail from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create a new credentiall for user
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    //sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
