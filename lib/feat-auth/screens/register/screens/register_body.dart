import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/utils/widget_helper.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../repositories/auth_repository.dart';
import '../../../../theme/theme_constants.dart';

class RegisterBodyScreen extends StatefulWidget {
  const RegisterBodyScreen({super.key});

  @override
  State<RegisterBodyScreen> createState() => _RegisterBodyScreenState();
}

class _RegisterBodyScreenState extends State<RegisterBodyScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool? isChecked = false;
  String errorMessage = '';
  var pass = '';

  Widget _submitButton() {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return AppIconButton(
        title: 'Đăng ký',
        color: Colors.white,
        bgColor: appColors.primaryBase,
        onPressed: () async {
          final isValid = _formKey.currentState?.validate();
          if (isValid == true) {
            _formKey.currentState?.save();
            try {
              final result = await AuthRepository().verifyEmail(
                  email: _formKey.currentState?.fields['email']?.value);
              if (result == 200) {
                Map<String, String> body = {
                  'email': _formKey.currentState?.fields['email']?.value,
                  'password': _formKey.currentState?.fields['password']?.value,
                  'username': _formKey.currentState?.fields['username']?.value,
                };
                // ignore: use_build_context_synchronously
                context.push('/flowOne',
                    extra: {'signUpBody': body}); //allow back button
                // ignore: use_build_context_synchronously
                AppSnackBar.buildTopSnackBar(
                    context,
                    'Đã gửi thành công mã xác nhận',
                    null,
                    SnackBarType.success);
              } else {
                // ignore: use_build_context_synchronously
                AppSnackBar.buildSnackbar(
                    context, 'Email đã được sử dụng', null, SnackBarType.error);

                _formKey.currentState?.reset();
              }
            } on Exception catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }
          }
        });
  }

  Widget _linkToLoginScreen() {
    return GestureDetector(
      onTap: () {
        context.go('/login');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Đã có tài khoản?',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            ' Đăng nhập',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold, color: Color(0xFF439A97)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FormBuilder(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 16.0,
                        ),
                        AppTextInputField(
                          name: 'username',
                          hintText: 'Tên đăng nhập',
                          isRequired: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Không được để trống'),
                            FormBuilderValidators.maxLength(25,
                                errorText: 'Tên đăng nhập tối đa 25 ký tự')
                          ]),
                          minLines: 1,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        AppTextInputField(
                            name: 'email',
                            hintText: 'Email',
                            isRequired: true,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'Không được để trống'),
                              FormBuilderValidators.email(
                                  errorText: 'Email sai định dạng')
                            ])),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AppTextInputField(
                                  name: 'password',
                                  hintText: 'Nhập mật khẩu',
                                  isRequired: true,
                                  onChangeCallback: (value) {
                                    setState(() {
                                      pass = value;
                                    });
                                  },
                                  textInputType: TextInputType
                                      .visiblePassword, //password cannot multi line
                                  maxLines: null,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Không được để trống'),
                                    FormBuilderValidators.minLength(8,
                                        errorText: 'Mật khẩu tối thiểu 8 ký tự')
                                  ])),
                              const SizedBox(
                                height: 16.0,
                              ),
                              AppTextInputField(
                                  name: 'confirm',
                                  hintText: 'Nhập lại mật khẩu',
                                  isRequired: true,
                                  textInputType: TextInputType
                                      .visiblePassword, //password cannot multi line
                                  maxLines: null,
                                  validator: (val) {
                                    if (val !=
                                        _formKey.currentState
                                            ?.fields['password']?.value) {
                                      return 'Sai mật khẩu xác nhận';
                                    }
                                    return null;
                                  }),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ])),
                    FormBuilderCheckbox(
                      activeColor: appColors.primaryBase,
                      name: 'checkbox',
                      title: Text(
                        'Tôi đã đọc và đồng ý với các điều khoản và điều kiện',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      validator: FormBuilderValidators.required(
                          errorText: 'Đồng ý để đi tiếp'),
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: _submitButton()),
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
