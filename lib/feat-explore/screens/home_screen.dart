import 'dart:math';

import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-explore/widgets/home_rank_card.dart';
import 'package:audiory_v0/feat-explore/widgets/story_scroll_list.dart';
import 'package:audiory_v0/feat-explore/widgets/header_with_link.dart';
import 'package:audiory_v0/feat-explore/screens/layout/home_top_bar.dart';
import 'package:audiory_v0/feat-read/widgets/current_read_card.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/repositories/library_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storiesQuery =
        useQuery(['stories'], () => StoryRepostitory().fetchStories());
    final paywalledStoriesQuery = useQuery(['paywalledStories'],
        () => StoryRepostitory().fetchMyPaywalledStories());
    final recommendStoriesQuery = useQuery(['recommendStories'],
        () => StoryRepostitory().fetchMyRecommendStories());
    final libraryQuery =
        useQuery(['library'], () => LibraryRepository.fetchMyLibrary());

    return Scaffold(
      appBar: const HomeTopBar(),
      body: RefreshIndicator(
          onRefresh: () async {
            storiesQuery.refetch();
            recommendStoriesQuery.refetch();
            libraryQuery.refetch();
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  const SizedBox(height: 32),
                  const HomeBanners(),
                  const SizedBox(height: 32),

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
                      enabled: recommendStoriesQuery.isFetching,
                      child: StoryScrollList(
                        storyList: recommendStoriesQuery.isFetching
                            ? skeletonStories
                            : recommendStoriesQuery.data,
                      )),
                  const SizedBox(height: 32),
                  //NOTE: Ranking section
                  Skeletonizer(
                      enabled: storiesQuery.isFetching,
                      child: HomeRankingList(
                        storyList: storiesQuery.isFetching
                            ? skeletonStories
                            : storiesQuery.data,
                      )),

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
                      enabled: paywalledStoriesQuery.isFetching,
                      child: StoryScrollList(
                          storyList: paywalledStoriesQuery.isFetching
                              ? skeletonStories
                              : paywalledStoriesQuery.data)),
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
                    enabled: libraryQuery.isFetching,
                    child: Column(
                        children: (libraryQuery.data?.libraryStory ?? [])
                            .map((e) => Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: CurrentReadCard(
                                  story: e,
                                  onDeleteStory: (id) => {},
                                  isEditable: false,
                                )))
                            .toList()),
                  ),
                  // Skeletonizer(
                  //     enabled: libraryQuery.isFetching,
                  //     child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: ((libraryQuery.isFetching
                  //                     ? skeletonStories
                  //                     : libraryQuery.data?.libraryStory) ??
                  //                 [])
                  //             .map((story) => Padding(
                  //                 padding: const EdgeInsets.only(bottom: 12),
                  //                 child: StoryCardDetail(
                  //                   story: story,
                  //                 )))
                  //             .toList())),

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
                child: Container(
                  width: 240,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      bannerList[index],
                      fit: BoxFit.fill,
                    ),
                  ),
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: ShapeDecoration(
        color: selected ? appColors.primaryBase : Colors.white,
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
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: selected ? Colors.white : appColors.inkBase,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}

class HomeRankingList extends StatelessWidget {
  final List<Story>? storyList;
  static const options = ['Truyện hot tháng', 'Truyện bình luận nhiều'];

  const HomeRankingList({super.key, this.storyList = const []});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return SizedBox(
      width: double.infinity,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        HeaderWithLink(
            icon: Image.asset(
              "assets/images/home_ranking.png",
              width: 24,
            ),
            title: 'BXH Tháng này',
            link: '/ranking'),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: options
                .map((option) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: RankingListBadge(
                      label: option,
                      selected: true,
                    )))
                .toList(),
          ),
        ),
        const SizedBox(height: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: (storyList ?? [])
              .toList()
              .sublist(0, min(storyList?.length ?? 0, 5))
              .asMap()
              .entries
              .map((entry) {
            Story story = entry.value;
            int index = entry.key;
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
                ));
          }).toList(),
        ),
        const SizedBox(height: 6),
        Material(
            child: InkWell(
          onTap: () {
            GoRouter.of(context).push("/ranking");
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                // gradient: LinearGradient(
                //     colors: [appColors.primaryBase, appColors.primaryLighter]),
                // color: appColors.primaryLightest,
                borderRadius: BorderRadius.circular(6)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text('Xem thêm',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        decoration: TextDecoration.underline,
                        color: appColors.primaryBase,
                      )),
            ]),
          ),
        ))
      ]),
    );
  }
}
