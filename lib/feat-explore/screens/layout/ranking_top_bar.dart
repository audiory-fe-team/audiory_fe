import 'package:audiory_v0/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RankingTopBar extends StatelessWidget implements PreferredSizeWidget {
  const RankingTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
            elevation: 2,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.white,
                child: Stack(children: [
                  SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            "assets/images/home_ranking.png",
                            width: 24,
                          ),
                          const SizedBox(width: 4),
                          // GradientText('Bảng xếp hạng',
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .headlineMedium!
                          //         .copyWith(fontSize: 20),
                          //     gradient: LinearGradient(colors: [
                          //       const Color.fromARGB(255, 219, 168, 40),
                          //       Colors.yellow.shade400,
                          //     ])),
                          Text(
                            'Bảng xếp hạng',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 20),
                          ),
                          const SizedBox(width: 4),
                          Image.asset(
                            "assets/images/home_ranking.png",
                            width: 24,
                          ),
                        ],
                      )))
                ]))));
  }
}
