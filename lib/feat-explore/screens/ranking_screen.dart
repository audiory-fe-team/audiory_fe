import 'package:audiory_v0/feat-explore/models/ranking.dart';
import 'package:audiory_v0/feat-explore/screens/layout/ranking_top_bar.dart';
import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/theme/theme_constants.dart';

import 'package:flutter/material.dart';

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
        color: Colors.white,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
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
                    GoRouter.of(context).pushNamed("ranking", queryParameters: {
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
                    GoRouter.of(context).pushNamed("ranking", queryParameters: {
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
                    GoRouter.of(context).pushNamed("ranking", queryParameters: {
                      "type": RankingType.reader.toString().split(".").last,
                      "time": time.toString().split(".").last,
                    });
                  },
                  child: RankingTypeButton(
                    iconUrl: 'assets/images/person_reading.png',
                    title: 'Độc giả',
                    selected: type == RankingType.reader,
                  )),
            ])
          ],
        ),
      )),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
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
