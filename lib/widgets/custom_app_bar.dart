import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  //define 2 appbar
  bool? hasAppBar; //default has an appbar
  static const _defaultWidget = Text('');
  Widget? leading; //can be null
  Widget? title; //can be null
  List<Widget>? actions; //use list of icon button
  double? height; //can be null, default is 50

  CustomAppBar(
      {super.key,
      this.hasAppBar = true,
      this.leading,
      this.title = _defaultWidget,
      this.actions = const [],
      this.height = 50});

  @override
  Widget build(BuildContext context) {
    return hasAppBar!
        ? AppBar(
            leading: leading,
            title: title ??
                Container(
                  child: title,
                ),
            actions: actions,
          )
        : Text('');
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
