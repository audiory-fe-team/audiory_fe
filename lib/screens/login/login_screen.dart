import 'package:audiory_v0/screens/forgot_password/forgot_password_screen.dart';
import 'package:audiory_v0/screens/home/home_screent.dart';
import 'package:audiory_v0/screens/register/register_screen.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:audiory_v0/widgets/filled_button.dart';
import 'package:audiory_v0/widgets/rounded_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _press(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(),
      // ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  height: size * 0.35,
                  child: Image(
                      height: double.maxFinite,
                      image:
                          AssetImage('assets/images/man_holding_pencil.png'))),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  height: size * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Xin chào !",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Color(0xff000000))),
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Color(0xFF439A97),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Color(0xFF439A97),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Color(0xFF439A97),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 228, 212, 212)),
                                  fillColor: Colors.white70,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 24),
                                  labelText: "Tên đăng nhập",
                                  focusColor: Colors.black12),
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Nhập tên đăng nhập của bạn';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Color(0xFF439A97),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Color(0xFF439A97),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(80)),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 228, 212, 212),
                                    fontSize: 24,
                                    fontFamily: 'Source San Pro',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.06,
                                  ),
                                  fillColor: Colors.white70,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 24.0),
                                  labelText: "Mật khẩu"),
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Nhập mật khẩu của bạn';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordScreen()))
                              },
                              child: Text('Quên mật khẩu?',
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: Color(0xFF404446),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold)),
                            ),
                          ),
                          ActionButton(
                              title: 'Đăng nhập',
                              color: Colors.white,
                              bgColor: Color(0xFF439A97),
                              onPressed: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreeen()))
                                  }),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Chưa có tài khoản?',
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(),
                            ),
                            GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()))
                              },
                              child: Text(
                                'Đăng ký',
                                textAlign: TextAlign.right,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF439A97)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Divider(
                              height: 1.0,
                            ),
                            SizedBox(
                                height: 30,
                                child: Text(
                                  'Hoặc',
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: Color(0xFF71727A),
                                      ),
                                )),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CircularButton(
                                    icon: FontAwesomeIcons.google,
                                    size: 12.0,
                                    color: Colors.white,
                                    bgColor: Colors.black),
                                CircularButton(
                                    icon: FontAwesomeIcons.apple,
                                    size: 12.0,
                                    color: Colors.white,
                                    bgColor: Colors.red),
                                CircularButton(
                                    icon: FontAwesomeIcons.facebookF,
                                    size: 12.0,
                                    color: Colors.white,
                                    bgColor: Color(0xFF006FFD)),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
