import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CircularButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bgColor;
  final double size;

  // final Function onPressed;
  const CircularButton({
    super.key,
    required this.icon,
    required this.size,
    required this.color,
    required this.bgColor,
    // required this.onPressed
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(16)),
        backgroundColor: MaterialStateProperty.all(bgColor), // <-- Button color
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed))
            return Colors.red; // <-- Splash color
        }),
      ),
      child: Icon(icon, color: color, size: size),
    );
  }
}
