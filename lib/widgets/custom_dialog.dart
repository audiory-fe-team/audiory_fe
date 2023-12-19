import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDialog extends StatefulWidget {
  final String? alertType; // success, fail, processing
  final String? content;

  final Widget? customContent;

  final String? actionText;
  final Function()? actionCallBack;
  final Widget? actionButton;

  final String? cancelText;
  final Widget? cancelButton;
  const CustomDialog(
      {super.key,
      this.content,
      this.customContent,
      this.actionButton,
      this.cancelButton,
      this.actionText = 'Xác nhận',
      this.cancelText = 'Hủy',
      this.actionCallBack,
      this.alertType = 'success'});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    Map<String, dynamic> dialogStatus() {
      String type = widget.alertType ?? 'success';
      Map<String, dynamic> map = {
        'title': 'Thành công',
        'image': 'assets/images/status_done.png',
      };
      if (type == 'processing') {
        map.update('title', (value) => 'Đang xử lý');
        map.update('image', (value) => 'assets/images/status_processing.png');
      } else if (type == 'failed') {
        map.update('title', (value) => 'Thất bại');
        map.update('image', (value) => 'assets/images/status_failed.png');
      }
      return map;
    }

    Map<String, dynamic> status = dialogStatus();

    return AlertDialog(
        // icon: Align(
        //   alignment: Alignment.centerRight,
        //   child: IconButton(
        //     icon: const Icon(Icons.highlight_remove_outlined),
        //     onPressed: () {
        //       context.pop();
        //     },
        //   ),
        // ),
        content: widget.customContent ??
            Container(
              height: size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                          widget.actionCallBack;
                        },
                        child: Icon(
                          Icons.highlight_remove_outlined,
                          color: appColors.inkLighter,
                        ),
                      )),
                  Image.asset(
                    status['image'],
                    height: widget.alertType == 'success' ? 100 : 70,
                    width: widget.alertType == 'success' ? 100 : 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 16),
                    child: Text(
                      status['title'],
                      textAlign: TextAlign.justify,
                      style: textTheme.headlineMedium,
                    ),
                  ),
                  Text(
                    widget.content ?? "Nội dung hộp thoại",
                    textAlign: TextAlign.justify,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: appColors.inkLighter),
                  ),
                ],
              ),
            )
        // actions: [
        //   widget.cancelButton ??
        //       TextButton(
        //           onPressed: () {
        //             context.pop();
        //           },
        //           child: Text(
        //             widget.cancelText ?? 'Hủy',
        //             style: textTheme.titleMedium,
        //           )),
        //   widget.actionButton ??
        //       AppIconButton(
        //         onPressed: widget.actionCallBack ??
        //             () {
        //               context.pop();
        //             },
        //         title: widget.actionText ?? 'Xác nhận',
        //         textStyle:
        //             textTheme.titleMedium?.copyWith(color: appColors.skyLightest),
        //       )
        // ],
        );
  }
}
