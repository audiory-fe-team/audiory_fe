import 'dart:math';

import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/feat-manage-profile/layout/profile_scroll_list.dart';
import 'package:audiory_v0/feat-manage-profile/layout/profile_top_bar.dart';
import 'package:audiory_v0/feat-manage-profile/layout/reading_scroll_list.dart';
import 'package:audiory_v0/models/reading-list/reading_list_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../models/AuthUser.dart';
import '../../models/Profile.dart';
import '../../theme/theme_constants.dart';
import '../../widgets/buttons/app_icon_button.dart';
import 'package:fquery/fquery.dart';

class UserProfileScreen extends StatefulHookWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
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

  Widget userProfileInfo(
      AuthUser? userData,
      Profile? profileData,
      UseQueryResult<List<Story>?, dynamic> publishedStoriesQuery,
      UseQueryResult<List<ReadingList>?, dynamic> readingStoriesQuery) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    roundBalance(balance) {
      return double.parse(balance.toString()).toStringAsFixed(0);
    }

    print(profileData?.avatarUrl);
    return SingleChildScrollView(
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
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    opacity: 0.6,
                    image: CachedNetworkImageProvider(
                        profileData?.backgroundUrl == ''
                            ? FALLBACK_BACKGROUND_URL
                            : profileData?.backgroundUrl ??
                                FALLBACK_BACKGROUND_URL),
                    fit: BoxFit.fill,
                  )),
                  child: Column(
                    children: [
                      AppAvatarImage(
                        hasLevel: true,
                        levelId: userData?.levelId ?? 1,
                        hasAuthorLevel: true,
                        authorLevelId: userData?.authorLevelId ?? 1,
                        size: userData?.levelId != null ? 93 : 88,
                        url: userData?.avatarUrl,
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
                        onTap: () {
                          // userByIdQuery.isError == true
                          //     ? null
                          //     : GoRouter.of(context)
                          //   ?..pushNamed('profileSettings', extra: {
                          //     'currentUser': userByIdQuery.data,
                          //     'userProfile': profileQuery.data
                          //   })
                          //   ..push('/wallet', extra: {
                          //     'currentUser': userByIdQuery.data,
                          //     'userProfile': profileQuery.data
                          //   });
                        },
                        child: Container(
                          width: size.width / 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Image.asset(
                                  'assets/images/coin.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Text(
                                  " ${userData?.wallets?.isNotEmpty == true ? roundBalance(userData?.wallets![0].balance) : '_'}",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              Flexible(
                                  child: GestureDetector(
                                child: const Icon(Icons.add),
                                onTap: () {
                                  context.pushNamed('newPurchase',
                                      extra: {'currentUser': userData});
                                },
                              )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: size.width / 2.3,
                        child: AppIconButton(
                            isOutlined: true,
                            bgColor: appColors.skyLightest,
                            color: appColors.primaryBase,
                            title: 'Nhận phúc lợi',
                            textStyle: textTheme.titleMedium
                                ?.copyWith(color: appColors.primaryBase),
                            onPressed: () {
                              userData == null
                                  ? null
                                  : GoRouter.of(context)
                                      .push('/profile/dailyReward');
                            }),
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
                      profileData?.numberOfFollowers,
                    ),
                  ),
                ),
                // descrition
                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width / 9),
                      child: Divider(
                        thickness: 1.2,
                        color: appColors.inkLighter,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        profileData?.description == null ||
                                profileData?.description == ''
                            ? 'Nhập gì đó về bạn'
                            : profileData?.description ?? '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width / 4),
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
                          if ([publishedStoriesQuery.data ?? []].isEmpty &&
                              [readingStoriesQuery.data ?? []].isEmpty &&
                              [profileData?.followings ?? []].isEmpty) {
                            return Center(
                              child: Text('Chưa có dữ liệu mới'),
                            );
                          } else {
                            return introView(
                                publishedStoriesQuery.data,
                                readingStoriesQuery.data,
                                profileData?.followings ?? []);
                          }
                        } else {
                          return Text('Thông báo của người dùng');
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
    final userByIdQuery = useQuery(
        ['user', jwt], () => AuthRepository().getMyUserById(),
        refetchOnMount: RefetchOnMount.stale,
        staleDuration: const Duration(minutes: 5));
    final profileQuery = useQuery(
        ['profile', jwt], () => AuthRepository().getMyInfo(),
        refetchOnMount: RefetchOnMount.stale,
        staleDuration: const Duration(minutes: 5)); // include followers
    final publishedStoriesQuery = useQuery(['publishedStories', jwt],
        () => StoryRepostitory().fetchPublishedStoriesByUserId('me'),
        refetchOnMount: RefetchOnMount.stale,
        staleDuration: const Duration(minutes: 5)); //userId=me
    final readingStoriesQuery = useQuery(['readingStories', jwt],
        () => StoryRepostitory().fetchReadingStoriesByUserId('me'),
        refetchOnMount: RefetchOnMount.stale,
        staleDuration: const Duration(minutes: 5));
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
      ),
    );
  }
}
