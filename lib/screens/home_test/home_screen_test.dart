import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/widgets/buttons/filled_button.dart';
import 'package:flutter/material.dart';

//auth
import "package:firebase_auth/firebase_auth.dart";
import 'package:audiory_v0/services/auth_services.dart';
import "package:go_router/go_router.dart";

class HomeScreenTest extends StatefulWidget {
  const HomeScreenTest({super.key});

  @override
  State<HomeScreenTest> createState() => _HomeScreenTestState();
}

class _HomeScreenTestState extends State<HomeScreenTest> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().singOut();
    context.go('/login');
  }

  Widget _userEmail() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return AppFilledButton(
        title: 'Sign out',
        color: Colors.black87,
        bgColor: Colors.white70,
        onPressed: () async {
          signOut();
        });
  }

  Widget _navigateToLoginScreen() {
    return AppFilledButton(
        title: 'To login',
        color: Colors.black87,
        bgColor: Colors.white70,
        onPressed: () async {
          Navigator.of(context).pushNamed('/login');
        });
  }

  Widget _navigateToProfileScreen() {
    return AppFilledButton(
        title: 'To profile',
        color: Colors.black87,
        bgColor: Colors.white70,
        onPressed: () async {
          // Navigator.of(context).pushNamed('/profile');
          context.go('/profile');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('demo auth')),
      body: Stack(
        children: <Widget>[],
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
