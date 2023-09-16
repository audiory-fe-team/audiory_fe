import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final EdgeInsetsGeometry? padding;
  final VisualDensity? visualDensity;
  final String? text;
  final TextStyle? textStyle;
  final Widget? child;

  const AppOutlinedButton({
    Key? key,
    this.onPressed,
    this.onLongPress,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.padding,
    this.visualDensity,
    this.text,
    this.textStyle,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = OutlinedButton.styleFrom(
      // Define your default button style here
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );

    final mergedStyle = defaultStyle.merge(style);

    return OutlinedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: mergedStyle,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      child: child ??
          Text(
            text ?? '',
            style: textStyle,
          ),
    );
  }
}
