import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/models/Comment.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/relative_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final userName = comment.user?.username ?? 'username';
    final createdTime = comment.createdDate ?? '';
    final content = comment.text;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ClipRRect(
                        // borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(FALLBACK_IMG_URL,
                            width: 40.0, height: 40.0)),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 15),
                        ),
                        Text(
                          formatRelativeTime(createdTime),
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    content,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text('Thích',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(fontSize: 14)),
                                ))),
                        const SizedBox(
                          width: 4,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
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
                        ),
                      ],
                    )
                  ],
                )
              ]),
        ));
  }
}
