import 'package:audiory_v0/screens/home/home_top_bar.dart';
import 'package:audiory_v0/screens/reading/reading_top_bar.dart';
import 'package:audiory_v0/screens/search/search_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String path;

  const AppTopBar({super.key, this.path = '/'});

  @override
  Size get preferredSize => Size.fromHeight(65);

  Widget getTopBarContent() {
    switch (path) {
      case '/':
        return HomeTopBar();
      case '/search':
        return SearchTopBar();
      case '/story/1/chapter/1':
        return ReadingTopBar();
      default:
        return HomeTopBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: getTopBarContent());
  }
}
