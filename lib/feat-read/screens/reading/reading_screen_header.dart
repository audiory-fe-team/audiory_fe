import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReadingScreenHeader extends StatelessWidget {
  final int num;
  final Chapter chapter;

  const ReadingScreenHeader({
    super.key,
    required this.num,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Column(children: [
      Text('Chương ${(num + 1)}:',
          style: Theme.of(context).textTheme.bodyLarge),
      Text(chapter.title,
          style: Theme.of(context).textTheme.bodyLarge, softWrap: true),
      const SizedBox(height: 12),
      SizedBox(
        height: 24,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Row(
            children: [
              Skeleton.shade(
                  child: Image.asset(
                'assets/images/view_colored.png',
                width: 16,
              )),
              const SizedBox(width: 2),
              Text(
                formatNumber(chapter.readCount ?? 0),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
          const SizedBox(width: 24),
          Row(
            children: [
              Skeleton.shade(
                  child: Image.asset(
                'assets/images/vote_colored.png',
                width: 16,
              )),
              const SizedBox(width: 2),
              Text(
                formatNumber(chapter.voteCount ?? 0),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
          const SizedBox(width: 24),
          Row(
            children: [
              Skeleton.shade(
                  child: Image.asset(
                'assets/images/comment_colored.png',
                width: 16,
              )),
              const SizedBox(width: 2),
              Text(
                formatNumber(chapter.commentCount ?? 0),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
        ]),
      )
    ]);
  }
}
