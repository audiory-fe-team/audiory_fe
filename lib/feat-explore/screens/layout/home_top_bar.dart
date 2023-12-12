import 'package:audiory_v0/feat-manage-profile/screens/messages/messages_list_screen.dart';
import 'package:audiory_v0/providers/global_me_provider.dart';
import 'package:audiory_v0/repositories/conversation_repository.dart';
import 'package:audiory_v0/repositories/notification_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/models/AuthUser.dart';

class HomeTopBar extends HookConsumerWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final currentUserId = ref.watch(globalMeProvider)?.id;

    final myInfoQuery = useQuery(
        ['myInfo', currentUserId], () => AuthRepository().getMyUserById(),
        refetchOnMount: RefetchOnMount.stale,
        cacheDuration: const Duration(minutes: 5));

    final conversationsQuery = useQuery(['conversations', currentUserId],
        () => ConversationRepository().fetchAllConversations(),
        refetchOnMount: RefetchOnMount.stale,
        cacheDuration: const Duration(minutes: 5));
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
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  barrierColor: Colors.white,
                                  enableDrag: false,
                                  useRootNavigator: true,
                                  builder: (context) {
                                    return MessagesListScreen(
                                      userId: currentUserId ?? '',
                                      refetch: conversationsQuery.refetch,
                                    );
                                  });
                            },
                            icon:
                                const Icon(Icons.messenger_outline, size: 22)),
                        conversationsQuery.data
                                    ?.where((element) =>
                                        element.isLatestMessageRead == false)
                                    .isNotEmpty ??
                                false
                            ? Positioned(
                                top: 5,
                                right: 5,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: ShapeDecoration(
                                      color: appColors.secondaryBase,
                                      shape: const CircleBorder()),
                                ))
                            : SizedBox(
                                height: 0,
                              ),
                        // FutureBuilder(
                        //     future: ConversationRepository()
                        //         .fetchAllConversations(offset: 0, limit: 100),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasData &&
                        //           snapshot.data?.isNotEmpty == true &&
                        //           snapshot.data!
                        //               .where(
                        //                   (e) => e.isLatestMessageRead == false)
                        //               .isNotEmpty) {
                        //         print('has unread');
                        //         return Positioned(
                        //             top: 5,
                        //             right: 5,
                        //             child: Container(
                        //               width: 8,
                        //               height: 8,
                        //               decoration: ShapeDecoration(
                        //                   color: appColors.secondaryBase,
                        //                   shape: const CircleBorder()),
                        //             ));
                        //       } else {
                        //         print('note');
                        //       }
                        //       return const SizedBox();
                        //     })
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
