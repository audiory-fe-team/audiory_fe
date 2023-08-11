import 'package:flutter/material.dart';
import '../../theme/theme_constants.dart';

class AppIconButton extends StatelessWidget {
  //if there is no param , there is a default button with no icon, white title, primary color bgColor

  //content
  //thêm outline, animation ( hover, tap)
  //button width , height depends on container cover it

  final String? title;
  final TextStyle? textStyle;
  final Icon? icon; //icon ==null if there is no icon
  final String? iconPosition; //start, end, null
  final Color? color;
  final Color? bgColor;
  final VoidCallback onPressed;
  const AppIconButton(
      {super.key,
      this.title = 'Default',
      this.textStyle,
      this.icon,
      this.iconPosition,
      this.color,
      this.bgColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return LayoutBuilder(builder: (context, constraints) {
      if (icon != null) {
        if (iconPosition == 'start') {
          return ElevatedButton.icon(
            onPressed: onPressed,
            icon: icon as Icon,
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor ?? appColors.primaryBase,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              minimumSize: Size(double.minPositive, 48),
            ),
            label: Text(title == null ? 'Default' : title as String,
                style: textStyle == null
                    ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color != null ? color : appColors.skyLightest)
                    : textStyle),
          );
        } else {
          return ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor ?? appColors.primaryBase,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              minimumSize: const Size.fromHeight(48),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(title == null ? 'Default' : title as String,
                    style: textStyle == null
                        ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                color != null ? color : appColors.skyLightest)
                        : textStyle),
                const SizedBox(
                  width: 5,
                ),
                icon as Icon
              ],
            ),
          );
        }
      } else {
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor ?? appColors.primaryBase,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            minimumSize: Size(double.minPositive, 48),
          ),
          child: Text(title == null ? 'Default' : title as String,
              style: textStyle == null
                  ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: color != null ? color : appColors.skyLightest)
                  : textStyle),
        );
      }
    });
  }
}
