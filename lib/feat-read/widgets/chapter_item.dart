import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class ChapterItem extends StatelessWidget {
  final String title;
  final String time;
  const ChapterItem({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: appColors.skyLightest,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontStyle: FontStyle.italic, color: appColors.inkLighter),
          ),
        ],
      ),
    );
  }
}
