import 'dart:convert';

import 'package:audiory_v0/repositories/notification_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/models/AuthUser.dart';

class HomeTopBar extends HookWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final myInfoQuery =
        useQuery(['myInfo'], () => AuthRepository().getMyUserById());
    Widget userInfo(UseQueryResult<AuthUser, dynamic> myInfoQuery) {
      print('user data: ${myInfoQuery.data}');
      return Row(
        children: [
          Material(
            child: Skeletonizer(
              enabled: myInfoQuery.isFetching,
              child: InkWell(
                onTap: () async {
                  context.push('/profile');
                },
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: myInfoQuery.data?.avatarUrl == null
                      ? Image.network(
                          'https://play-lh.googleusercontent.com/MDmnqZ0E9abxJhYIqyRUtumShQpunXSFTRuolTYQh-zy4pAg6bI-dMAhwY5M2rakI9Jb=w800-h500-rw',
                          width: 40,
                          height: 40,
                        )
                      : Image.network(
                          '${myInfoQuery.data?.avatarUrl}',
                          width: 40,
                          height: 40,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.network(
                            'https://play-lh.googleusercontent.com/MDmnqZ0E9abxJhYIqyRUtumShQpunXSFTRuolTYQh-zy4pAg6bI-dMAhwY5M2rakI9Jb=w800-h500-rw',
                            width: 40,
                            height: 40,
                          ),
                        ),
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
              Skeletonizer(
                enabled: myInfoQuery.isFetching,
                child: Text(
                  myInfoQuery.data?.username ?? 'Người dùng',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
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
                  userInfo(myInfoQuery),
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
                      Stack(children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            onPressed: () {
                              GoRouter.of(context).push('/notification');
                            },
                            icon: const Icon(Icons.notifications_outlined,
                                size: 24)),
                        FutureBuilder(
                            future: NotificationRepostitory.fetchNoties(
                                offset: 0, limit: 10000000),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data?.isNotEmpty == true) {
                                return Positioned(
                                    top: 5,
                                    right: 7,
                                    child: Container(
                                      width: 6,
                                      height: 6,
                                      decoration: ShapeDecoration(
                                          color: appColors.secondaryBase,
                                          shape: const CircleBorder()),
                                    ));
                              }
                              return const SizedBox();
                            })
                      ]),
                    ],
                  ),
                ])));
  }
}
