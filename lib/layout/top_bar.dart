import 'package:audiory_v0/screens/home/home_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String path;

  const AppTopBar({super.key, this.path = '/'});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget getTopBarContent() {
    switch (path) {
      case '/':
        return HomeTopBar();
      default:
        return HomeTopBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.amber,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: getTopBarContent())),
    );
  }
}
