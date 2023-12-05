import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';

appChapterPopupMenuItems(context, isDraft) {
  final AppColors appColors = Theme.of(context).extension<AppColors>()!;

  if (isDraft == true || isDraft == false) {
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
          value: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.public,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                isDraft == true ? 'Đăng tải' : 'Gỡ đăng tải ',
              ),
            ],
          )),
      PopupMenuItem(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          value: 2,
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        value: 1,
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

appPaywalledChapterPopupMenuItems(context) {
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
  ];
}
