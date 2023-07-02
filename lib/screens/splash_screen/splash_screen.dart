import 'dart:math';

import 'package:audiory_v0/widgets/filled_button.dart';
import 'package:audiory_v0/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void press() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(),
        // ),
        body: SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Expanded(
                  flex: 4,
                  child: Image(
                      height: double.maxFinite,
                      image:
                          AssetImage('assets/images/man_holding_pencil.png'))),
              Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Xin chào !",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Color(0xff000000))),
                      Container(
                          child: Column(
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
                                      vertical: 1.0, horizontal: 24.0),
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
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Quên mật khẩu?',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFF404446),
                                  fontSize: 13,
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.05,
                                ),
                              )),
                        ],
                      )),
                      SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: const ActionButton(
                              title: 'Đăng nhập',
                              color: Colors.white,
                              bgColor: Color(0xFF439A97))),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Chưa có tài khoản?',
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Đăng ký',
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF439A97)),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Hoặc',
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
    ));
  }
}
