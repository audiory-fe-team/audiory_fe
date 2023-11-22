import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

InputDecoration appInputDecoration(BuildContext context) {
  final AppColors appColors = Theme.of(context).extension<AppColors>()!;

  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    fillColor: appColors.skyLightest,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0), // Adjust the radius here
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appColors.skyBase, width: 1.0),
      borderRadius: BorderRadius.circular(100.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appColors.primaryBase, width: 1.0),
      borderRadius: BorderRadius.circular(100.0),
    ),
  );
}
