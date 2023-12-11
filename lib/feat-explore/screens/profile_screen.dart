import 'dart:math';

import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/feat-explore/widgets/following_popup_menu.dart';
import 'package:audiory_v0/feat-manage-profile/layout/profile_scroll_list.dart';
import 'package:audiory_v0/feat-manage-profile/layout/reading_scroll_list.dart';
import 'package:audiory_v0/feat-manage-profile/screens/follow/followers_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/messages/detail_conversation_screen.dart';
import 'package:audiory_v0/feat-manage-profile/widgets/custom_wall_comment.dart';
import 'package:audiory_v0/layout/not_found_screen.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/conversation/conversation_model.dart';
import 'package:audiory_v0/models/enums/Report.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/reading-list/reading_list_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/models/wall-comment/wall_comment_model.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/conversation_repository.dart';
import 'package:audiory_v0/repositories/interaction_repository.dart';
import 'package:audiory_v0/repositories/profile_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/utils/widget_helper.dart';
import 'package:audiory_v0/widgets/app_alert_dialog.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/report_dialog.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppProfileScreen extends StatefulHookWidget {
  final String id;

  const AppProfileScreen({super.key, required this.id});

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
        Function()? navigateFunc, double? marginBottom) {
      return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? 'Tiêu đề',
              style: textTheme.headlineSmall,
            ),
            GestureDetector(
                onTap: () {
                  navigateFunc;
                },
                child: Text(link ?? 'link',
                    style: textTheme.titleMedium?.copyWith(
                      color: appColors.primaryBase,
                    ))),
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
                titleWithLink('Đang theo dõi', 'Thêm',
                    '${min(followingList?.length ?? 0, 10)} hồ sơ', () {
                  showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      isScrollControlled: true,
                      barrierColor: Colors.white,
                      useRootNavigator: true,
                      builder: (context) {
                        return FollowersScrollList(
                          title: 'Danh sách đang theo dõi',
                          profileList: followingList ?? [],
                        );
                      });
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
      int? numOfStories, int? numOfReadingList, Profile? profile) {
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
          Flexible(
            child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      isScrollControlled: true,
                      barrierColor: Colors.white,
                      useRootNavigator: true,
                      builder: (context) {
                        return FollowersScrollList(
                          title: 'Danh sách đang theo dõi',
                          profileList: profile?.followers ?? [],
                        );
                      });
                },
                child: interactionItem('Người theo dõi',
                    formatNumber(profile?.followers?.length ?? 0))),
          ),
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
        () => StoryRepostitory()
            .fetchPublishedStoriesByUserId(widget.id)); //userId=me
    final readingStoriesQuery = useQuery(['readingStories', widget.id],
        () => StoryRepostitory().fetchReadingStoriesByUserId(widget.id));
    final conversationsQuery = useQuery(['conversations'],
        () => ConversationRepository().fetchAllConversations());
    final wallCommentsQuery = useQuery(['wallComments', widget.id],
        () => ProfileRepository().fetchAllWallComment(userId: widget.id),
        refetchOnMount: RefetchOnMount.stale,
        staleDuration: const Duration(minutes: 5)); //userId=me

    final isFollowUser = useState(false);
    final isNotifyOn = useState(true);

    useEffect(() {
      isFollowUser.value = profileQuery.data?.isFollowed ?? false;
      return () {};
    }, [profileQuery.data]);
    handleFollow({bool isFollowed = false}) async {
      if (!isFollowed) {
        try {
          await InteractionRepository()
              .follow(widget.id)
              .then((res) => {print(res)});
          isFollowUser.value = true;

          // ignore: use_build_context_synchronously
          AppSnackBar.buildTopSnackBar(
              context, 'Theo dõi thành công', null, SnackBarType.success);
        } catch (e) {}
      } else {
        //show dropdown

        //action unfollow
      }
    }

    handleUnfollow() async {
      try {
        await InteractionRepository()
            .unfollow(widget.id)
            .then((res) => {print(res)});
        isFollowUser.value = false;
      } catch (e) {}
    }

    handleNoti(isNotified) async {
      try {
        await InteractionRepository().notify(widget.id, isNotified);
      } catch (e) {
        print(e);
      }
    }

    print(profileQuery.data);
    print(profileQuery.isError);
    print(profileQuery.isSuccess);
    Widget userProfileInfo(
        UseQueryResult<AuthUser?, dynamic> userByIdQuery,
        UseQueryResult<List<Story>?, dynamic> publishedStoriesQuery,
        UseQueryResult<List<ReadingList>?, dynamic> readingStoriesQuery) {
      final isFollowed = profileQuery.data?.isFollowed ?? false;
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;
      final size = MediaQuery.of(context).size;
      final textTheme = Theme.of(context).textTheme;
      roundBalance(balance) {
        return double.parse(balance.toString()).toStringAsFixed(0);
      }

      Widget followingButton() {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              color: appColors.primaryLightest,
              borderRadius: BorderRadius.circular(50)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              child: isNotifyOn.value == true
                  ? Icon(
                      Icons.notifications_active,
                      color: appColors.inkBase,
                    )
                  : Icon(
                      Icons.notifications_off_outlined,
                      color: appColors.inkBase,
                    ),
            ),
            Flexible(
                flex: 4,
                child: Text(
                  'Đang theo dõi',
                  style:
                      textTheme.titleMedium?.copyWith(color: appColors.inkBase),
                )),
            Flexible(
                child: Icon(
              Icons.keyboard_arrow_down,
              color: appColors.inkBase,
            ))
          ]),
        );
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
                  enabled: profileQuery.isFetching || profileQuery.data == null,
                  child: Column(
                    children: [
                      Container(
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //   opacity: 0.6,
                        //   image: CachedNetworkImageProvider(
                        //       profileQuery.data?.backgroundUrl == ''
                        //           ? FALLBACK_BACKGROUND_URL
                        //           : profileQuery.data?.backgroundUrl ??
                        //               FALLBACK_BACKGROUND_URL),
                        //   fit: BoxFit.fill,
                        // )),
                        child: Column(
                          children: [
                            Skeletonizer(
                                enabled: profileQuery.isFetching,
                                child: AppAvatarImage(
                                  url: profileQuery.data?.avatarUrl,
                                  size: 85,
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
                                  name: profileQuery
                                              .data?.isAuthorFlairSelected ==
                                          true
                                      ? profileQuery.data?.authorLevel?.name
                                      : profileQuery.data?.level?.name,
                                )),
                            const SizedBox(height: 8),
                            Text(
                              profileQuery.data?.fullName ?? 'Họ và tên',
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
                                width: isFollowUser.value == true
                                    ? size.width / 1.8
                                    : size.width / 2.2,
                                child: isFollowUser.value == true
                                    ? DropdownButtonFormField<dynamic>(
                                        borderRadius: BorderRadius.circular(12),
                                        decoration: appInputDecoration(context)
                                            ?.copyWith(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: appColors.inkLighter,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                        )),
                                        alignment: Alignment(10, 10),
                                        value: isNotifyOn.value == true ? 0 : 1,
                                        // isExpanded: true,
                                        // isDense: true,
                                        items: followingDropdownItems(context),
                                        selectedItemBuilder: (context) {
                                          return List.generate(
                                              3,
                                              (index) => index == 0
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .notifications_active,
                                                          color:
                                                              appColors.inkBase,
                                                        ),
                                                        SizedBox(
                                                          width: size.width / 3,
                                                          child: Text(
                                                            'Đang theo dõi',
                                                            style: textTheme
                                                                .titleMedium,
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : index == 1
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .notifications_off_outlined,
                                                              color: appColors
                                                                  .inkBase,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width /
                                                                      3,
                                                              child: Text(
                                                                'Đang theo dõi',
                                                                style: textTheme
                                                                    .titleMedium,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Text('Theo dõi'));
                                        },
                                        onChanged: (value) {
                                          switch (value) {
                                            case 0:
                                              isNotifyOn.value == true;
                                              handleNoti(true);

                                              break;
                                            case 1:
                                              isNotifyOn.value == false;
                                              handleNoti(false);

                                              break;
                                            case 2:
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AppAlertDialog(
                                                      title: 'Xác nhận',
                                                      content:
                                                          'Xác nhận bỏ theo dõi ${profileQuery.data?.fullName}?',
                                                      actionText: 'Xác nhận',
                                                      actionCallBack: () {
                                                        handleUnfollow();
                                                        context.pop();
                                                      },
                                                    );
                                                  });

                                              break;
                                            default:
                                          }
                                        },
                                      )
                                    : AppIconButton(
                                        isOutlined: false,
                                        bgColor: appColors.inkBase,
                                        color: appColors.skyLightest,
                                        title: 'Theo dõi',
                                        textStyle:
                                            textTheme.titleMedium?.copyWith(
                                          color: appColors.skyLightest,
                                        ),
                                        icon: Icon(
                                          Icons.add,
                                          color: appColors.skyLightest,
                                          size: 24,
                                        ),
                                        // icon: const Icon(Icons.add),
                                        onPressed: () {
                                          handleFollow(
                                              isFollowed: isFollowUser.value ??
                                                  profileQuery
                                                      .data?.isFollowed ??
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
                                profileQuery.data,
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
                                    child: ReadMoreText(
                                      profileQuery.data?.description ?? '',
                                      trimLines: 4,
                                      colorClickableText: appColors.primaryBase,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: ' Xem thêm',
                                      trimExpandedText: ' Ẩn bớt',
                                      style: textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontFamily:
                                              GoogleFonts.sourceSansPro()
                                                  .fontFamily),
                                      moreStyle: textTheme.titleMedium
                                          ?.copyWith(
                                              color: appColors.primaryBase),
                                      textAlign: TextAlign.center,
                                    )),
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10),
                            child: wallCommentsQuery.data?.length == 0
                                ? Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Text(
                                      'Chưa có thông báo nào từ ${profileQuery.data?.username}',
                                      textAlign: TextAlign.center,
                                      style: textTheme.titleMedium,
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        (wallCommentsQuery.data ?? []).map((e) {
                                      WallComment comment = e;
                                      List<WallComment>? children =
                                          e.children ?? [];

                                      return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 32),
                                          child: CustomWallComment(
                                            callback: () {
                                              wallCommentsQuery.refetch();
                                            },
                                            comment: comment,
                                          ));
                                    }).toList()),
                          );
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

        // ignore: use_build_context_synchronously
        context.pop();
        // ignore: use_build_context_synchronously
        context.pop();
        // ignore: use_build_context_synchronously
        AppSnackBar.buildTopSnackBar(
            context, 'Chặn thành công', null, SnackBarType.success);
      } catch (e) {}
    }

    handleMute() async {
      context.pop();
      try {
        final res = await InteractionRepository().mute(widget.id);

        // ignore: use_build_context_synchronously
        AppSnackBar.buildTopSnackBar(
            context, 'Dừng tương tác thành công', null, SnackBarType.success);
        context.pop();
      } catch (e) {}
    }

    return profileQuery.data?.id == ''
        ? const NotFoundScreen()
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
                        // GoRouter.of(context).push('/profileSettings/messages',
                        //     extra: {'userId': widget.id});

                        showModalBottomSheet(
                            context: context,
                            barrierColor: Colors.white,
                            isScrollControlled: true,
                            isDismissible: false,
                            useSafeArea: true,
                            builder: (context) {
                              Conversation conversation;
                              if (conversationsQuery.data?.any((element) =>
                                      element.receiverId == widget.id) ??
                                  false) {
                                print('existed conversation');
                                conversation = conversationsQuery.data
                                        ?.firstWhere((element) =>
                                            element.receiverId == widget.id) ??
                                    const Conversation(id: '');
                              } else {
                                conversation = Conversation(
                                    id: '',
                                    receiverId: widget.id,
                                    name: profileQuery.data?.fullName,
                                    coverUrl: profileQuery.data?.avatarUrl);
                              }
                              print(conversation);
                              return DetailConversationScreen(
                                conversation: conversation,
                                refetchCallback: () {},
                                userId: userByIdQuery.data?.id,
                              );
                            });
                      }
                      if (value == 1) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AppAlertDialog(
                                title: 'Xác nhận',
                                content:
                                    'Xác nhận dừng tương tác người dùng ${profileQuery.data?.fullName == '' ? 'này' : profileQuery.data?.fullName}?',
                                actionText: 'Xác nhận',
                                actionCallBack: () {
                                  handleMute();
                                },
                                cancelText: 'Hủy',
                              );
                            });
                      }
                      if (value == 2) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AppAlertDialog(
                                title: 'Xác nhận',
                                content:
                                    'Xác nhận chặn người dùng ${profileQuery.data?.fullName == '' ? 'này' : profileQuery.data?.fullName}?',
                                actionText: 'Xác nhận',
                                actionCallBack: () {
                                  handleBlock();
                                },
                                cancelText: 'Hủy',
                              );
                            });
                      }
                      if (value == 3) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ReportDialog(
                                  reportType: ReportType.USER.name,
                                  reportId: widget.id);
                            });
                      }
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
                  wallCommentsQuery.refetch();
                },
                child: userProfileInfo(
                    userByIdQuery, publishedStoriesQuery, readingStoriesQuery)),
          );
  }
}
