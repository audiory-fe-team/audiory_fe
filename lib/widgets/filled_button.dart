import "package:flutter/material.dart";

class ActionButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color bgColor;
  // final Function onPressed;
  const ActionButton({
    super.key,
    required this.title,
    required this.color,
    required this.bgColor,
    // required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF439A97),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 4.0,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
      ),
    );
  }
}
