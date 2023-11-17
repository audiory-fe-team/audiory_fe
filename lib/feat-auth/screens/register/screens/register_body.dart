import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../repositories/auth_repository.dart';
import '../../../../theme/theme_constants.dart';

class RegisterBodyScreen extends StatefulWidget {
  const RegisterBodyScreen({super.key});

  @override
  State<RegisterBodyScreen> createState() => _RegisterBodyScreenState();
}

class _RegisterBodyScreenState extends State<RegisterBodyScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool? isChecked = false;
  String errorMessage = '';

  Widget _submitButton() {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return AppIconButton(
        title: 'Đăng ký',
        color: Colors.white,
        bgColor: appColors.primaryBase,
        onPressed: () async {
          // try {
          //   final result =
          //       await AuthRepository().verifyEmail(email: emailController.text);
          //   if (result == 200) {
          Map<String, String> body = {
            'email': emailController.text,
            'password': passwordController.text,
            'username': usernameController.text,
          };
          // ignore: use_build_context_synchronously
          context.push('/flowOne',
              extra: {'signUpBody': body}); //allow back button
          // ignore: use_build_context_synchronously
          AppSnackBar.buildSnackbar(context, 'Đã gửi thành công mã xác nhận',
              null, SnackBarType.success);
          // } else {
          //   // ignore: use_build_context_synchronously
          //   AppSnackBar.buildSnackbar(
          //       context, 'Email đã được sử dụng', null, SnackBarType.error);
          // }

          // } on Exception catch (e) {
          //   if (kDebugMode) {
          //     print(e);
          //   }
          // }
        });
  }

  Widget _linkToLoginScreen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Đã có tài khoản?',
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        GestureDetector(
          onTap: () => {context.go('/login')},
          child: Text(
            ' Đăng nhập',
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
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Đăng ký",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Color(0xff000000))),
                Text("Tạo một tài khoản để bắt đầu",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Color(0xFF72777A))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Text("Tên đăng nhập",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .titleLarge
                            //         ?.copyWith(
                            //             color: Color(0xff000000),
                            //             fontWeight: FontWeight.w700)),
                            // const SizedBox(
                            //   height: 16.0,
                            // ),
                          ],
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Text("Địa chỉ email",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .titleLarge
                        //         ?.copyWith(
                        //             color: const Color(0xff000000),
                        //             fontWeight: FontWeight.w700)),
                        TextFormField(
                          controller: usernameController,
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
                              labelText: "Tên đăng nhập",
                              focusColor: Colors.black12),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Nhập tên đăng nhập của bạn';
                          //   }
                          //   return null;
                          // },
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
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
                              labelText: "Email",
                              focusColor: Colors.black12),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Nhập tên đăng nhập của bạn';
                          //   }
                          //   return null;
                          // },
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Text("Mật khẩu",
                              //     style: Theme.of(context)
                              //         .textTheme
                              //         .titleLarge
                              //         ?.copyWith(
                              //             color: Color(0xff000000),
                              //             fontWeight: FontWeight.w700)),
                              // SizedBox(
                              //   height: 16.0,
                              // ),
                              TextFormField(
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
                              SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
                                controller: confirmPasswordController,
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
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 1.0, horizontal: 24.0),
                                    labelText: "Xác nhận mật khẩu"),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Nhập mật khẩu của bạn';
                                //   }
                                //   return null;
                                // },
                              ),
                            ])),
                    SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: appColors.primaryBase,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value;
                                });
                              },
                            ),
                            SizedBox(
                              child: Text(
                                'Tôi đã đọc và đồng ý với các điều khoản và điều kiện',
                                textAlign: TextAlign.justify,
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: _submitButton()),
                    Text(errorMessage),
                    Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: _linkToLoginScreen()),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
