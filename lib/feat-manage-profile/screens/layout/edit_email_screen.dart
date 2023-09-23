import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/AuthUser.dart';
import '../../../theme/theme_constants.dart';

class EditEmailScreen extends StatefulWidget {
  final UserServer? currentUser;
  const EditEmailScreen({super.key, this.currentUser});

  @override
  State<EditEmailScreen> createState() => _EditEmailScreenState();
}

class _EditEmailScreenState extends State<EditEmailScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          title: Text(
        'Sửa email ',
        style: textTheme.headlineMedium?.copyWith(color: appColors.inkDark),
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppTextInputField(
            name: 'email',
            textAlign: TextAlign.center,
            // label: 'Cập nhật email mới',
            initialValue: widget.currentUser?.email,
            hintText: 'email@gmail.com',
            isRequired: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              width: size.width - 32,
              child: AppIconButton(
                onPressed: () {
                  Map<String, String> body = {
                    'email': widget.currentUser?.email as String,
                    'full_name': widget.currentUser?.fullName as String,
                    'username': widget.currentUser?.username as String,
                  };
                  context.push('/flowTwo', extra: {'signUpBody': body});
                },
                title: 'Cập nhật',
              ),
            ),
          )
        ]),
      ),
    );
  }
}
