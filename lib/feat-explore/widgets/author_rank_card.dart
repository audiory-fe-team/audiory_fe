import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthorRankCard extends StatelessWidget {
  final Story story;
  final int order;
  final Widget? icon;

  const AuthorRankCard(
      {super.key,
      required this.story,
      required this.order,
      this.icon = const SizedBox(width: 12, height: 12)});

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
          width: 24,
        )),
      );
    }

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Container(
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
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://res.cloudinary.com/ddvdxx85g/image/upload/v1678858100/samples/animals/cat.jpg'),
                fit: BoxFit.fill,
              ),
              shape: CircleBorder(),
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
                      'Tác giả X',
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
                            SvgPicture.asset(
                              'assets/icons/eye.svg',
                              width: 14,
                              color: appColors.primaryBase,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '1,805, 834 lượt xem',
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
    );
  }
}
