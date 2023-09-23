import 'dart:convert';
import 'dart:math';

import 'package:audiory_v0/feat-manage-profile/models/profile_screen_data.dart';
import 'package:audiory_v0/repositories/profile_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../models/AuthUser.dart';
import '../../models/Profile.dart';
import '../../models/Story.dart';
import '../../theme/theme_constants.dart';
import '../../widgets/buttons/app_icon_button.dart';
import '../../widgets/custom_app_bar.dart';
import 'layout/story_scroll_list.dart';
import 'package:fquery/fquery.dart';

class UserProfileScreen extends StatefulHookWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with TickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  UserServer? currentUser;

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

  Widget introView(List<Story>? story, List<Story>? readingList,
      List<Profile> followingList) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    Widget titleWithLink(String title, String link, String? subTitle,
        dynamic navigateFunc, double? marginBottom) {
      return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textTheme.headlineMedium,
            ),
            GestureDetector(
                onTap: () {
                  navigateFunc;
                },
                child: Text(link,
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

    Widget followerCard() {
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
                    style: textTheme.titleSmall!.copyWith(
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
              titleWithLink('Tác phẩm', 'Thêm', '${story?.length} tác phẩm',
                  () {
                context.go('/');
              }, 12),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: story!
                        .take(min(story.length, 10))
                        .map((story) => Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: SizedBox(
                                  width: size.width - 5,
                                  child: StoryCardDetail(story: story)),
                            ))
                        .toList(),
                  )),
              const SizedBox(
                height: 16,
              ),
              if (readingList?.isEmpty as bool) ...[
                titleWithLink('Danh sách đọc', 'Thêm',
                    '${readingList?.length ?? '0'} danh sách', () {
                  context.go('/');
                }, 12),
                StoryScrollList(storyList: readingList),
                const SizedBox(
                  height: 16,
                ),
              ],
              if (followingList.isEmpty) ...[
                titleWithLink(
                    'Đang theo dõi', 'Thêm', '${followingList.length} hồ sơ',
                    () {
                  context.go('/');
                }, 12),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: followingList
                          .take(min(followingList.length, 10))
                          .map((story) => Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: followerCard(),
                              ))
                          .toList(),
                    )),
              ],
            ],
          ),

          // Skeletonizer(
          //     enabled: storiesQuery.isFetching,
          //     child: StoryScrollList(
          //       storyList: storiesQuery.isFetching
          //           ? skeletonStories
          //           : storiesQuery.data,
          //     )),
        ],
      ),
    );
  }

  Widget userProfileInfo(
      UserServer? user,
      UseQueryResult<Profile?, dynamic> profileQuery,
      UseQueryResult<List<Story>?, dynamic> publishedStoriesQuery,
      UseQueryResult<List<Story>?, dynamic> readingStoriesQuery) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return RefreshIndicator(
      onRefresh: () async {
        profileQuery.refetch();
      },
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: user == null
              ? AppIconButton(onPressed: () {
                  context.go('/push');
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
                          child: Material(
                            child: InkWell(
                              onTap: () async {
                                context.push('/profile', extra: {});
                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: profileQuery.data?.avatarUrl == ''
                                    ? Image.network(
                                        'https://img.freepik.com/premium-vector/people-saving-money_24908-51569.jpg?w=2000',
                                        width: size.width / 3.5,
                                        height: size.width / 3.5,
                                      )
                                    : Image.network(
                                        profileQuery.data?.avatarUrl as String,
                                        width: size.width / 3.5,
                                        height: size.width / 3.5,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Skeletonizer(
                          enabled: profileQuery.isFetching,
                          child: Text(
                            profileQuery.data?.fullName ?? 'email@gmail.com',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        Text(
                          '@${currentUser?.username ?? '_blank'}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: SvgPicture.asset(
                                'assets/icons/coin.svg',
                                width: 24,
                                height: 24,
                                color: Colors.amber,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: size.width / 2.5,
                          child: AppIconButton(
                              title: 'Đăng xuất',
                              // icon: const Icon(Icons.add),
                              onPressed: () {
                                signOut();
                                context.go('/login');
                              }),
                        ),
                        const SizedBox(height: 16),
                        Skeletonizer(
                          enabled: publishedStoriesQuery.isFetching ||
                              readingStoriesQuery.isFetching,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
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
                            Skeletonizer(
                              enabled: profileQuery.isFetching,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  profileQuery.data?.description == null ||
                                          profileQuery.data?.description == ''
                                      ? 'Nhập gì đó về bạn'
                                      : profileQuery.data?.description
                                          as String,
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
                                const EdgeInsets.symmetric(horizontal: 16),
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
                            return introView(publishedStoriesQuery.data,
                                readingStoriesQuery.data, []);
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
      return SizedBox(
        width: (size.width - 32) / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Skeleton.keep(
              child: Text(
                data,
                style: sharedHeaderStyle,
              ),
            ),
            const SizedBox(height: 4),
            Text((title).toString(), style: sharedTitleStyle)
          ],
        ),
      );
    }

    return IntrinsicHeight(
        child: Row(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          interactionItem('Tác phẩm', '${numOfStories ?? '0'}'),
          const VerticalDivider(),
          interactionItem('Danh sách đọc', '${numOfReadingList ?? '0'}'),
          const VerticalDivider(),
          interactionItem('Người theo dõi', '${numOfFollowers ?? '0'}'),
          // const VerticalDivider(),
          // interactionItem('Bình luận', '40'),
        ]));
  }

  Future<void> signOut() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    // final bool res = await AuthService().singOut();

    setState(() {
      currentUser = null;
    });

// ignore: use_build_context_synchronously
    context.pop();
    _displaySnackBar('Đăng xuất thành công');
  }

  void _displaySnackBar(String? content) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: appColors.primaryBase,
      duration: const Duration(seconds: 3),
      content: Text(content as String),
      action: SnackBarAction(
        textColor: appColors.skyBase,
        label: 'Undo',
        onPressed: () {},
      ),
    ));
  }

  Future<UserServer?> getUserDetails() async {
    String? value = await storage.read(key: 'currentUser');
    currentUser =
        value != null ? UserServer.fromJson(jsonDecode(value)['data']) : null;

    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final profileQuery = useQuery(
        ['profile'],
        () => ProfileRepository()
            .fetchUserProfileByUserId(currentUser?.id as String));
    final publishedStoriesQuery = useQuery(
        ['publishedStories'],
        () => StoryRepostitory()
            .fetchPublishedStoriesByUserId(currentUser?.id as String));
    final readingStoriesQuery = useQuery(
        ['readingStories'],
        () => StoryRepostitory()
            .fetchReadingStoriesByUserId(currentUser?.id as String));

    return Scaffold(
      appBar: CustomAppBar(
        height: 60,
        title: Text(
          'Hồ sơ',
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
                  context.pushNamed('profileSettings', extra: {
                    'currentUser': currentUser,
                    'userProfile': profileQuery.data
                  });
                },
                icon: const Icon(
                  Icons.settings_outlined,
                  size: 25,
                )),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          profileQuery.refetch();
        },
        child: FutureBuilder<UserServer?>(
          future: getUserDetails(), // async work
          builder: (BuildContext context, AsyncSnapshot<UserServer?> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return AppIconButton(onPressed: () {
                    context.go('/login');
                  });
                } else {
                  return userProfileInfo(snapshot.data, profileQuery,
                      publishedStoriesQuery, readingStoriesQuery);
                }
            }
          },
        ),
      ),
    );
  }
}
