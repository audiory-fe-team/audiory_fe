import 'package:flutter/material.dart';

class OutlineBtn extends StatelessWidget {
  final String text;
  final Color color;
  final Color bgColor;
  final double size;
  final VoidCallback onPress;

  // final Function onPressed;
  const OutlineBtn(
      {super.key,
      required this.text,
      required this.size,
      required this.color,
      required this.bgColor,
      required this.onPress
      // required this.onPressed
      });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        minimumSize: Size(size, 48),
        elevation: 4.0,
      ),
      child: Text(text,
          style: TextStyle(
              color: color,
              fontFamily: 'Source San Pro',
              fontSize: 16.0,
              fontWeight: FontWeight.w500)),
    );
  }
}
