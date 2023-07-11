import 'package:audiory_v0/models/Story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeRankingCard extends StatelessWidget {
  final Story story;
  final int order;
  final Widget? icon;

  const HomeRankingCard(
      {required this.story,
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
        )),
      );
    }

    ;
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getBadgeWidget(order),
          const SizedBox(width: 12),
          Container(
            width: 50,
            height: 70,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(story.coverUrl ?? ''),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              shadows: const [
                BoxShadow(
                  color: Color(0x0C06070D),
                  blurRadius: 14,
                  offset: Offset(0, 7),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Container(
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
                const SizedBox(height: 2),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/heart.svg',
                        width: 8,
                        height: 8,
                        color: const Color(0xFF979C9E),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        story.voteCount.toString() ?? 'error',
                        style: const TextStyle(
                          color: Color(0xFF979C9E),
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
