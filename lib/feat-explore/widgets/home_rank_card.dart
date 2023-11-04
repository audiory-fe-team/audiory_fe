import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeRankingCard extends StatelessWidget {
  final Story story;
  final int order;
  final Widget? icon;

  const HomeRankingCard({
    super.key,
    required this.story,
    required this.order,
    this.icon = const SizedBox(width: 12, height: 12),
  });

  @override
  Widget build(BuildContext context) {
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
      return SizedBox(
        width: 24,
        height: 24,
        child: Center(
            child: Image.asset(
          badgePath,
          fit: BoxFit.fitWidth,
        )),
      );
    }

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
        onTap: () {
          GoRouter.of(context).push("/story/${story.id}");
        },
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getBadgeWidget(order),
              const SizedBox(width: 12),
              Skeleton.shade(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        width: 50,
                        height: 70,
                        color: appColors.primaryLightest,
                        child: (story.coverUrl == null || story.coverUrl == '')
                            ? Image.asset(
                                OFFLINE_IMG_URL,
                                fit: BoxFit.fitWidth,
                              )
                            : Image.network(
                                story.coverUrl!,
                                fit: BoxFit.cover,
                              ),
                      ))),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        story.title,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Skeleton.ignore(
                            child: icon ??
                                SvgPicture.asset(
                                  'assets/icons/eye.svg',
                                  width: 12,
                                  height: 12,
                                  color: appColors.skyDark,
                                )),
                        const SizedBox(width: 2),
                        Text(
                          formatNumber(story.totalRead ?? 1000).toString(),
                          style: textTheme.labelLarge?.copyWith(
                              color: appColors.secondaryBase,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
