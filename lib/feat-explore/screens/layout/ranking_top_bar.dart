import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RankingTopBar extends StatelessWidget implements PreferredSizeWidget {
  const RankingTopBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
            child: Stack(children: [
              Container(
                  width: double.infinity,
                  child: Center(
                      child: Text('Bảng xếp hạng',
                          style: Theme.of(context).textTheme.headlineMedium))),
            ])));
  }
}
