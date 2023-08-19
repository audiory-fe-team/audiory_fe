import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentCard extends StatelessWidget {
  final String name;
  final String time;
  final String content;
  final String image;
  const CommentCard(
      {super.key,
      this.name = '',
      this.time = '',
      this.content = '',
      this.image = ''});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    return Expanded(
      // margin: EdgeInsets.symmetric(vertical: 2),
      // width: double.maxFinite,
      // height: 120,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                    // borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset('assets/images/user-avatar.jpg',
                        width: 30.0, height: 30.0)),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'dipisci elit, sed eiusmod minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur. Quis esse cillum dolore eu fugiat',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Text('Thích',
                          style: Theme.of(context).textTheme.labelLarge),
                    ),
                    GestureDetector(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Trả lời',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    )),
                    SvgPicture.asset(
                      'assets/icons/more-vertical.svg',
                      width: 8,
                      height: 8,
                      color: appColors.inkDark,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset(
                        'assets/icons/flag.svg',
                        width: 12,
                        height: 12,
                        color: appColors.secondaryBase,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          '7',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: appColors.primaryBase),
                        )),
                    SvgPicture.asset(
                      'assets/icons/thump-up.svg',
                      width: 12,
                      height: 12,
                      color: appColors.primaryBase,
                    ),
                  ],
                )
              ],
            )
          ]),
    );
  }
}
