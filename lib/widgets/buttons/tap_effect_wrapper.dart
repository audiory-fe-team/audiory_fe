import 'package:flutter/material.dart';

class TapEffectWrapper extends StatelessWidget {
  final Widget child;
  final Function onTap;
  const TapEffectWrapper({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(child: InkWell(onTap: () => onTap(), child: child));
  }
}
