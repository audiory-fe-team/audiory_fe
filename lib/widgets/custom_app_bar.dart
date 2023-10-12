import 'package:flutter/material.dart';

import '../theme/theme_constants.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  //define 2 appbar
  bool? hasAppBar; //default has an appbar
  static const _defaultWidget = Text('');
  Widget? leading; //can be null
  Widget? title; //can be null
  List<Widget>? actions; //use list of icon button
  double? height; //can be null, default is 50

  //decoration
  double? elevation;
  Color? bgColor;
  CustomAppBar(
      {super.key,
      this.hasAppBar = true,
      this.leading,
      this.title = _defaultWidget,
      this.actions = const [],
      this.height = 50,
      this.bgColor,
      this.elevation});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    return hasAppBar!
        ? AppBar(
            centerTitle: true, //center the title widget
            elevation: elevation ?? 2,
            backgroundColor: bgColor,
            leading: leading,
            title: title ??
                Container(
                  child: title,
                ),
            actions: actions,
            // shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(30),
            //         bottomRight: Radius.circular(30))),
          )
        : const Text('');
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
