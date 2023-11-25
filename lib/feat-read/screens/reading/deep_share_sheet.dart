import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';

class DeepShareSheet extends HookWidget {
  final String appRoutePath;
  const DeepShareSheet({super.key, required this.appRoutePath});

  static const pageSize = 10;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final url = 'http://audiory.com$appRoutePath';

    handleCopy() {
      Clipboard.setData(ClipboardData(text: url));
      AppSnackBar.buildTopSnackBar(
          context, 'Đã sao chép', null, SnackBarType.success);
    }

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: appColors.skyBase,
                width: 0.5,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 20),
              Text(
                'Chia sẻ ngay',
                style: textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
              IconButton(
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close_outlined, size: 18)),
            ],
          )),
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: appColors.primaryLightest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      url,
                      style: textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
              const SizedBox(width: 8),
              InkWell(
                overlayColor:
                    MaterialStatePropertyAll(appColors.primaryLightest),
                customBorder: const CircleBorder(),
                onTap: () {
                  handleCopy();
                },
                child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.copy_all_rounded,
                        color: appColors.skyBase, size: 24)),
              ),
            ],
          ))
    ]);
  }
}
