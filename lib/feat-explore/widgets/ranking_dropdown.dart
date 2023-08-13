import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class RankingDropdownWrapper extends StatelessWidget {
  final String title;
  final Widget child; // Define a child property for the DropdownButton

  const RankingDropdownWrapper(
      {super.key, required this.child, this.title = ''});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Container(
        height: 30,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: appColors.skyLightest,
        ),
        child: Row(children: [
          Text(title, style: textTheme.titleSmall),
          DropdownButtonHideUnderline(child: child)
        ]));
  }
}
