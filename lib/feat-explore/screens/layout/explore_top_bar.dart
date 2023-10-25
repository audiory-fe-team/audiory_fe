import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ExploreTopBar extends StatelessWidget implements PreferredSizeWidget {
  const ExploreTopBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 58,
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
              Container(
                  width: double.infinity,
                  child: Center(
                      child: Text('Khám phá',
                          style: Theme.of(context).textTheme.headlineMedium))),
              Positioned(
                right: 0,
                top: 20,
                child: InkWell(
                    onTap: () {
                      GoRouter.of(context).go('/explore/search');
                    },
                    child: const Icon(Icons.search_rounded, size: 24)),
              )
            ])));
  }
}
