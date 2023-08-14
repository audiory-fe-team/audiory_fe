import 'package:audiory_v0/screens/splash_screen/splash_screen.dart';
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
                      child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Padding(
                      //     padding: EdgeInsets.only(bottom: 4),
                      //     child: Image.asset('assets/images/crown.png',
                      //         width: 16)),
                      // const SizedBox(width: 4),
                      GradientText('Bảng xếp hạng',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: 20),
                          gradient: LinearGradient(colors: [
                            Colors.yellow.shade400,
                            Color.fromARGB(255, 219, 168, 40),
                          ])),
                      // const SizedBox(width: 4),
                      // Padding(
                      //     padding: EdgeInsets.only(bottom: 4),
                      //     child: Image.asset('assets/images/crown.png',
                      //         width: 16)),
                    ],
                  )))
            ])));
  }
}
