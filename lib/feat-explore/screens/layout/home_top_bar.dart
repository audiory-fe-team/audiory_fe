import 'package:audiory_v0/repositories/conversation_repository.dart';
import 'package:audiory_v0/repositories/notification_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
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
    final size = MediaQuery.of(context).size;
    final myInfoQuery = useQuery(
        ['myInfo'], () => AuthRepository().getMyUserById(),
        refetchOnMount: RefetchOnMount.always);
    Widget userInfo(UseQueryResult<AuthUser, dynamic> myInfoQuery) {
      return Row(
        children: [
          Material(
            color: Colors.transparent,
            child: Skeletonizer(
              enabled: myInfoQuery.isFetching,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: InkWell(
                  onTap: () async {
                    context.push('/profile');
                  },
                  child: AppAvatarImage(
                    url: myInfoQuery.data?.avatarUrl,
                    size: 40,
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
                child: SizedBox(
                  width: size.width / 2,
                  child: Text(
                    myInfoQuery.data?.username ?? 'Người dùng vãng lai',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                              myInfoQuery.data == null
                                  ? null
                                  : GoRouter.of(context).push(
                                      '/profileSettings/messages',
                                      extra: {'userId': myInfoQuery.data?.id});
                            },
                            icon:
                                const Icon(Icons.messenger_outline, size: 22)),
                        FutureBuilder(
                            future: ConversationRepository()
                                .fetchAllConversations(offset: 0, limit: 100),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data?.isNotEmpty == true &&
                                  snapshot.data!
                                          .where((e) =>
                                              e.lastMessage?.isRead == false)
                                          .length >
                                      0) {
                                return Positioned(
                                    top: 5,
                                    right: 5,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: ShapeDecoration(
                                          color: appColors.secondaryBase,
                                          shape: const CircleBorder()),
                                    ));
                              }
                              return const SizedBox();
                            })
                      ]),
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
                                      width: 8,
                                      height: 8,
                                      decoration: ShapeDecoration(
                                        color: appColors.secondaryBase,
                                        shape: const CircleBorder(),
                                      ),
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
