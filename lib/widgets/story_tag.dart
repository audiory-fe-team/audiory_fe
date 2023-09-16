import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class StoryTag extends StatelessWidget {
  final String label;
  final bool selected;

  const StoryTag({super.key, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: ShapeDecoration(
        color: selected ? appColors.primaryBase : appColors.skyLighter,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: selected ? Colors.white : appColors.inkLight,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible),
      ),
    );
  }
}
