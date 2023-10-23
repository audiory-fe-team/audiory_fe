import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/filled_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Quên mật khẩu",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: appColors.inkDark)),
                Text(
                    "Nhập email của bạn vào ô dưới đây và chúng tôi sẽ gửi bạn hướng dẫn bạn cách đặt lại",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: appColors.inkBase,
                        fontWeight: FontWeight.normal)),
                const SizedBox(
                  height: 16,
                ),
                FormBuilder(
                    key: _formKey,
                    child: AppTextInputField(
                      textAlign: TextAlign.center,
                      name: 'email',
                      hintText: 'abc@gmail.com',
                      validator: (value) {
                        if (EmailValidator.validate(value ?? '') == false) {
                          return 'Email không hợp lệ';
                        }
                      },
                    )),
                const SizedBox(
                  height: 16,
                ),
                AppFilledButton(
                    title: 'Tiếp tục',
                    color: appColors.skyLightest,
                    bgColor: appColors.primaryBase,
                    onPressed: () async {
                      _formKey.currentState!.save();

                      bool isValid = _formKey.currentState!.validate();
// ignore: use_build_context_synchronously
                      // context.push('/resetPassword');
                      if (isValid) {
                        //send verification email

                        String email =
                            _formKey.currentState!.fields['email']?.value;
                        try {
                          await AuthRepository().forgotPassword(email: email);

                          // ignore: use_build_context_synchronously
                          Map<String, String> body = {
                            'email': email,
                            'isForgotPass': 'true'
                          };
                          // ignore: use_build_context_synchronously
                          context.pushNamed('flowOne', extra: {
                            'signUpBody': body,
                          });
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          AppSnackBar.buildTopSnackBar(
                              context, e.toString(), null, SnackBarType.error);
                        }
                      } else {
                        AppSnackBar.buildTopSnackBar(context,
                            'Email không hơp lệ', null, SnackBarType.error);
                      }
                    }),
              ]),
        ));
  }
}
