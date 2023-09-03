import 'package:audiory_v0/feat-explore/utils/ranking.dart';
import 'package:audiory_v0/feat-explore/models/ranking.dart';
import 'package:audiory_v0/feat-explore/screens/layout/ranking_top_bar.dart';
import 'package:audiory_v0/feat-explore/widgets/author_rank_card.dart';
import 'package:audiory_v0/feat-explore/widgets/ranking_dropdown.dart';
import 'package:audiory_v0/feat-explore/widgets/story_rank_card.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/theme/theme_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RankingScreen extends HookConsumerWidget {
  final RankingType type;
  final RankingMetric metric;
  final RankingTimeRange time;
  //NOTE: Search for stories or
  const RankingScreen({
    super.key,
    this.type = RankingType.story,
    this.metric = RankingMetric.view,
    this.time = RankingTimeRange.this_week,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    // final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const RankingTopBar(),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              InkWell(
                  onTap: () {
                    GoRouter.of(context).goNamed("ranking", queryParameters: {
                      "type": RankingType.story.toString().split(".").last,
                      "time": time.toString().split(".").last,
                    });
                  },
                  child: RankingTypeButton(
                    iconUrl: 'assets/images/book.png',
                    title: 'Tác phẩm',
                    selected: type == RankingType.story,
                  )),
              const SizedBox(width: 12),
              InkWell(
                  onTap: () {
                    GoRouter.of(context).goNamed("ranking", queryParameters: {
                      "type": RankingType.author.toString().split(".").last,
                      "time": time.toString().split(".").last,
                    });
                  },
                  child: RankingTypeButton(
                    iconUrl: 'assets/images/hand_with_pen.png',
                    title: 'Tác giả',
                    selected: type == RankingType.author,
                  )),
              const SizedBox(width: 12),
              InkWell(
                  onTap: () {
                    GoRouter.of(context).goNamed("ranking", queryParameters: {
                      "type": RankingType.reader.toString().split(".").last,
                      "time": time.toString().split(".").last,
                    });
                  },
                  child: RankingTypeButton(
                    iconUrl: 'assets/images/person_reading.png',
                    title: 'Độc giả',
                    selected: type == RankingType.reader,
                  )),
            ]),
            const SizedBox(
              height: 24,
            ),
            Builder(builder: (_) {
              if (type == RankingType.author) return const AuthorRanking();
              if (type == RankingType.reader) return const ReaderRanking();
              return StoryRanking(
                metric: metric,
                time: time,
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

  const StoryRanking(
      {this.metric = RankingMetric.view,
      this.time = RankingTimeRange.this_month,
      super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
        child: Column(
      children: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              RankingDropdownWrapper(
                  title: 'Xếp theo: ',
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
                          value: RankingMetric.view,
                          child: Text('Lượt đọc'),
                        ),
                        DropdownMenuItem(
                          value: RankingMetric.vote,
                          child: Text('Bình chọn'),
                        ),
                        DropdownMenuItem(
                          value: RankingMetric.gift,
                          child: Text('Tặng quà'),
                        ),
                        DropdownMenuItem(
                          value: RankingMetric.comment,
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
                          });
                        }
                      })),
              const SizedBox(width: 12),
              RankingDropdownWrapper(
                  title: 'Thời gian: ',
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
                          value: RankingTimeRange.today,
                          child: Text('Hôm nay'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.this_week,
                          child: Text('Tuần này'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.this_month,
                          child: Text('Tháng này'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.this_year,
                          child: Text('Năm nay'),
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
                          });
                        }
                      }))
            ])),
        const SizedBox(
          height: 24,
        ),
        const Expanded(
            child: SingleChildScrollView(
                child: Column(
          // scrollDirection: Axis.vertical,
          children: [
            StoryRankCard(story: Story(id: '123', title: 'haha'), order: 1),
            StoryRankCard(story: Story(id: '12', title: 'haha'), order: 2),
            StoryRankCard(story: Story(id: '23', title: 'haha'), order: 3),
            StoryRankCard(story: Story(id: '13', title: 'haha'), order: 4),
            StoryRankCard(story: Story(id: '13', title: 'haha'), order: 5),
            StoryRankCard(story: Story(id: '123', title: 'haha'), order: 6),
            StoryRankCard(story: Story(id: '12', title: 'haha'), order: 7),
            StoryRankCard(story: Story(id: '23', title: 'haha'), order: 8),
            StoryRankCard(story: Story(id: '13', title: 'haha'), order: 9),
            StoryRankCard(story: Story(id: '13', title: 'haha'), order: 10),
          ],
        ))),
      ],
    ));
  }
}

class AuthorRanking extends HookWidget {
  final RankingMetric metric;
  final RankingTimeRange time;

  const AuthorRanking(
      {this.metric = RankingMetric.view,
      this.time = RankingTimeRange.this_month,
      super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
        child: Column(
      children: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              RankingDropdownWrapper(
                  title: 'Xếp theo: ',
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
                          value: RankingMetric.view,
                          child: Text('Lượt đọc'),
                        ),
                        DropdownMenuItem(
                          value: RankingMetric.vote,
                          child: Text('Bình chọn'),
                        ),
                        DropdownMenuItem(
                          value: RankingMetric.gift,
                          child: Text('Tặng quà'),
                        ),
                        DropdownMenuItem(
                          value: RankingMetric.follower,
                          child: Text('Người theo dõi'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != metric) {
                          GoRouter.of(context)
                              .goNamed('ranking', queryParameters: {
                            "type":
                                getValueString(RankingType.author.toString()),
                            "metric": getValueString(value.toString()),
                            "time": getValueString(time.toString()),
                          });
                        }
                      })),
              const SizedBox(width: 12),
              RankingDropdownWrapper(
                  title: 'Thời gian: ',
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
                          value: RankingTimeRange.today,
                          child: Text('Hôm nay'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.this_week,
                          child: Text('Tuần này'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.this_month,
                          child: Text('Tháng này'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.this_year,
                          child: Text('Năm nay'),
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
                            "metric": getValueString(metric.toString()),
                            "time": getValueString(value.toString()),
                          });
                        }
                      }))
            ])),
        const SizedBox(
          height: 24,
        ),
        const Expanded(
            child: SingleChildScrollView(
                child: Column(
          // scrollDirection: Axis.vertical,
          children: [
            AuthorRankCard(story: Story(id: '123', title: 'haha'), order: 1),
            AuthorRankCard(story: Story(id: '12', title: 'haha'), order: 2),
            AuthorRankCard(story: Story(id: '23', title: 'haha'), order: 3),
            AuthorRankCard(story: Story(id: '13', title: 'haha'), order: 4),
            AuthorRankCard(story: Story(id: '13', title: 'haha'), order: 5),
            AuthorRankCard(story: Story(id: '123', title: 'haha'), order: 6),
            AuthorRankCard(story: Story(id: '12', title: 'haha'), order: 7),
            AuthorRankCard(story: Story(id: '23', title: 'haha'), order: 8),
            AuthorRankCard(story: Story(id: '13', title: 'haha'), order: 9),
            AuthorRankCard(story: Story(id: '13', title: 'haha'), order: 10),
          ],
        ))),
      ],
    ));
  }
}

class ReaderRanking extends HookWidget {
  final RankingMetric metric;
  final RankingTimeRange time;

  const ReaderRanking(
      {this.metric = RankingMetric.view,
      this.time = RankingTimeRange.this_month,
      super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
        child: Column(
      children: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              RankingDropdownWrapper(
                  title: 'Xếp theo: ',
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
                          value: RankingMetric.view,
                          child: Text('Lượt đọc'),
                        ),
                        DropdownMenuItem(
                          value: RankingMetric.vote,
                          child: Text('Bình chọn'),
                        ),
                        DropdownMenuItem(
                          value: RankingMetric.gift,
                          child: Text('Tặng quà'),
                        ),
                        DropdownMenuItem(
                          value: RankingMetric.follower,
                          child: Text('Người theo dõi'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != metric) {
                          GoRouter.of(context)
                              .goNamed('ranking', queryParameters: {
                            "type":
                                getValueString(RankingType.author.toString()),
                            "metric": getValueString(value.toString()),
                            "time": getValueString(time.toString()),
                          });
                        }
                      })),
              const SizedBox(width: 12),
              RankingDropdownWrapper(
                  title: 'Thời gian: ',
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
                          value: RankingTimeRange.today,
                          child: Text('Hôm nay'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.this_week,
                          child: Text('Tuần này'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.this_month,
                          child: Text('Tháng này'),
                        ),
                        DropdownMenuItem(
                          value: RankingTimeRange.this_year,
                          child: Text('Năm nay'),
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
                            "metric": getValueString(metric.toString()),
                            "time": getValueString(value.toString()),
                          });
                        }
                      }))
            ])),
        const SizedBox(
          height: 24,
        ),
        const Expanded(
            child: SingleChildScrollView(
                child: Column(
          // scrollDirection: Axis.vertical,
          children: [
            AuthorRankCard(story: Story(id: '123', title: 'haha'), order: 1),
            AuthorRankCard(story: Story(id: '12', title: 'haha'), order: 2),
            AuthorRankCard(story: Story(id: '23', title: 'haha'), order: 3),
            AuthorRankCard(story: Story(id: '13', title: 'haha'), order: 4),
            AuthorRankCard(story: Story(id: '13', title: 'haha'), order: 5),
            AuthorRankCard(story: Story(id: '123', title: 'haha'), order: 6),
            AuthorRankCard(story: Story(id: '12', title: 'haha'), order: 7),
            AuthorRankCard(story: Story(id: '23', title: 'haha'), order: 8),
            AuthorRankCard(story: Story(id: '13', title: 'haha'), order: 9),
            AuthorRankCard(story: Story(id: '13', title: 'haha'), order: 10),
          ],
        ))),
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
