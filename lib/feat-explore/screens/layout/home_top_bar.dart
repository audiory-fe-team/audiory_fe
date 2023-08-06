import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '/services/auth_services.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;

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
                  Row(
                    children: [
                      Material(
                        child: InkWell(
                          onTap: () async {
                            context.go('/profile');
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: user?.photoURL == null
                                ? Image.asset(
                                    'assets/images/user-avatar.jpg',
                                    width: 40,
                                    height: 40,
                                  )
                                : Image.network(
                                    user?.photoURL as String,
                                    width: 40,
                                    height: 40,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Xin chào',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            user?.email ?? 'Default email',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).go('/explore/search');
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
