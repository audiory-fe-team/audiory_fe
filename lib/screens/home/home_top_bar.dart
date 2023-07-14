import 'package:audiory_v0/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                child: const CircleAvatar(
                  backgroundImage:
                      const AssetImage('assets/images/user-avatar.jpg'),
                ),
              ),
              const SizedBox(
                width: 8,
                height: 10,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Xin chào',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  GoRouter.of(context).go('/search');
                },
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                child: SvgPicture.asset(
                  'assets/icons/notification on.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ]);
  }
}
