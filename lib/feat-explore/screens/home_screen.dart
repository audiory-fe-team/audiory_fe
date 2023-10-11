import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-explore/models/ranking.dart';
import 'package:audiory_v0/feat-explore/widgets/home_rank_card.dart';
import 'package:audiory_v0/feat-explore/widgets/story_scroll_list.dart';
import 'package:audiory_v0/feat-explore/widgets/header_with_link.dart';
import 'package:audiory_v0/feat-explore/screens/layout/home_top_bar.dart';
import 'package:audiory_v0/feat-read/screens/library/downloaded_stories.dart';
import 'package:audiory_v0/models/Category.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/providers/connectivity_provider.dart';
import 'package:audiory_v0/repositories/category_repository.dart';
import 'package:audiory_v0/repositories/ranking_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityState = ref.watch(connectivityProvider);
    final storiesQuery = useQuery(
        ['stories'], () => StoryRepostitory().fetchStories(),
        enabled: connectivityState.status == ConnectivityStatus.online);

    if (connectivityState.status == ConnectivityStatus.offline) {
      return Scaffold(
          appBar: const HomeTopBar(),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                const SizedBox(height: 16),
                HeaderWithLink(
                    icon: Image.asset(
                      "assets/images/home_for_you.png",
                      width: 24,
                    ),
                    title: 'Truyện đã tải'),
                const SizedBox(height: 16),
                const DownloadedStories()
              ])));
    }

    return Scaffold(
      appBar: const HomeTopBar(),
      body: RefreshIndicator(
          onRefresh: () async {
            storiesQuery.refetch();
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  const SizedBox(height: 24),
                  const HomeBanners(),
                  const SizedBox(height: 24),

                  //NOTE: Recommendations section
                  Skeletonizer(
                      enabled: storiesQuery.isFetching,
                      child: HeaderWithLink(
                          icon: Image.asset(
                            "assets/images/home_for_you.png",
                            width: 24,
                          ),
                          title: 'Có thể bạn sẽ thích')),
                  const SizedBox(height: 12),
                  Skeletonizer(
                      enabled: storiesQuery.isFetching,
                      child: StoryScrollList(
                        storyList: storiesQuery.isFetching
                            ? skeletonStories
                            : storiesQuery.data,
                      )),
                  const SizedBox(height: 32),
                  //NOTE: Ranking section
                  Skeletonizer(
                      enabled: storiesQuery.isFetching,
                      child: const HomeRankingList()),

                  const SizedBox(height: 32),

                  //NOTE: Hot section
                  Skeletonizer(
                      enabled: storiesQuery.isFetching,
                      child: HeaderWithLink(
                          icon: Image.asset(
                            "assets/images/home_trend.png",
                            width: 24,
                          ),
                          title: 'Thịnh hành')),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 176,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://i0.wp.com/bookcoversbymelody.com/wp-content/uploads/2017/07/A-Brush-With-Vampires-FB-Banner.jpg?ssl=1',
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(height: 12),
                  Skeletonizer(
                      enabled: storiesQuery.isFetching,
                      child: StoryScrollList(
                        storyList: storiesQuery.isFetching
                            ? skeletonStories
                            : storiesQuery.data,
                      )),
                  const SizedBox(height: 32),
                  //NOTE: Paid section
                  HeaderWithLink(
                      icon: Image.asset("assets/images/home_paid.png",
                          width: 24, fit: BoxFit.cover),
                      title: 'Truyện trả phí'),
                  const SizedBox(height: 12),
                  Skeletonizer(
                      enabled: storiesQuery.isFetching,
                      child: StoryScrollList(
                        storyList: storiesQuery.isFetching
                            ? skeletonStories
                            : storiesQuery.data,
                      )),
                  const SizedBox(height: 32),

                  //NOTE: Continue reading section
                  HeaderWithLink(
                      icon: Image.asset(
                        "assets/images/home_continue_reading.png",
                        width: 24,
                      ),
                      title: 'Tiếp tục đọc'),
                  const SizedBox(height: 12),
                  Skeletonizer(
                      enabled: storiesQuery.isFetching,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: ((storiesQuery.isFetching
                                      ? skeletonStories
                                      : storiesQuery.data) ??
                                  [])
                              .map((story) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: StoryCardDetail(
                                    story: story,
                                  )))
                              .toList())),

                  const SizedBox(height: 32),
                ],
              ))),
    );
  }
}

class HomeBanners extends StatelessWidget {
  static const List<String> bannerList = [
    'https://i0.wp.com/bookcoversbymelody.com/wp-content/uploads/2012/09/scifi-romance-facebook-banner.jpg?ssl=1',
    'https://www.thecreativepenn.com/wp-content/uploads/2019/02/The-Creative-Penn-website-banner.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXP1KgLqDTJIAXBcSufJQzT-_M5pHwS0CQfhuIWpwBGGqD6ni8OT_aTwbL8YHo6AMEMyk&usqp=CAU'
  ];

  const HomeBanners({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 122,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bannerList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SizedBox(
                  width: 240,
                  child: Image.network(bannerList[index], fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: const Skeleton.replace(
                            width: 240, height: 122, child: SizedBox()));
                  }),
                ));
          }),
    );
  }
}

class RankingListBadge extends StatelessWidget {
  final String label;
  final bool selected;

  const RankingListBadge(
      {super.key, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Skeleton.shade(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: ShapeDecoration(
        color: selected ? appColors.primaryBase : appColors.skyLightest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 13,
                    color: selected ? Colors.white : appColors.inkBase,
                  )),
        ],
      ),
    ));
  }
}

class HomeRankingList extends StatefulWidget {
  const HomeRankingList({
    Key? key,
  }) : super(key: key);

  @override
  _HomeRankingListState createState() => _HomeRankingListState();
}

class _HomeRankingListState extends State<HomeRankingList> {
  String? selectedCategory;
  Future<List<Category>> categoryFuture = CategoryRepository().fetchCategory();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderWithLink(
            icon: Image.asset(
              "assets/images/home_ranking.png",
              width: 24,
            ),
            title: 'BXH Tháng này',
          ),
          const SizedBox(height: 12),
          FutureBuilder(
              future: categoryFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString(),
                      style: textTheme.titleMedium);
                }
                return Skeletonizer(
                    enabled:
                        snapshot.connectionState == ConnectionState.waiting,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = null;
                                  });
                                },
                                child: RankingListBadge(
                                  label: 'Tất cả',
                                  selected: selectedCategory == null,
                                )),
                          ),
                          ...(snapshot.data ?? []).map((category) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = category.id;
                                    });
                                  },
                                  child: RankingListBadge(
                                    label: category.name ?? '',
                                    selected: category.id == selectedCategory,
                                  )),
                            );
                          }).toList()
                        ],
                      ),
                    ));
              }),
          const SizedBox(height: 12),
          FutureBuilder(
              future: RankingRepository().fetchRankingStories(
                page: 1,
                page_size: 5,
                time: RankingTimeRange.weekly,
                metric: RankingMetric.total_read,
                category: selectedCategory,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Skeletonizer(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:
                              skeletonStories.asMap().entries.map((entry) {
                            final story = entry.value;
                            final index = entry.key;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: HomeRankingCard(
                                order: index + 1,
                                story: story,
                                icon: InkWell(
                                  child: SvgPicture.asset(
                                    'assets/icons/heart.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                            );
                          }).toList()));
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(snapshot.error.toString(),
                          style: textTheme.titleLarge));
                } else if (!snapshot.hasData ||
                    snapshot.data?.isEmpty == true) {
                  return Center(
                      child: Text('Không có dữ liệu',
                          style: textTheme.titleLarge));
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: (snapshot.data ?? [])
                      .toList()
                      .asMap()
                      .entries
                      .map((entry) {
                    final story = entry.value;
                    final index = entry.key;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: HomeRankingCard(
                        order: index + 1,
                        story: story,
                        icon: InkWell(
                          child: SvgPicture.asset(
                            'assets/icons/heart.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
          const SizedBox(height: 6),
          Material(
            child: InkWell(
              onTap: () {
                GoRouter.of(context).push("/ranking");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Xem thêm',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            decoration: TextDecoration.underline,
                            color: appColors.primaryBase,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
