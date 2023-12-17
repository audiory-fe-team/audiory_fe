import 'dart:math';

import 'package:audiory_v0/feat-explore/models/ranking.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/screens/splash_screen/splash_screen.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StoryRankCard extends StatelessWidget {
  final Story story;
  final int order;
  final Widget? icon;
  final RankingMetric metric;

  const StoryRankCard(
      {super.key,
      required this.story,
      required this.order,
      this.icon = const SizedBox(width: 12, height: 12),
      required this.metric});

  Widget getBadgeWidget(int order, BuildContext context) {
    if (order > 3) {
      return SizedBox(
          width: 24,
          height: 24,
          child: Center(
              child: Text(order.toString(),
                  style: Theme.of(context).textTheme.headlineMedium)));
    }
    String badgePath = '';
    switch (order) {
      case 1:
        badgePath = 'assets/images/gold_badge.png';
        break;
      case 2:
        badgePath = 'assets/images/silver_badge.png';
        break;
      case 3:
        badgePath = 'assets/images/bronze_badge.png';
        break;
    }
    return Center(
        child: Image.asset(
      badgePath,
      fit: BoxFit.fitWidth,
      width: 28,
      height: 28,
    ));
  }

  Widget getTitle(int order, String title, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    if (order > 3) {
      return Text(
        story.title ?? "",
        style: textTheme.titleMedium?.copyWith(color: appColors.inkBase),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }
    LinearGradient gradient = const LinearGradient(colors: []);
    switch (order) {
      case 1:
        gradient = const LinearGradient(colors: [
          Color.fromARGB(255, 219, 168, 40),
          Color.fromARGB(255, 251, 231, 50),
        ]);
        break;
      case 2:
        gradient = const LinearGradient(colors: [
          Color.fromARGB(255, 126, 114, 139),
          Color.fromARGB(255, 199, 203, 252),
        ]);
        break;
      case 3:
        gradient = const LinearGradient(colors: [
          Color.fromARGB(255, 94, 73, 39),
          Color.fromARGB(255, 187, 163, 133),
        ]);
        break;
    }
    return GradientText(
      title,
      style: textTheme.titleMedium?.copyWith(overflow: TextOverflow.ellipsis),
      gradient: gradient,
      maxLines: 2,
    );
  }

  String getStatisticString(Story story, RankingMetric metric) {
    switch (metric) {
      case RankingMetric.total_read:
        {
          return "${formatNumber(story.totalRead ?? 0)} lượt xem";
        }
      case RankingMetric.total_vote:
        {
          return "${formatNumber(story.totalVote ?? 0)} bình chọn";
        }
      default:
        {
          return "${formatNumber(story.totalComment ?? 0)} bình luận";
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appColors = Theme.of(context).extension<AppColors>();

    return GestureDetector(
        onTap: () {
          context.push('/story/${story.id}');
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          width: double.infinity,
          height: 107,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: AppImage(
                      url: story.coverUrl,
                      width: 75,
                      height: 107,
                      fit: BoxFit.fill)),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getTitle(order, story.title ?? "", context),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Skeleton.shade(
                                child: SvgPicture.asset(
                              'assets/icons/write.svg',
                              width: 14,
                              height: 14,
                            )),
                            const SizedBox(width: 6),
                            Text(
                              story.author?.fullName ?? 'Ẩn danh',
                              style: textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                        const SizedBox(height: 0),
                        Row(
                          children: [
                            // Skeleton.replace(
                            //     width: 14,
                            //     height: 14,
                            //     child: SvgPicture.asset(
                            //       'assets/icons/eye.svg',
                            //       width: 14,
                            //       color: appColors.primaryBase,
                            //     )),
                            // const SizedBox(width: 6),
                            Text(
                              getStatisticString(story, metric),
                              style: textTheme.titleSmall!.copyWith(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                  color: appColors?.primaryBase),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                        const Expanded(
                            child: SizedBox(
                          height: 4,
                        )),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: (story.tags ?? [])
                              .sublist(0, min(3, story.tags?.length ?? 0))
                              .map((tag) => Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child:
                                      StoryDetailTag(content: tag.name ?? '')))
                              .toList(),
                        ),
                      ],
                    )),
                    const SizedBox(width: 12),
                    getBadgeWidget(order, context),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
