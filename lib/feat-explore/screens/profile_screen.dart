import 'dart:math';

import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/core/shared_preferences/helper.dart';
import 'package:audiory_v0/feat-manage-profile/layout/profile_scroll_list.dart';
import 'package:audiory_v0/feat-manage-profile/layout/reading_scroll_list.dart';
import 'package:audiory_v0/layout/not_found_screen.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/author-story/author_story_model.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/reading-list/reading_list_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/conversation_repository.dart';
import 'package:audiory_v0/repositories/interaction_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppProfileScreen extends StatefulHookWidget {
  final String id;
  final String? name;
  final String? avatar;
  const AppProfileScreen(
      {super.key,
      this.name = 'Tên tác giả',
      this.avatar = '',
      required this.id});

  @override
  State<AppProfileScreen> createState() => _AppProfileScreenState();
}

class _AppProfileScreenState extends State<AppProfileScreen>
    with TickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  AuthUser? currentUser;

  late TabController tabController;
  int tabState = 0;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  Widget introView(List<Story>? story, List<ReadingList>? readingList,
      List<Profile>? followingList) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    Widget titleWithLink(String? title, String? link, String? subTitle,
        dynamic navigateFunc, double? marginBottom) {
      return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? 'Tiêu đề',
              style: textTheme.headlineMedium,
            ),
            GestureDetector(
                onTap: () {
                  navigateFunc;
                },
                child: Text(link ?? 'link',
                    style: textTheme.titleMedium?.copyWith(
                        color: appColors.primaryBase,
                        decoration: TextDecoration.underline))),
          ],
        ),
        subTitle != null
            ? SizedBox(
                width: double.infinity,
                child: Text(
                  subTitle,
                  textAlign: TextAlign.left,
                  style: textTheme.titleMedium?.copyWith(
                    color: appColors.inkLighter,
                  ),
                ),
              )
            : const SizedBox(
                height: 0,
              ),
        SizedBox(height: marginBottom ?? 0),
      ]);
    }

    Widget followingCard() {
      return Column(
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://res.cloudinary.com/ddvdxx85g/image/upload/v1678858100/samples/animals/cat.jpg'),
                fit: BoxFit.fill,
              ),
              shape: CircleBorder(),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Tác giả X',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
              height: 20,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/person.svg',
                    width: 12,
                    color: appColors.inkLighter,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '1,805 k',
                    style: textTheme.titleSmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: appColors.inkLighter),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ))
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              if (story?.isEmpty == false) ...[
                titleWithLink(
                    'Tác phẩm', 'Thêm', '${story?.length ?? 0} tác phẩm', () {
                  context.go('/');
                }, 12),
                //this single child call null
                story != null
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: story
                              .take(min(story.length, 10))
                              .map((story) => Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: SizedBox(
                                        width: size.width - 5,
                                        child: StoryCardDetail(story: story)),
                                  ))
                              .toList(),
                        ))
                    : Skeletonizer(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: []
                                  .map((story) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: SizedBox(
                                            width: size.width - 5,
                                            child: const StoryCardDetail(
                                                story: null)),
                                      ))
                                  .toList(),
                            ))),
              ],
              const SizedBox(
                height: 16,
              ),
              if (readingList?.isEmpty == false) ...[
                titleWithLink('Danh sách đọc', 'Thêm',
                    '${readingList?.length ?? '0'} danh sách', () {
                  context.go('/');
                }, 12),
                ReadingScrollList(readingList: readingList),
                const SizedBox(
                  height: 16,
                ),
              ],
              if (followingList?.isEmpty == false) ...[
                titleWithLink(
                    'Đang theo dõi', 'Thêm', '${followingList?.length} hồ sơ',
                    () {
                  context.go('/');
                }, 12),
                followingList != null
                    ? ProfileScrollList(profileList: followingList)
                    : const SizedBox(
                        height: 0,
                      ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget interactionInfo(
      int? numOfStories, int? numOfReadingList, int? numOfFollowers) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final sharedNumberStyle =
        textTheme.titleLarge!.copyWith(color: appColors.inkLight);
    final sharedHeaderStyle = textTheme.titleLarge;
    final sharedTitleStyle = textTheme.titleMedium;

    Widget interactionItem(String title, data) {
      return Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              data,
              style: sharedHeaderStyle,
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 20,
              child: Center(
                child: Text(
                  (title).toString(),
                  style: textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      );
    }

    return IntrinsicHeight(
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          if (numOfStories != 0) ...[
            interactionItem('Tác phẩm', '${numOfStories ?? '0'}'),
            const VerticalDivider(),
          ],
          interactionItem('Danh sách đọc', '${numOfReadingList ?? '0'}'),
          const VerticalDivider(),
          interactionItem('Người theo dõi', '${numOfFollowers ?? '0'}'),
          // const VerticalDivider(),
          // interactionItem('Bình luận', '40'),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final userByIdQuery =
        useQuery(['user'], () => AuthRepository().getMyUserById());
    final profileQuery = useQuery(
      ['otherProfile', widget.id],
      () => AuthRepository().getOtherUserProfile(widget.id),
    ); // include followers
    final publishedStoriesQuery = useQuery(
        ['publishedStories', widget.id],
        enabled: profileQuery.data != null,
        () => StoryRepostitory()
            .fetchPublishedStoriesByUserId(widget.id)); //userId=me
    final readingStoriesQuery = useQuery(
        ['readingStories', widget.id],
        enabled: profileQuery.data != null,
        () => StoryRepostitory().fetchReadingStoriesByUserId(widget.id));
    final isFollowUser = useState(false);
    final conversationsQuery = useQuery(
        ['conversations'],
        enabled: profileQuery.data != null,
        () => ConversationRepository().fetchAllConversations());

    useEffect(() {
      isFollowUser.value = profileQuery.data?.isFollowed ?? false;
      return () {};
    }, [profileQuery.data]);
    handleFollow({bool isFollowed = false}) async {
      print('IS FOLLOW ${isFollowed}');
      if (!isFollowed) {
        try {
          await InteractionRepository()
              .follow(widget.id)
              .then((res) => {print(res)});
          isFollowUser.value = true;
          // profileQuery.refetch();
        } catch (e) {}
      } else {
        try {
          await InteractionRepository()
              .unfollow(widget.id)
              .then((res) => {print(res)});
          isFollowUser.value = false;
          // profileQuery.refetch();
        } catch (e) {}
      }
    }

    print(
        'LEVEL ${profileQuery.data?.levelId} , AUTHOR LEVEL ${profileQuery.data?.authorLevelId}');

    Widget userProfileInfo(
        UseQueryResult<AuthUser?, dynamic> userByIdQuery,
        UseQueryResult<Profile?, dynamic> profileQuery,
        UseQueryResult<List<Story>?, dynamic> publishedStoriesQuery,
        UseQueryResult<List<ReadingList>?, dynamic> readingStoriesQuery) {
      final isFollowed = profileQuery.data?.isFollowed ?? false;
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;
      final size = MediaQuery.of(context).size;
      final textTheme = Theme.of(context).textTheme;
      roundBalance(balance) {
        return double.parse(balance.toString()).toStringAsFixed(0);
      }

      return RefreshIndicator(
        onRefresh: () async {
          profileQuery.refetch();
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Skeletonizer(
                  enabled: profileQuery.isFetching,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          opacity: 0.6,
                          image: CachedNetworkImageProvider(
                              profileQuery.data?.backgroundUrl == ''
                                  ? FALLBACK_BACKGROUND_URL
                                  : profileQuery.data?.backgroundUrl ??
                                      FALLBACK_BACKGROUND_URL),
                          fit: BoxFit.fill,
                        )),
                        child: Column(
                          children: [
                            Skeletonizer(
                                enabled: profileQuery.isFetching,
                                child: AppAvatarImage(
                                  url: widget.avatar,
                                  size: 100,
                                  hasLevel: profileQuery
                                              .data?.isAuthorFlairSelected ==
                                          true
                                      ? false
                                      : true,
                                  levelId: profileQuery.data?.levelId ?? 1,
                                  hasAuthorLevel: profileQuery
                                          .data?.isAuthorFlairSelected ==
                                      true,
                                  authorLevelId:
                                      profileQuery.data?.authorLevelId ?? 1,
                                )),
                            const SizedBox(height: 8),
                            Text(
                              widget.name ?? 'Họ và tên',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Skeletonizer(
                              enabled: profileQuery.isFetching,
                              child: Text(
                                '@${profileQuery.data?.username ?? 'Tên đăng nhập'}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Skeletonizer(
                              enabled: profileQuery.isFetching,
                              child: Container(
                                width: 180,
                                child: AppIconButton(
                                    isOutlined: isFollowUser.value == true
                                        ? true
                                        : false,
                                    bgColor: isFollowUser.value == true
                                        ? appColors.skyLightest
                                        : appColors.inkBase,
                                    color: isFollowUser.value == true
                                        ? appColors.inkBase
                                        : appColors.skyLightest,
                                    title: isFollowUser.value == true
                                        ? 'Đang theo dõi'
                                        : 'Theo dõi',
                                    textStyle: textTheme.titleMedium?.copyWith(
                                      color: isFollowUser.value == true
                                          ? appColors.inkBase
                                          : appColors.skyLightest,
                                    ),
                                    icon: Icon(
                                      isFollowUser.value == true
                                          ? Icons.check
                                          : Icons.add,
                                      color: isFollowUser.value == true
                                          ? appColors.inkBase
                                          : appColors.skyLightest,
                                      size: 24,
                                    ),
                                    // icon: const Icon(Icons.add),
                                    onPressed: () {
                                      handleFollow(
                                          isFollowed: isFollowUser.value ??
                                              profileQuery.data?.isFollowed ??
                                              false);
                                    }),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(children: [
                          const SizedBox(height: 16),
                          Skeletonizer(
                            enabled: publishedStoriesQuery.isFetching ||
                                readingStoriesQuery.isFetching,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: interactionInfo(
                                publishedStoriesQuery.data?.length,
                                readingStoriesQuery.data?.length,
                                profileQuery.data?.numberOfFollowers,
                              ),
                            ),
                          ),
                          // descrition
                          const SizedBox(height: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Skeletonizer(
                                enabled: profileQuery.isFetching,
                                child: profileQuery.data?.description != null
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width / 9),
                                        child: Divider(
                                          thickness: 1.2,
                                          color: appColors.inkLighter,
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 0,
                                      ),
                              ),
                              Skeletonizer(
                                enabled: profileQuery.isFetching,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    profileQuery.data?.description == null ||
                                            profileQuery.data?.description == ""
                                        ? 'Nhập gì đó về bạn'
                                        : profileQuery.data?.description ?? '',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Skeletonizer(
                                enabled: profileQuery.isFetching,
                                child: profileQuery.data?.description != null
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width / 4),
                                        child: Divider(
                                          thickness: 1.2,
                                          color: appColors.inkLighter,
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 0,
                                      ),
                              ),
                            ],
                          ),
                          //tab
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 0),
                            child: TabBar(
                              onTap: (value) {
                                setState(() {
                                  tabState = value;
                                });
                              },
                              controller: tabController,
                              labelColor: appColors.primaryBase,
                              // overlayColor: appColors.skyBase,
                              unselectedLabelColor: appColors.inkLight,
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              indicatorColor: appColors.primaryBase,
                              labelStyle: textTheme.titleLarge,
                              tabs: const [
                                Tab(
                                  text: 'Giới thiệu',
                                ),
                                Tab(
                                  text: 'Thông báo',
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                      Builder(builder: (context) {
                        if (tabState == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: introView(
                                publishedStoriesQuery.data,
                                readingStoriesQuery.data,
                                profileQuery.data?.followings ?? []),
                          );
                        } else {
                          return Text('alo');
                        }
                        return Skeletonizer(
                            enabled: false, child: introView([], [], []));
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    handleBlock() async {
      context.pop();
      try {
        final res = await InteractionRepository().block(widget.id);

        AppSnackBar.buildTopSnackBar(
            context, 'Chặn thành công', null, SnackBarType.success);
      } catch (e) {}
    }

    handleMute() async {
      context.pop();
      try {
        final res = await InteractionRepository().block(widget.id);

        AppSnackBar.buildTopSnackBar(
            context, 'Dừng tương tác thành công', null, SnackBarType.success);
      } catch (e) {}
    }

    return profileQuery.data == null && profileQuery.isSuccess
        ? NotFoundScreen()
        : Scaffold(
            appBar: CustomAppBar(
              leading: null,
              height: 60,
              title: Text(
                'Hồ sơ ',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: appColors.inkBase),
              ),
              actions: [
                PopupMenuButton(
                    position: PopupMenuPosition.under,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child:
                            Icon(Icons.more_horiz, color: appColors.inkDarker)),
                    onSelected: (value) {
                      if (value == 0) {
                        GoRouter.of(context).push('/profileSettings/messages',
                            extra: {'userId': widget.id});
                      }
                      if (value == 1) {
                        QuickAlert.show(
                          onCancelBtnTap: () {
                            Navigator.pop(context);
                          },
                          onConfirmBtnTap: () {
                            handleMute();
                          },
                          context: context,
                          type: QuickAlertType.confirm,
                          title:
                              'Xác nhận dừng tương tác người dùng ${widget.name == '' ? 'này' : widget.name}?',
                          titleAlignment: TextAlign.center,
                          confirmBtnText: 'Xác nhận',
                          cancelBtnText: 'Hủy',
                          confirmBtnColor: appColors.inkBase,
                          confirmBtnTextStyle: textTheme.bodyMedium
                              ?.copyWith(color: appColors.skyLightest),
                        );
                      }
                      if (value == 2) {
                        QuickAlert.show(
                          onCancelBtnTap: () {
                            Navigator.pop(context);
                          },
                          onConfirmBtnTap: () {
                            handleBlock();
                          },
                          context: context,
                          type: QuickAlertType.confirm,
                          title:
                              'Xác nhận chặn người dùng ${widget.name == '' ? 'này' : widget.name}?',
                          titleAlignment: TextAlign.center,
                          confirmBtnText: 'Xác nhận',
                          cancelBtnText: 'Hủy',
                          confirmBtnColor: appColors.inkBase,
                          confirmBtnTextStyle: textTheme.bodyMedium
                              ?.copyWith(color: appColors.skyLightest),
                        );
                      }
                      if (value == 3) {}
                    },
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              height: 36,
                              value: 0,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.mode_comment_outlined,
                                        size: 18, color: appColors.inkLighter),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Nhắn tin',
                                      style: textTheme.titleMedium,
                                    )
                                  ])),
                          PopupMenuItem(
                              height: 36,
                              value: 1,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.volume_mute_outlined,
                                        size: 18, color: appColors.inkLighter),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Dừng tương tác',
                                      style: textTheme.titleMedium,
                                    )
                                  ])),
                          PopupMenuItem(
                              height: 36,
                              value: 2,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.block,
                                        size: 18,
                                        color: appColors.secondaryBase),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Chặn',
                                      style: textTheme.titleMedium?.copyWith(
                                          color: appColors.secondaryBase),
                                    )
                                  ])),
                          PopupMenuItem(
                              height: 36,
                              value: 3,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.emoji_flags,
                                        size: 18,
                                        color: appColors.secondaryBase),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Báo cáo',
                                      style: textTheme.titleMedium?.copyWith(
                                          color: appColors.secondaryBase),
                                    )
                                  ])),
                        ]),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                profileQuery.refetch();
              },
              child: userProfileInfo(userByIdQuery, profileQuery,
                  publishedStoriesQuery, readingStoriesQuery),
            ),
          );
  }
}
