import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: appColors.inkLighter,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 16,
                ),
                FormBuilder(
                    key: _formKey,
                    child: AppTextInputField(
                      textAlign: TextAlign.center,
                      name: 'email',
                      hintText: 'abc@gmail.com',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: 'Email rỗng'),
                        FormBuilderValidators.email(
                            errorText: 'Email sai định dạng'),
                      ]),
                    )),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  height: 56,
                  child: AppIconButton(
                      title: 'Tiếp tục',
                      onPressed: () async {
                        _formKey.currentState!.save();

                        bool isValid = _formKey.currentState!.validate();
                        // ignore: use_build_context_synchronously
                        // context.push('/resetPassword');
                        if (isValid) {
                          //send verification email
                          // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return Center(
                          //           child: const CircularProgressIndicator());
                          //     });
                          String email =
                              _formKey.currentState!.fields['email']?.value;
                          try {
                            final res = await AuthRepository()
                                .forgotPassword(email: email);

                            print(res);
                            print('status ${res == 200}');

                            if (res == 200) {
                              context.pop();

                              Map<String, String> body = {
                                'email': email,
                                'isForgotPass': 'true'
                              };

                              // ignore: use_build_context_synchronously
                              context.push('/flowOne', extra: {
                                'signUpBody': body
                              }); //allow back button
                            } else {
                              // ignore: use_build_context_synchronously
                              AppSnackBar.buildCustomTopSnackbar(
                                  context, res, null, SnackBarType.error, 100);
                              // }
                            }
                          } catch (e) {
                            print(e);
                          }
                        } else {
                          AppSnackBar.buildTopSnackBar(
                              context, 'Xảy ra lỗi', null, SnackBarType.error);
                        }
                      }),
                )
              ]),
        ));
  }
}
