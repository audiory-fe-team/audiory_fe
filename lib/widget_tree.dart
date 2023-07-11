import "package:audiory_v0/screens/home_test/home_screen_test.dart";
import "package:audiory_v0/screens/login/login_screen.dart";
import 'package:flutter/material.dart';
//auth
import "package:firebase_auth/firebase_auth.dart";
import 'package:audiory_v0/services/auth_services.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreenTest();
          } else {
            return const LoginScreen();
          }
        });
  }
}
