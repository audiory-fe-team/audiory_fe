import 'dart:math';

import 'package:audiory_v0/feat-manage-profile/layout/profile_scroll_list.dart';
import 'package:audiory_v0/feat-manage-profile/layout/profile_top_bar.dart';
import 'package:audiory_v0/feat-manage-profile/layout/reading_scroll_list.dart';
import 'package:audiory_v0/feat-manage-profile/screens/follow/followers_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/level/my_level_screen.dart';
import 'package:audiory_v0/feat-manage-profile/widgets/custom_wall_comment.dart';
import 'package:audiory_v0/models/reading-list/reading_list_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/models/wall-comment/wall_comment_model.dart';
import 'package:audiory_v0/providers/global_me_provider.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/comment_repository.dart';
import 'package:audiory_v0/repositories/profile_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../models/AuthUser.dart';
import '../../models/Profile.dart';
import '../../theme/theme_constants.dart';
import 'package:fquery/fquery.dart';

class UserProfileScreen extends StatefulHookConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen>
    with TickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  String? jwt;

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

    getJwt();
  }

  getJwt() async {
    storage.read(key: 'jwt').then((value) => setState(() {
          jwt = value;
        }));
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
                onTap: navigateFunc,
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
        textTheme.titleLarge?.copyWith(color: appColors.inkLight);
    final sharedHeaderStyle = textTheme.titleLarge;
    final sharedTitleStyle = textTheme.titleMedium;

    Widget interactionItem(String title, data) {
      return Column(
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
      );
    }

    return IntrinsicHeight(
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          if (numOfStories != 0) ...[
            Flexible(
              child: GestureDetector(
                  child: interactionItem('Tác phẩm', '${numOfStories ?? '0'}')),
            ),
            const VerticalDivider(),
          ],
          Flexible(
            child: GestureDetector(
                child: interactionItem(
                    'Danh sách đọc', '${numOfReadingList ?? '0'}')),
          ),
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
                          profileList: profile?.followers ?? [],
                        );
                      });
                },
                child: interactionItem('Người theo dõi',
                    formatNumber(profile?.followers?.length ?? 0))),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final currentUserId = ref.watch(globalMeProvider)?.id;

    final userByIdQuery = useQuery(
        ['user', currentUserId], () => AuthRepository().getMyUserById(),
        refetchOnMount: RefetchOnMount.stale,
        staleDuration: const Duration(minutes: 5));
    final profileQuery = useQuery(
        ['profile', currentUserId], () => AuthRepository().getMyInfo(),
        refetchOnMount: RefetchOnMount.stale,
        staleDuration: const Duration(minutes: 5)); // include followers
    final publishedStoriesQuery = useQuery(['publishedStories', currentUserId],
        () => StoryRepostitory().fetchPublishedStoriesByUserId('me'),
        refetchOnMount: RefetchOnMount.stale,
        staleDuration: const Duration(minutes: 5)); //userId=me
    final wallCommentsQuery = useQuery(['wallComments', currentUserId],
        () => ProfileRepository().fetchAllWallComment(userId: currentUserId),
        refetchOnMount: RefetchOnMount.stale,
        staleDuration: const Duration(minutes: 5)); //userId=me
    final readingStoriesQuery = useQuery(['readingStories', currentUserId],
        () => StoryRepostitory().fetchReadingStoriesByUserId('me'),
        refetchOnMount: RefetchOnMount.stale,
        staleDuration: const Duration(minutes: 5));

    final controller = useTextEditingController();

    Widget userProfileInfo(
      AuthUser? userData,
      Profile? profileData,
      UseQueryResult<List<Story>?, dynamic> publishedStoriesQuery,
      UseQueryResult<List<ReadingList>?, dynamic> readingStoriesQuery,
    ) {
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;
      final size = MediaQuery.of(context).size;
      final textTheme = Theme.of(context).textTheme;
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //   opacity: 0.6,
                    //   image: CachedNetworkImageProvider(
                    //       profileData?.backgroundUrl == ''
                    //           ? FALLBACK_BACKGROUND_URL
                    //           : profileData?.backgroundUrl ??
                    //               FALLBACK_BACKGROUND_URL),
                    //   fit: BoxFit.fill,
                    // )),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                useSafeArea: true,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                builder: (context) {
                                  return MyLevelScreen(
                                    level: userData?.level,
                                    authorLevel: userData?.authorLevel,
                                    isAuthorFlairSelected:
                                        userData?.isAuthorFlairSelected,
                                    callback: () {
                                      profileQuery.refetch();
                                    },
                                  );
                                });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Skeleton.shade(
                              child: AppAvatarImage(
                                hasLevel: true,
                                levelId: userData?.levelId ?? 1,
                                hasAuthorLevel:
                                    userData?.isAuthorFlairSelected ?? false,
                                authorLevelId: userData?.authorLevelId ?? 1,
                                size: 80,
                                url: userData?.avatarUrl,
                                name: userData?.isAuthorFlairSelected == true
                                    ? userData?.authorLevel?.name
                                    : userData?.level?.name,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userData?.fullName ?? 'Họ và tên',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '@${userData?.username ?? 'Tên đăng nhập'}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: size.width / 2.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Image.asset(
                                    'assets/images/coin.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    " ${userData?.wallets?.isNotEmpty == true ? formatNumberWithSeperator(userData?.wallets![0].balance) : '_'}",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                Flexible(
                                    child: GestureDetector(
                                  child: const Icon(Icons.add),
                                  onTap: () {
                                    context.pushNamed(
                                      'newPurchase',
                                    );
                                  },
                                )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Skeletonizer(
                    enabled: publishedStoriesQuery.isFetching ||
                        readingStoriesQuery.isFetching,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: interactionInfo(
                        publishedStoriesQuery.data?.length,
                        readingStoriesQuery.data?.length,
                        profileData,
                      ),
                    ),
                  ),
                  // descrition
                  const SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width / 9),
                        child: Divider(
                          thickness: 1.2,
                          color: appColors.inkLighter,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: profileData?.description?.trim() == '' ||
                                  profileData?.description == null
                              ? Text('Nhập lời giới thiệu của bạn')
                              : ReadMoreText(
                                  profileData?.description ?? '',
                                  trimLines: 4,
                                  colorClickableText: appColors?.primaryBase,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: ' Xem thêm',
                                  trimExpandedText: ' Ẩn bớt',
                                  style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: GoogleFonts.sourceSansPro()
                                          .fontFamily),
                                  moreStyle: textTheme.titleMedium
                                      ?.copyWith(color: appColors?.primaryBase),
                                  textAlign: TextAlign.center,
                                )),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width / 4),
                        child: Divider(
                          thickness: 1.2,
                          color: appColors.inkLighter,
                        ),
                      ),
                    ],
                  ),

                  //tab
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: TabBar(
                            onTap: (value) {
                              setState(() {
                                if (tabState != value) tabState = value;
                              });
                            },
                            controller: tabController,
                            labelColor: appColors.primaryBase,
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
                        Builder(builder: (context) {
                          if (tabState == 0) {
                            bool hasPublishedStories =
                                publishedStoriesQuery.data?.isEmpty == true;
                            bool hasReadingLists =
                                readingStoriesQuery.data?.isEmpty == true;
                            bool hasFollowings =
                                profileData?.followings?.isEmpty == true ||
                                    profileData?.followings == null;

                            print(!hasPublishedStories &&
                                !hasReadingLists &&
                                !hasFollowings);
                            if (hasPublishedStories &&
                                hasReadingLists &&
                                hasFollowings) {
                              return const Text('Chưa có giới thiệu');
                            } else {
                              return introView(
                                  publishedStoriesQuery.data,
                                  readingStoriesQuery.data,
                                  profileData?.followings ?? []);
                            }
                          } else {
                            return Column(children: [
                              Skeletonizer(
                                enabled: wallCommentsQuery.isFetching,
                                child: wallCommentsQuery.data?.length == 0
                                    ? const Text(
                                        'Chưa có thông báo nào từ người dùng')
                                    : Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                width: size.width - 32,
                                                height: 70,
                                                child: TextField(
                                                  controller: controller,
                                                  onChanged: (value) {},
                                                  onSubmitted: (value) {
                                                    print('on');

                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    try {
                                                      controller.text == "";
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  },
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                  // maxLines: 3,
                                                  decoration: InputDecoration(
                                                      hintText: 'Đăng gì đó',
                                                      hintStyle: TextStyle(
                                                          color: appColors
                                                              .inkLighter),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide:
                                                            const BorderSide(
                                                          width: 0,
                                                          style:
                                                              BorderStyle.none,
                                                        ),
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              left: 16,
                                                              right: 40),
                                                      fillColor:
                                                          appColors.skyLightest,
                                                      filled: true,
                                                      suffixIconConstraints:
                                                          const BoxConstraints(
                                                        minHeight: 10,
                                                        minWidth: 10,
                                                      ),
                                                      suffixIcon: Container(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8),
                                                          margin:
                                                              const EdgeInsets.only(
                                                                  right: 8),
                                                          decoration:
                                                              ShapeDecoration(
                                                            shape:
                                                                const CircleBorder(),
                                                            color: appColors
                                                                .primaryLight,
                                                          ),
                                                          child: InkWell(
                                                              onTap: () async {
                                                                if (controller
                                                                        .text
                                                                        .trim() !=
                                                                    '') {
                                                                  print('trim');
                                                                  await CommentRepository
                                                                      .createWallComment(
                                                                    text: controller
                                                                        .text,
                                                                  );
                                                                  controller
                                                                      .clear();

                                                                  wallCommentsQuery
                                                                      .refetch();
                                                                }
                                                              },
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child: const Icon(
                                                                  Icons
                                                                      .send_rounded,
                                                                  size: 16,
                                                                  color: Colors
                                                                      .white)))),
                                                ),
                                              ),
                                              // IconButton(
                                              //   onPressed: () async {
                                              //     print(controller.text);
                                              //     print(
                                              //         controller.text == '');
                                              //     // await CommentRepository
                                              //     //     .createWallComment(
                                              //     //   text:
                                              //     //       'Hôm nay tôi buồn nên không ra truyện',
                                              //     // );

                                              //     // wallCommentsQuery.refetch();
                                              //   },
                                              //   icon: Icon(Icons.send),
                                              // )
                                            ],
                                          ),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  (wallCommentsQuery.data ?? [])
                                                      .map((e) {
                                                WallComment comment = e;
                                                List<WallComment>? children =
                                                    e.children ?? [];
                                                return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 32),
                                                    child: CustomWallComment(
                                                      comment: comment,
                                                      callback: () {
                                                        print('hi');
                                                        wallCommentsQuery
                                                            .refetch();
                                                      },
                                                    ));
                                              }).toList()),
                                        ],
                                      ),
                              ),
                            ]);
                          }
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: UserProfileTopBar(
            currentUser: userByIdQuery.data, userProfile: profileQuery.data),
        body: RefreshIndicator(
          onRefresh: () async {
            profileQuery.refetch();
            userByIdQuery.refetch();
            readingStoriesQuery.refetch();
            publishedStoriesQuery.refetch();
            wallCommentsQuery.refetch();
          },
          child: Skeletonizer(
            enabled: profileQuery.isFetching ||
                userByIdQuery.isFetching ||
                readingStoriesQuery.isFetching ||
                publishedStoriesQuery.isFetching,
            child: userProfileInfo(userByIdQuery.data, profileQuery.data,
                publishedStoriesQuery, readingStoriesQuery),
          ),
        ),
        floatingActionButton: GestureDetector(
            onTap: () {
              userByIdQuery.data == null
                  ? null
                  : GoRouter.of(context).push('/profile/dailyReward');
            },
            child: Container(
                width: 70,
                decoration: BoxDecoration(
                    color: appColors.secondaryLightest,
                    borderRadius: BorderRadius.circular(100)),
                child: LottieBuilder.asset(
                  'assets/gifs/daily-reward.json',
                  width: 100,
                ))),
      ),
    );
  }
}
