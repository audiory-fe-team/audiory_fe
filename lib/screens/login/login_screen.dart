import 'dart:convert';
import 'dart:io';

import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:audiory_v0/widgets/buttons/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//auth
import "package:firebase_auth/firebase_auth.dart";
import 'package:audiory_v0/services/auth_services.dart';
import 'package:go_router/go_router.dart';

import '../../theme/theme_constants.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessage = '';
  bool isLogin = true;
  bool isLogging = false;

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await AuthService().createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {}
  }

  Future<void> signInGoogle() async {
    try {
      await AuthService().signInWithGoogle();
      // if (provider.isBack) {
      //   context.go('/');
      // }
      // ignore: use_build_context_synchronously
      context.go('/');
    } on FirebaseAuthException catch (e) {
      // setState(() {
      //   errorMessage = provider.message;
      // });
      print(e);
    }
  }

  Widget _errorMessage() {
    return Text(
      errorMessage,
      style: const TextStyle(color: Colors.red),
    );
  }

  void _displaySnackBar(String? content) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: appColors.primaryBase,
      duration: const Duration(seconds: 3),
      content: Text(content as String),
      action: SnackBarAction(
        textColor: appColors.skyBase,
        label: 'Undo',
        onPressed: () {},
      ),
    ));
  }

  Widget _submitButton() {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    bool isInvalid =
        emailController.text.isEmpty || passwordController.text.isEmpty;
    return SizedBox(
      width: double.infinity,
      child: AppIconButton(
          title: 'Đăng nhập',
          bgColor: isInvalid ? appColors.skyDark : appColors.primaryBase,
          onPressed: isInvalid
              ? () async {
                  FocusManager.instance.primaryFocus!.unfocus();
                  _displaySnackBar('Không được để trống');
                }
              : () async {
                  try {
                    // ignore: use_build_context_synchronously
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        });

                    final res = await AuthService().signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    // ignore: use_build_context_synchronously
                    context.pop();

                    if (res.statusCode == 200) {
                      FocusManager.instance.primaryFocus!.unfocus();
                      passwordController.clear();
                      // ignore: use_build_context_synchronously
                      context.go('/');
                      _displaySnackBar('Đăng nhập thành công');
                    } else {
                      FocusManager.instance.primaryFocus!.unfocus();
                      passwordController.clear();
                      final message = jsonDecode(res.body)['message'];
                      _displaySnackBar(message);
                    }
                  } on Exception catch (e) {
                    print(e);
                  }
                }),
    );
  }

  Widget _linkToRegisterScreen(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Chưa có tài khoản?',
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(),
        ),
        GestureDetector(
          onTap: () => {context.go('/register')},
          child: Text(
            'Đăng ký',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold, color: Color(0xFF439A97)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  margin: const EdgeInsets.symmetric(vertical: 2.0),
                  height: size * 0.35,
                  child: const Image(
                      height: double.maxFinite,
                      image:
                          AssetImage('assets/images/man_holding_pencil.png'))),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: size * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Xin chào !",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: const Color(0xff000000))),
                      Column(
                        children: <Widget>[
                          // const AppTextInputField(
                          //   name: 'emailOrUsername',
                          //   hintText: 'Tên đăng nhập / Email',
                          //   isRequired: true,
                          // ),
                          // const AppTextInputField(
                          //   name: 'password',
                          //   hintText: 'Mật khẩu',
                          //   isRequired: true,
                          // ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              onSaved: (event) {
                                emailController.text.isEmpty
                                    ? _displaySnackBar('Không được để trống')
                                    : null;
                              },
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
                                    color: Color.fromARGB(255, 228, 212, 212)),
                                fillColor: Colors.white70,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 24),
                                labelText: "Tên đăng nhập / Email",
                                focusColor: Colors.black12,
                              ),
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Nhập tên đăng nhập của bạn';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              onSaved: (event) {
                                emailController.text.isEmpty
                                    ? _displaySnackBar('Không được để trống')
                                    : null;
                              },
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
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 24.0),
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
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () => {},
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
                          _errorMessage(),
                          _submitButton(),
                        ],
                      ),
                      Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: _linkToRegisterScreen(context)),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Divider(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CircularButton(
                                    icon: FontAwesomeIcons.google,
                                    size: 12.0,
                                    color: Colors.white,
                                    bgColor: Colors.black,
                                    onPressed: () {
                                      signInGoogle();
                                    }),
                                CircularButton(
                                    icon: FontAwesomeIcons.apple,
                                    size: 12.0,
                                    color: Colors.white,
                                    bgColor: Colors.red,
                                    onPressed: () {}),
                                CircularButton(
                                    icon: FontAwesomeIcons.facebookF,
                                    size: 12.0,
                                    color: Colors.white,
                                    bgColor: const Color(0xFF006FFD),
                                    onPressed: () {}),
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
