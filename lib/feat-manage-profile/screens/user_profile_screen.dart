import 'dart:convert';
import 'dart:math';

import 'package:audiory_v0/feat-manage-profile/layout/profile_scroll_list.dart';
import 'package:audiory_v0/feat-manage-profile/layout/reading_scroll_list.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/reading-list/reading_list_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
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
import '../../widgets/custom_app_bar.dart';
import 'package:fquery/fquery.dart';

class UserProfileScreen extends StatefulHookWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
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
          ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: AppImage(
                  url: currentUser?.avatarUrl,
                  width: 85,
                  height: 85,
                  fit: BoxFit.fill)),
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

  Widget userProfileInfo(
      UseQueryResult<AuthUser?, dynamic> userByIdQuery,
      UseQueryResult<Profile, dynamic> profileQuery,
      UseQueryResult<List<Story>?, dynamic> publishedStoriesQuery,
      UseQueryResult<List<ReadingList>?, dynamic> readingStoriesQuery) {
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
          margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: userByIdQuery.isError
              ? AppIconButton(
                  title: 'Đăng nhập',
                  onPressed: () {
                    context.go('/login');
                  })
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Skeletonizer(
                          enabled: profileQuery.isFetching,
                          child: CircleAvatar(
                            radius: 45,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: profileQuery.data?.avatarUrl == ''
                                    ? "https://play-lh.googleusercontent.com/MDmnqZ0E9abxJhYIqyRUtumShQpunXSFTRuolTYQh-zy4pAg6bI-dMAhwY5M2rakI9Jb=w800-h500-rw"
                                    : profileQuery.data?.avatarUrl ??
                                        'https://play-lh.googleusercontent.com/MDmnqZ0E9abxJhYIqyRUtumShQpunXSFTRuolTYQh-zy4pAg6bI-dMAhwY5M2rakI9Jb=w800-h500-rw',
                                fit: BoxFit.cover,
                                width: 90,
                                height: 90,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                        Skeletonizer(
                          enabled: profileQuery.isFetching,
                          child: Text(
                            userByIdQuery.data?.fullName ?? 'Họ và tên',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        Text(
                          '@${profileQuery.data?.username ?? 'Tên đăng nhập'}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            userByIdQuery.isError == true
                                ? null
                                : GoRouter.of(context)
                              ?..pushNamed('profileSettings', extra: {
                                'currentUser': userByIdQuery.data,
                                'userProfile': profileQuery.data
                              })
                              ..push('/wallet', extra: {
                                'currentUser': userByIdQuery.data,
                                'userProfile': profileQuery.data
                              });
                          },
                          child: SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Image.asset(
                                    'assets/images/coin.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                Skeletonizer(
                                  enabled: userByIdQuery.isFetching,
                                  child: Flexible(
                                    child: Text(
                                      " ${userByIdQuery.data?.wallets?.isNotEmpty == true ? roundBalance(userByIdQuery.data?.wallets![0].balance) : '_'}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ),
                                ),
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
                              icon: Icon(
                                Icons.calendar_today,
                                color: appColors.primaryBase,
                                size: 20,
                              ),
                              // icon: const Icon(Icons.add),

                              onPressed: () {
                                userByIdQuery.isError == true
                                    ? null
                                    : GoRouter.of(context)
                                        .push('/profile/dailyReward');
                              }),
                        ),

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
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width / 9),
                                child: Divider(
                                  thickness: 1.2,
                                  color: appColors.inkLighter,
                                ),
                              ),
                            ),
                            profileQuery.data?.description == null ||
                                    profileQuery.data?.description == ''
                                ? SizedBox(
                                    height: 0,
                                  )
                                : Skeletonizer(
                                    enabled: profileQuery.isFetching,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        profileQuery.data?.description ==
                                                    null ||
                                                profileQuery
                                                        .data?.description ==
                                                    ''
                                            ? 'Nhập gì đó về bạn'
                                            : profileQuery.data?.description ??
                                                '',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width / 4),
                              child: Divider(
                                thickness: 1.2,
                                color: appColors.inkLighter,
                              ),
                            ),
                          ],
                        ),
                        //tab
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: TabBar(
                            onTap: (value) {
                              // if (tabState.value != value) tabState.value = value;
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
                            return introView(
                                publishedStoriesQuery.data,
                                readingStoriesQuery.data,
                                profileQuery.data?.followings ?? []);
                          }
                          return Skeletonizer(
                              enabled: false, child: introView([], [], []));
                        }),
                      ],
                    ),
                  ],
                ),
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
    final userByIdQuery =
        useQuery(['user'], () => AuthRepository().getMyUserById());
    final profileQuery = useQuery(
        ['profile'], () => AuthRepository().getMyInfo()); // include followers
    final publishedStoriesQuery = useQuery(
        ['publishedStories'],
        () =>
            StoryRepostitory().fetchPublishedStoriesByUserId('me')); //userId=me
    final readingStoriesQuery = useQuery(['readingStories'],
        () => StoryRepostitory().fetchReadingStoriesByUserId('me'));

    return Scaffold(
      appBar: CustomAppBar(
        height: 60,
        title: Text(
          'Hồ sơ ',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: appColors.inkBase),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                onPressed: () {
                  userByIdQuery.isError == true
                      ? null
                      : context.pushNamed('profileSettings', extra: {
                          'currentUser': userByIdQuery.data,
                          'userProfile': profileQuery.data
                        });
                },
                icon: Icon(
                  Icons.settings_outlined,
                  size: 25,
                  color: userByIdQuery.isError == true
                      ? appColors.skyLight
                      : appColors.inkBase,
                )),
          )
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
