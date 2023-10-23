import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? resetToken;
  const ResetPasswordScreen({
    super.key,
    this.resetToken,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Đặt mật khẩu mới ${widget.resetToken}',
                  style: textTheme.headlineMedium,
                ),
                Text(
                  'Đặt lại mật khẩu của bạn để có thể đăng nhập và trải nghiệm tất cả tính năng của Audiory ',
                  style:
                      textTheme.bodyMedium?.copyWith(color: appColors.inkLight),
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextInputField(
                  label: 'Mật khẩu mới',
                  name: 'newPassword',
                  hintText: 'Chứa ít nhất 8 ký tự',
                  textInputType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.length < 8) {
                      return 'Mật khẩu yêu cầu ít nhất 8 ký tự';
                    }
                  },
                ),
                AppTextInputField(
                  label: 'Xác nhận mật khẩu',
                  name: 'confirmPassword',
                  hintText: 'Chứa ít nhất 8 ký tự',
                  textInputType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.length < 8) {
                      return 'Mật khẩu yêu cầu ít nhất 8 ký tự';
                    } else {
                      String newPass =
                          _formKey.currentState?.fields['newPassword']?.value ??
                              '';
                      if (value != newPass) {
                        return 'Mật khẩu xác nhận không trùng khớp';
                      }
                    }
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: size.width,
                  child: AppIconButton(
                    title: 'Đặt lại mật khẩu',
                    onPressed: () async {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        try {
                          await AuthRepository().resetPassword(
                              resetToken: widget.resetToken ?? '',
                              password: _formKey
                                  .currentState?.fields['newPassword']?.value);

                          // ignore: use_build_context_synchronously
                          context.go('/login');

                          // ignore: use_build_context_synchronously
                          AppSnackBar.buildTopSnackBar(
                              context,
                              'Đặt lại mật khẩu thành công',
                              null,
                              SnackBarType.success);
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          AppSnackBar.buildTopSnackBar(
                              context,
                              'Đặt lại mật khẩu thất bại',
                              null,
                              SnackBarType.error);
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
