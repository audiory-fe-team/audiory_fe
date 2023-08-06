import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  //content
  //thêm outline, animation ( hover, tap)
  final String title;
  final TextStyle? textStyle;
  final Icon? icon; //icon ==null if there is no icon
  final String? iconPosition; //start, end, null
  final Color color;
  final Color bgColor;
  final VoidCallback onPressed;
  const AppIconButton(
      {super.key,
      required this.title,
      required this.textStyle,
      required this.icon,
      required this.iconPosition,
      required this.color,
      required this.bgColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (icon != null) {
        if (iconPosition == 'start') {
          return ElevatedButton.icon(
            onPressed: onPressed,
            icon: icon as Icon,
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              minimumSize: Size(double.minPositive, 48),
            ),
            label: Text(title, style: textStyle),
          );
        } else {
          return ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              minimumSize: Size(double.minPositive, 48),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(title, style: textStyle),
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
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            minimumSize: const Size(double.minPositive, 48),
          ),
          child: Text(title, style: textStyle),
        );
      }
    });
  }
}
