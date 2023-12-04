import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/providers/global_me_provider.dart';
import 'package:audiory_v0/utils/widget_helper.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//auth
import "package:firebase_auth/firebase_auth.dart";
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:audiory_v0/theme/theme_constants.dart';

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
      await AuthRepository().createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {}
  }

  Future<void> signInGoogle() async {
    try {
      await AuthRepository().signInWithGoogle();
      // ignore: use_build_context_synchronously

      try {
        final info = await AuthRepository().getMyInfo();
        ref.read(globalMeProvider.notifier).setUser(info);
      } catch (error) {
        print(error);
      }
      // ignore: use_build_context_synchronously
      context.go('/');
    } catch (e) {
      if (kDebugMode) {
        print('error: ${e.toString()}');
      }
    }
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
      height: 50,
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
                    try {
                      final res = await AuthRepository()
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                      // ignore: use_build_context_synchronously
                      context.pop();

                      if (res != null) {
                        FocusManager.instance.primaryFocus!.unfocus();
                        passwordController.clear();
                        // ignore: use_build_context_synchronously

                        try {
                          final info = await AuthRepository().getMyInfo();
                          ref.read(globalMeProvider.notifier).setUser(info);
                        } catch (error) {
                          print(error);
                        }

                        context.go('/');
                        // ignore: use_build_context_synchronously
                        AppSnackBar.buildTopSnackBar(context,
                            'Đăng nhập thành công', null, SnackBarType.success);
                      } else {
                        // ignore: use_build_context_synchronously
                        AppSnackBar.buildTopSnackBar(
                            context,
                            'Sai tên đăng nhập hoặc mật khẩu',
                            null,
                            SnackBarType.error);
                        FocusManager.instance.primaryFocus!.unfocus();
                        passwordController.clear();
                      }
                    } catch (e) {}
                  } on Exception catch (_) {}
                }),
    );
  }

  Widget _linkToRegisterScreen(BuildContext context) {
    return GestureDetector(
      onTap: () => {context.go('/register')},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Chưa có tài khoản?',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(),
          ),
          Text(
            ' Đăng ký',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold, color: const Color(0xFF439A97)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    double size = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 2.0),
                  height: size * 0.25,
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
                          Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                                controller: emailController,
                                decoration: appInputDecoration(context)
                                    .copyWith(
                                        label: Text(
                                          'Tên đăng nhập / Email',
                                          style: TextStyle(
                                              color: appColors.inkLight),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16))),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                                onSaved: (event) {
                                  emailController.text.isEmpty
                                      ? AppSnackBar.buildSnackbar(
                                          context,
                                          'Không được để trống',
                                          null,
                                          SnackBarType.error)
                                      : null;
                                },
                                controller: passwordController,
                                obscureText: true,
                                decoration: appInputDecoration(context)
                                    .copyWith(
                                        label: Text(
                                          'Mật khẩu',
                                          style: TextStyle(
                                              color: appColors.inkLight),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16))),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () => {context.push('/forgotPassword')},
                              child: Text('Quên mật khẩu?',
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: const Color(0xFF404446),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold)),
                            ),
                          ),
                          _submitButton(),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.only(top: 16),
                        child: AppIconButton(
                          onPressed: () {
                            signInGoogle();
                          },
                          title: 'Tiếp tục với Google',
                          bgColor: appColors.secondaryLight,
                          color: appColors.skyLightest,
                        ),
                      ),
                      Container(
                          height: 50,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: _linkToRegisterScreen(context)),
                      Container(
                          height: 50,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextButton(
                            onPressed: () {
                              context.go('/');
                            },
                            child: Text(
                              'Trang chủ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(),
                            ),
                          )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
