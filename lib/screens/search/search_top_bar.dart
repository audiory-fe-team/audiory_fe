import 'package:audiory_v0/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SearchTopBar extends StatelessWidget {
  const SearchTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white,
        child: Stack(children: [
          Container(
              width: double.infinity,
              child: Center(
                  child: Text('Tìm kiếm',
                      style: Theme.of(context).textTheme.headlineMedium))),
          Positioned(
            right: 0,
            top: 20,
            child: InkWell(
              onTap: () {
                GoRouter.of(context).go('/search');
              },
              child: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 24,
                height: 24,
              ),
            ),
          )
        ]));
  }
}
