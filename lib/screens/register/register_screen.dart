import 'package:audiory_v0/screens/register/widgets/flow_one.dart';
import 'package:audiory_v0/screens/register/widgets/register_body.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return const RegisterBodyScreen();
  }
}
