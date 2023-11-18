import 'package:audiory_v0/feat-explore/models/ranking.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AuthorRankCard extends StatelessWidget {
  final Profile author;
  final RankingMetric metric;
  final int order;
  final Widget? icon;

  const AuthorRankCard(
      {super.key,
      required this.author,
      required this.order,
      required this.metric,
      this.icon = const SizedBox(width: 12, height: 12)});

  @override
  Widget build(BuildContext context) {
    String getStatisticString(Profile profile, RankingMetric metric) {
      switch (metric) {
        case RankingMetric.total_read:
          {
            return "${formatNumber(profile.totalRead ?? 0)} lượt xem";
          }
        case RankingMetric.total_vote:
          {
            return "${formatNumber(profile.totalVote ?? 0)} bình chọn";
          }
        default:
          {
            return "${formatNumber(profile.totalComment ?? 0)} bình luận";
          }
      }
    }

    Widget getBadgeWidget(int order) {
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

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
        onTap: () {
          // context.push('/profile/${author.id}');
          context.push('/accountProfile/${author.id}',
              extra: {'name': author.fullName, 'avatar': author.avatarUrl});
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          width: double.infinity,
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(author.avatarUrl ?? ''),
                    fit: BoxFit.fill,
                  ),
                  shape: const CircleBorder(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          author.fullName ?? 'Ẩn danh',
                          style: textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                            height: 20,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Skeleton.ignore(child: () {
                                  if (metric == RankingMetric.total_comment) {
                                    return SvgPicture.asset(
                                      'assets/icons/message-box-circle.svg',
                                      width: 14,
                                      color: appColors.primaryBase,
                                    );
                                  }
                                  if (metric == RankingMetric.total_read) {
                                    return SvgPicture.asset(
                                      'assets/icons/eye.svg',
                                      width: 14,
                                      color: appColors.primaryBase,
                                    );
                                  }
                                  return SvgPicture.asset(
                                    'assets/icons/heart.svg',
                                    width: 14,
                                    color: appColors.primaryBase,
                                  );
                                }()),
                                const SizedBox(width: 4),
                                Text(
                                  getStatisticString(author, metric),
                                  style: textTheme.titleSmall!.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600,
                                      color: appColors.primaryBase),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ))
                      ],
                    )),
                    const SizedBox(width: 12),
                    getBadgeWidget(order),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
