import 'dart:io';

import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/profile_repository.dart';
import 'package:audiory_v0/widgets/app_img_picker.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/theme_constants.dart';

class FLowFourScreen extends StatefulWidget {
  final String userId;
  const FLowFourScreen({super.key, required this.userId});

  @override
  State<FLowFourScreen> createState() => _FLowFourScreenState();
}

class _FLowFourScreenState extends State<FLowFourScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  File? selectImg;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(''),
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
          height: size.height,
          width: size.width,
          child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hoàn tất hồ sơ của bạn",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: appColors.inkDarkest)),
                    Text(
                        "Đây là tùy chọn, bạn có thể điền thêm thông tin để mọi người hiểu rõ về bạn hơn",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: appColors.inkLighter,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Center(
                            child: AppImagePicker(
                              callback: (img) {
                                setState(() {
                                  selectImg = File(img.path);
                                });
                              },
                              isRoundShape: true,
                              width: size.width / 3,
                            ),
                          ),
                        ),
                        const AppTextInputField(
                          name: 'full_name',
                          label: 'Họ và tên',
                          hintText: 'Nhập họ và tên',
                        ),
                        AppTextInputField(
                          name: 'description',
                          label: 'Giới thiệu',
                          hintText: 'Đôi lời về các hạ',
                          isTextArea: true,
                          maxLengthCharacters: 1000,
                          minLines: 5,
                          maxLines: 6,
                          validator: FormBuilderValidators.maxLength(1000,
                              errorText: 'Tối đa 1000 ký tự'),
                        ),
                      ]),
                ),
                SizedBox(
                  width: size.width - 32,
                  child: AppIconButton(
                    title: "Tiếp tục",
                    color: Colors.white,
                    bgColor: appColors.primaryBase,
                    onPressed: () async {
                      if (_formKey.currentState?.isValid == true) {
                        _formKey.currentState!.save();

                        Map<String, String> body = {};

                        body['full_name'] =
                            _formKey.currentState!.fields['full_name']?.value;
                        body['description'] =
                            _formKey.currentState!.fields['description']?.value;

                        //update new user data
                        Profile? updatedProfile = await ProfileRepository()
                            .updateNewUserProfile(
                                selectImg, body, widget.userId);

                        // ignore: use_build_context_synchronously
                        AppSnackBar.buildSnackbar(context, 'Hoàn tất đăng ký',
                            null, SnackBarType.success);
                        // ignore: use_build_context_synchronously
                        context.push('/login');
                      } else {
                        // ignore: use_build_context_synchronously
                        AppSnackBar.buildSnackbar(context, 'Hoàn tất đăng ký',
                            null, SnackBarType.success);
                        context.push('/login');
                      }
                    },
                  ),
                ),
              ]),
        ));
  }
}
