import 'package:audiory_v0/widgets/buttons/filled_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/auth_services.dart';

class ProfileScreenTest extends StatefulWidget {
  const ProfileScreenTest({super.key});

  @override
  State<ProfileScreenTest> createState() => ProfileScreenTestState();
}

class ProfileScreenTestState extends State<ProfileScreenTest> {
  final User? user = Auth().currentUser;

  Widget _userEmail() {
    return Text(user?.email ?? 'User email');
  }

  Widget _userToken() {
    print('toekn:');
    print(user?.providerData);
    return Text('User token');
  }

  Future<void> signOut() async {
    await Auth().singOut();
    context.go('/');
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[_userEmail(), _userToken(), _signOutButton()],
      ),
    );
  }
}
