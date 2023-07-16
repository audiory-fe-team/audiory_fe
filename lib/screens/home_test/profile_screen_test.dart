import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/auth_services.dart';
import '../../widgets/filled_button.dart';

class ProfileScreenTest extends StatefulWidget {
  const ProfileScreenTest({super.key});

  @override
  State<ProfileScreenTest> createState() => ProfileScreenTestState();
}

class ProfileScreenTestState extends State<ProfileScreenTest> {
  final User? user = Auth().currentUser;

  Widget _userEmail() {
    print('user:');
    print(user?.photoURL);
    return Text(user?.email ?? 'User email');
  }

  Widget _navigateToHomeScreen() {
    return ActionButton(
        title: 'To home',
        color: Colors.black87,
        bgColor: Colors.white70,
        onPressed: () async {
          context.go('/');
        });
  }

  Future<void> signOut() async {
    await Auth().singOut();
    context.go('/');
  }

  Widget _signOutButton() {
    return ActionButton(
        title: 'Sign out',
        color: Colors.black87,
        bgColor: Colors.white70,
        onPressed: () async {
          signOut();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(children: <Widget>[
        _userEmail(),
        _navigateToHomeScreen(),
        _signOutButton()
      ]),
    );
  }
}
