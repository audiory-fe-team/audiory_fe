import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppAlertDialog extends StatefulWidget {
  final String? title;
  final String? content;
  final Widget? customContent;

  final String? actionText;
  final Function()? actionCallBack;
  final Widget? actionButton;

  final String? cancelText;
  final Widget? cancelButton;
  const AppAlertDialog(
      {super.key,
      this.title,
      this.content,
      this.customContent,
      this.actionButton,
      this.cancelButton,
      this.actionText = 'Xác nhận',
      this.cancelText = 'Hủy',
      this.actionCallBack});

  @override
  State<AppAlertDialog> createState() => _AppAlertDialogState();
}

class _AppAlertDialogState extends State<AppAlertDialog> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      title: Text(widget.title ?? "Tiêu đề"),
      content: widget.customContent ??
          Text(
            widget.content ?? "Nội dung hộp thoại",
            textAlign: TextAlign.justify,
          ),
      actions: [
        widget.cancelButton ??
            TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  widget.cancelText ?? 'Hủy',
                  style: textTheme.titleMedium,
                )),
        widget.actionButton ??
            AppIconButton(
              onPressed: widget.actionCallBack ??
                  () {
                    context.pop();
                  },
              title: widget.actionText ?? 'Xác nhận',
              textStyle:
                  textTheme.titleMedium?.copyWith(color: appColors.skyLightest),
            )
      ],
    );
  }
}
