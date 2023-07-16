import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/user-avatar.jpg'),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                        height: 10,
                      ),
                      Column(
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
                ])));
  }
}
