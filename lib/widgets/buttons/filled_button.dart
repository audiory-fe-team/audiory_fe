import "package:flutter/material.dart";

class AppFilledButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color bgColor;
  final VoidCallback onPressed;
  const AppFilledButton(
      {super.key,
      required this.title,
      required this.color,
      required this.bgColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        minimumSize: const Size(double.maxFinite, 48),
        elevation: 2.0,
      ),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: color, fontSize: 16)),
    );
  }
}
