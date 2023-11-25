import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';

appStoryActionsMenu(context) {
  final AppColors appColors = Theme.of(context).extension<AppColors>()!;

  return [
    const PopupMenuItem(
        padding: EdgeInsets.symmetric(horizontal: 20),
        value: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.edit),
            SizedBox(
              width: 10,
            ),
            Text('Chỉnh sửa'),
          ],
        )),
    PopupMenuItem(
        padding: EdgeInsets.symmetric(horizontal: 20),
        value: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.delete,
              color: appColors.secondaryBase,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Xóa',
              style: TextStyle(color: appColors.secondaryBase),
            ),
          ],
        )),
  ];
}
