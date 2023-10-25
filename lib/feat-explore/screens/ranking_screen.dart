import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-explore/screens/explore_screen.dart';
import 'package:audiory_v0/feat-explore/screens/home_screen.dart';
import 'package:audiory_v0/feat-explore/utils/ranking.dart';
import 'package:audiory_v0/feat-explore/models/ranking.dart';
import 'package:audiory_v0/feat-explore/screens/layout/ranking_top_bar.dart';
import 'package:audiory_v0/feat-explore/widgets/author_rank_card.dart';
import 'package:audiory_v0/feat-explore/widgets/ranking_dropdown.dart';
import 'package:audiory_v0/feat-explore/widgets/story_rank_card.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/category_repository.dart';
import 'package:audiory_v0/repositories/ranking_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';

import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RankingScreen extends HookWidget {
  final RankingType type;
  final RankingMetric metric;
  final String? category;
  final RankingTimeRange time;

  //NOTE: Search for stories or
  const RankingScreen(
      {super.key,
      this.type = RankingType.story,
      this.metric = RankingMetric.total_read,
      this.time = RankingTimeRange.monthly,
      this.category});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final tabController = useTabController(
      initialIndex: type == RankingType.story ? 0 : 1,
      initialLength: 2,
    );

    return Scaffold(
      appBar: const RankingTopBar(),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TabBar(
                onTap: (value) {
                  if (value == 0 && type != RankingType.story) {
                    GoRouter.of(context).goNamed("ranking", queryParameters: {
                      "type": RankingType.story.toString().split(".").last,
                      "time": time.toString().split(".").last,
                    });
                  }
                  if (value == 1 && type != RankingType.author) {
                    GoRouter.of(context).goNamed("ranking", queryParameters: {
                      "type": RankingType.author.toString().split(".").last,
                      "time": time.toString().split(".").last,
                    });
                  }
                },
                controller: tabController,
                labelColor: appColors.inkBase,
                unselectedLabelColor: appColors.inkLighter,
                labelPadding: const EdgeInsets.symmetric(vertical: 0),
                indicatorColor: appColors.primaryBase,
                indicatorWeight: 2.5,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
                labelStyle: textTheme.headlineSmall,
                tabs: [
                  Tab(
                    height: 36,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/book.png',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 2),
                          const Text('Tác phẩm')
                        ]),
                  ),
                  Tab(
                    height: 36,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/hand_with_pen.png',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 2),
                          const Text('Tác giả')
                        ]),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Builder(builder: (_) {
              if (type == RankingType.author) return AuthorRanking(time: time);
              return StoryRanking(
                metric: metric,
                time: time,
                category: category,
              );
            })
          ],
        ),
      )),
    );
  }
}

class StoryRanking extends HookWidget {
  final RankingMetric metric;
  final RankingTimeRange time;
  final String? category;

  const StoryRanking(
      {required this.metric,
      required this.time,
      required this.category,
      super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final page = useState(1);
    final storiesQuery = useQuery(
        ["ranking", metric, time, category, page.value.toString()], () {
      return RankingRepository().fetchRankingStories(
          metric: metric, time: time, category: category, page: page.value);
    });
    final categories =
        useQuery(['categories'], () => CategoryRepository().fetchCategory());

    return Expanded(
        child: Column(
      children: [
        Skeletonizer(
            enabled: categories.isFetching,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                        onTap: () {
                          if (category != null) {
                            GoRouter.of(context)
                                .goNamed('ranking', queryParameters: {
                              "type":
                                  getValueString(RankingType.story.toString()),
                              "metric": getValueString(metric.toString()),
                              "time": getValueString(time.toString()),
                            });
                          }
                        },
                        child: RankingListBadge(
                          label: 'Tất cả',
                          selected: category == null,
                        )),
                  ),
                  ...(categories.data ?? []).map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                          onTap: () {
                            if (e.name != category) {
                              GoRouter.of(context)
                                  .goNamed('ranking', queryParameters: {
                                "type": getValueString(
                                    RankingType.story.toString()),
                                "metric": getValueString(metric.toString()),
                                "time": getValueString(time.toString()),
                                "category": e.name,
                              });
                            }
                          },
                          child: RankingListBadge(
                            label: e.name ?? '',
                            selected: e.name == category,
                          )),
                    );
                  }).toList()
                ],
              ),
            )),
        const SizedBox(height: 16),
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RankingDropdownWrapper(
                  icon: const Icon(Icons.troubleshoot_rounded, size: 16),
                  child: DropdownButton<RankingMetric>(
                      isDense: true,
                      value: metric,
                      iconSize: 16,
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      style: textTheme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                      items: const [
                        DropdownMenuItem(
                          value: RankingMetric.total_read,
                          child: Text('Lượt đọc'),
                        ),
                        DropdownMenuItem(
                          value: RankingMetric.total_vote,
                          child: Text('Bình chọn'),
                        ),
                        DropdownMenuItem(
                          value: RankingMetric.total_comment,
                          child: Text('Bình luận'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != metric) {
                          GoRouter.of(context)
                              .goNamed('ranking', queryParameters: {
                            "type":
                                getValueString(RankingType.story.toString()),
                            "metric": getValueString(value.toString()),
                            "time": getValueString(time.toString()),
                            ...(category != null ? {"category": category} : {}),
                          });
                        }
                      })),
              const SizedBox(width: 12),
              RankingDropdownWrapper(
                  icon: const Icon(Icons.schedule_rounded, size: 16),
                  child: DropdownButton<RankingTimeRange>(
                      isDense: true,
                      value: time,
                      iconSize: 16,
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      style: textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis),
                      items: const [
                        DropdownMenuItem(
                          value: RankingTimeRange.daily,
                          child: Text('Hôm nay'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.weekly,
                          child: Text('Tuần này'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.monthly,
                          child: Text('Tháng này'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.all_time,
                          child: Text(
                            'Từ trước đến nay',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != time) {
                          GoRouter.of(context)
                              .goNamed('ranking', queryParameters: {
                            "type":
                                getValueString(RankingType.story.toString()),
                            "metric": getValueString(metric.toString()),
                            "time": getValueString(value.toString()),
                            ...(category != null ? {"category": category} : {}),
                          });
                        }
                      })),
            ]),
        const SizedBox(
          height: 16,
        ),
        Expanded(
            child: RefreshIndicator(
                onRefresh: () async {
                  storiesQuery.refetch();
                },
                child: SingleChildScrollView(
                    child: Skeletonizer(
                        enabled: storiesQuery.isFetching,
                        child: Column(
                          // scrollDirection: Axis.vertical,
                          children: (storiesQuery.isFetching
                                  ? skeletonStories
                                  : (storiesQuery.data ?? []))
                              .asMap()
                              .entries
                              .map((entry) {
                            Story story = entry.value;
                            int index = entry.key;
                            return StoryRankCard(
                                story: story,
                                metric: metric,
                                order: (page.value - 1) * 10 + index + 1);
                          }).toList(),
                        ))))),
      ],
    ));
  }
}

class AuthorRanking extends HookWidget {
  // final RankingMetric metric;
  final RankingTimeRange time;

  const AuthorRanking(
      {
      // this.metric = RankingMetric.total_read,
      this.time = RankingTimeRange.all_time,
      super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final page = useState(1);
    final authorQuery = useQuery(["ranking", time, page.value.toString()], () {
      return RankingRepository()
          .fetchRankingAuthors(time: time, page: page.value);
    });
    return Expanded(
        child: Column(
      children: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              // RankingDropdownWrapper(
              //     icon: const Icon(Icons.troubleshoot_rounded, size: 16),
              //     child: DropdownButton<RankingMetric>(
              //         isDense: true,
              //         value: metric,
              //         iconSize: 16,
              //         elevation: 4,
              //         borderRadius: BorderRadius.circular(8),
              //         style: textTheme.titleSmall!
              //             .copyWith(fontWeight: FontWeight.w600),
              //         items: const [
              //           DropdownMenuItem(
              //             value: RankingMetric.total_read,
              //             child: Text('Lượt đọc'),
              //           ),
              //           // DropdownMenuItem(
              //           //   value: RankingMetric.,
              //           //   child: Text('Bình chọn'),
              //           // ),
              //           // DropdownMenuItem(
              //           //   value: RankingMetric.gift,
              //           //   child: Text('Tặng quà'),
              //           // ),
              //           // DropdownMenuItem(
              //           //   value: RankingMetric.follower,
              //           //   child: Text('Người theo dõi'),
              //           // ),
              //         ],
              //         onChanged: (value) {
              //           if (value != metric) {
              //             GoRouter.of(context)
              //                 .goNamed('ranking', queryParameters: {
              //               "type":
              //                   getValueString(RankingType.author.toString()),
              //               "metric": getValueString(value.toString()),
              //               "time": getValueString(time.toString()),
              //             });
              //           }
              //         })),
              // const SizedBox(width: 12),
              RankingDropdownWrapper(
                  icon: const Icon(Icons.schedule_rounded, size: 16),
                  child: DropdownButton<RankingTimeRange>(
                      isDense: true,
                      value: time,
                      iconSize: 16,
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      style: textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis),
                      items: const [
                        DropdownMenuItem(
                          value: RankingTimeRange.daily,
                          child: Text('Hôm nay'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.weekly,
                          child: Text('Tuần này'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.monthly,
                          child: Text('Tháng này'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.all_time,
                          child: Text(
                            'Từ trước đến nay',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != time) {
                          GoRouter.of(context)
                              .goNamed('ranking', queryParameters: {
                            "type":
                                getValueString(RankingType.author.toString()),
                            // "metric": getValueString(metric.toString()),
                            "time": getValueString(value.toString()),
                            // ...(category != null ? {"category": category} : {}),
                          });
                        }
                      })),
            ])),
        const SizedBox(
          height: 24,
        ),
        Expanded(
            child: SingleChildScrollView(
                child: Skeletonizer(
                    enabled: authorQuery.isFetching,
                    child: Column(
                      // scrollDirection: Axis.vertical,
                      children:
                          (authorQuery.data ?? []).asMap().entries.map((entry) {
                        Profile author = entry.value;
                        int index = entry.key;
                        return AuthorRankCard(
                            author: author,
                            // metric: metric,
                            order: (page.value - 1) * 10 + index + 1);
                      }).toList(),
                    )))),
      ],
    ));
  }
}

class RankingTypeButton extends StatelessWidget {
  final bool selected;
  final String title;
  final String iconUrl;

  const RankingTypeButton(
      {super.key,
      required this.selected,
      required this.title,
      required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected ? appColors.primaryLightest : appColors.skyLightest,
          border: Border.all(
              color: selected ? appColors.primaryBase : Colors.transparent,
              width: 1)),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(children: [
            Image.asset(iconUrl, width: 16),
            const SizedBox(width: 4),
            Text(title,
                style: selected
                    ? textTheme.titleMedium!
                        .copyWith(color: appColors.primaryBase)
                    : textTheme.titleMedium)
          ])),
    );
  }
}
