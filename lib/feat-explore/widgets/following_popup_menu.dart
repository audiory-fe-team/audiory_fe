import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';

List<DropdownMenuItem> followingDropdownItems(BuildContext context) {
  final AppColors appColors = Theme.of(context).extension<AppColors>()!;
  final size = MediaQuery.of(context).size;
  final textTheme = Theme.of(context).textTheme;
  return [
    DropdownMenuItem(
      alignment: Alignment.center,
      value: 0,
      child: SizedBox(
        width: size.width / 2.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.notifications_active,
              color: appColors.inkBase,
            ),
            SizedBox(
              width: size.width / 3,
              child: Text(
                'Bật thông báo',
                style: textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    ),
    DropdownMenuItem(
      alignment: Alignment.center,
      value: 1,
      child: Container(
        width: size.width / 2.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              color: appColors.inkBase,
            ),
            SizedBox(
              width: size.width / 3,
              child: Text(
                'Tắt thông báo',
                style: textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    ),
    DropdownMenuItem(
      alignment: Alignment.center,
      value: 2,
      child: Container(
        width: size.width / 2.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.person_remove_alt_1_outlined,
              color: appColors.secondaryBase,
            ),
            SizedBox(
              width: size.width / 3,
              child: Text(
                'Bỏ theo dõi',
                style: textTheme.titleMedium
                    ?.copyWith(color: appColors.secondaryBase),
              ),
            ),
          ],
        ),
      ),
    ),
  ];
}
