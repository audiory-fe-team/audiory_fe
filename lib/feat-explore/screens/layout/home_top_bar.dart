import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../../../models/AuthUser.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../repositories/auth_repository.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();
    UserServer? currentUser;
    User? authUser = AuthRepository().currentUser;

    Future<UserServer?> getUserDetails() async {
      String? value = await storage.read(key: 'currentUser');
      currentUser =
          value != null ? UserServer.fromJson(jsonDecode(value)['data']) : null;

      if (kDebugMode) {
        print('currentuser ${currentUser?.email}');
      }
      return currentUser;
    }

    Widget _userInfo(UserServer? user) {
      return Row(
        children: [
          Material(
            child: InkWell(
              onTap: () async {
                context.push('/profile');
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: authUser?.photoURL == null
                    ? Image.network(
                        'https://play-lh.googleusercontent.com/MDmnqZ0E9abxJhYIqyRUtumShQpunXSFTRuolTYQh-zy4pAg6bI-dMAhwY5M2rakI9Jb=w800-h500-rw',
                        width: 40,
                        height: 40,
                      )
                    : Image.network(
                        '${currentUser?.avatarUrl}',
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.network(
                          'https://play-lh.googleusercontent.com/MDmnqZ0E9abxJhYIqyRUtumShQpunXSFTRuolTYQh-zy4pAg6bI-dMAhwY5M2rakI9Jb=w800-h500-rw',
                          width: 40,
                          height: 40,
                        ),
                      ),
                // child: Image.asset(
                //   'assets/images/user-avatar.jpg',
                //   width: 40,
                //   height: 40,
                // ),
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
                currentUser?.username ?? 'Người dùng',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ],
      );
    }

    return SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 172, 136, 28),
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder<UserServer?>(
                    future: getUserDetails(), // async work
                    builder: (BuildContext context,
                        AsyncSnapshot<UserServer?> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Skeletonizer(
                            // ignore: unrelated_type_equality_checks
                            enabled: ConnectionState.waiting == true,
                            child: Text(''),
                          );

                        default:
                          if (snapshot.hasError) {
                            return _userInfo(null);
                          } else {
                            return _userInfo(snapshot.data ?? null);
                          }
                      }
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                          padding: EdgeInsets.zero,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onPressed: () {
                            GoRouter.of(context).push('/explore/search');
                          },
                          icon: const Icon(Icons.search_rounded, size: 24)),
                      IconButton(
                          padding: EdgeInsets.zero,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_outlined,
                              size: 24)),
                    ],
                  ),
                ])));
  }
}
