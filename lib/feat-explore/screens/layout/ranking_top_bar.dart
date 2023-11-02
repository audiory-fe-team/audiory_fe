import 'package:flutter/material.dart';

class RankingTopBar extends StatelessWidget implements PreferredSizeWidget {
  const RankingTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 172, 136, 28),
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
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
            ])));
  }
}
