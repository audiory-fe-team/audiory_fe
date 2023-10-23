import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final String iconName;
  final Function onPressed;

  const ActionButton(
      {super.key,
      required this.title,
      required this.iconName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
          backgroundColor: appColors.primaryLightest,
          minimumSize: Size.zero, // Set this
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          alignment: Alignment.center // and this
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/$iconName.svg',
            width: 12,
            height: 12,
            color: appColors.secondaryBase,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                color: appColors.inkBase),
          )
        ],
      ),
    );
  }
}
