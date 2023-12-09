import 'dart:io';

import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/report_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_img_picker.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ReportDialog extends StatefulWidget {
  final String reportType;
  final String reportId;

  ReportDialog({super.key, required this.reportType, required this.reportId});

  static const REPORT_TYPE_MAP = {
    'COMMENT': 'Bình luận',
    'STORY': 'Truyện',
    'USER': 'Người dùng'
  };

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  handleCreateReport(BuildContext context) async {
    try {
      Map<String, String> body = {};

      const storage = FlutterSecureStorage();
      final jwtToken = await storage.read(key: 'jwt');
      final userId = JwtDecoder.decode(jwtToken as String)['user_id'];
      body['user_id'] = userId;
      body['title'] = _formKey.currentState?.fields['title']?.value;
      body['description'] = _formKey.currentState?.fields['description']?.value;
      body['report_type'] = widget.reportType;
      body['reported_id'] = widget.reportId;
      await ReportRepository.addReport(body, selectImg);

      // ignore: use_build_context_synchronously
      await AppSnackBar.buildTopSnackBar(
          context, 'Tạo thành công', null, SnackBarType.success);
      context.pop();
    } catch (error) {
      // ignore: use_build_context_synchronously
      AppSnackBar.buildTopSnackBar(
          context, 'Tạo thất bại', null, SnackBarType.error);
      context.pop();
    }
  }

  File? selectImg;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      scrollable: true,
      title: Column(children: [
        Text(
          'Báo cáo ${ReportDialog.REPORT_TYPE_MAP[widget.reportType]} này',
          style: textTheme.titleLarge?.copyWith(color: appColors.inkDarkest),
        ),
        // Text(
        //   'Giúp chúng tôi điền vài thông tin nhé',
        //   style: textTheme.bodyMedium
        //       ?.copyWith(
        //           color: appColors
        //               ?.inkLight),
        //   textAlign: TextAlign.center,
        // )
      ]),
      content: SizedBox(
        width: size.width / 2,
        // height: size.height / 2.8,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: size.width / 4,
                  child: AppImagePicker(
                    width: size.width / 3,
                    height: size.width / 2.7,
                    callback: (img) {
                      setState(() {
                        selectImg = File(img?.path);
                      });
                    },
                  )),
              AppTextInputField(
                sizeBoxHeight: 0,
                hintText: 'Đặt tiêu đề cho báo cáo',
                name: 'title',
                validator: FormBuilderValidators.required(
                    errorText: 'Không được để trống'),
              ),
              const SizedBox(height: 12),
              AppTextInputField(
                isTextArea: true,
                maxLengthCharacters: 200,
                minLines: 2,
                maxLines: 5,
                hintText:
                    'Ví dụ: ${ReportDialog.REPORT_TYPE_MAP[widget.reportType]} này có nội dung kích động',
                name: 'description',
                validator: FormBuilderValidators.required(
                    errorText: 'Không được để trống'),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1, color: appColors.primaryBase),
                    ),
                    child: Text(
                      'Hủy',
                      style: textTheme.titleMedium
                          ?.copyWith(color: appColors.primaryBase),
                    ),
                  ),
                  FilledButton(
                    onPressed: _formKey.currentState?.validate() == true
                        ? () {
                            //check if input validate
                            final isValid = _formKey.currentState?.validate();

                            if (isValid != null && isValid) {
                              _formKey.currentState?.save();
                              handleCreateReport(context);
                            }
                            // context.pop();
                          }
                        : null,
                    child: Text(
                      'Tạo',
                      textAlign: TextAlign.end,
                      style: textTheme.titleMedium?.copyWith(
                          color: _formKey.currentState?.validate() == true
                              ? Colors.white
                              : appColors.inkLighter),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
