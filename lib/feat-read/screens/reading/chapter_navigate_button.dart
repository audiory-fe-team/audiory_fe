import 'package:audiory_v0/theme/theme_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChapterNavigateButton extends StatelessWidget {
  final bool next;
  final bool disabled;
  final Function onPressed;
  const ChapterNavigateButton(
      {super.key,
      this.next = false,
      required this.onPressed,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Expanded(
        child: FilledButton(
      onPressed: () {
        onPressed();
      },
      style: FilledButton.styleFrom(
          backgroundColor:
              disabled ? appColors.skyLighter : appColors.primaryBase,
          minimumSize: Size.zero, // Set this
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          alignment: Alignment.center // and this
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          !next
              ? SvgPicture.asset(
                  'assets/icons/left-arrow.svg',
                  width: 12,
                  height: 12,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            width: 4,
          ),
          Text(
            next ? 'Chương sau' : 'Chương trước',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(
            width: 4,
          ),
          next
              ? SvgPicture.asset(
                  'assets/icons/right-arrow.svg',
                  width: 12,
                  height: 12,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ],
      ),
    ));
  }
}
