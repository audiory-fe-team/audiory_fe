import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              SvgPicture.asset(
                'assets/icons/eye.svg',
                width: 14,
                height: 14,
                color: appColors.primaryBase,
              ),
              const SizedBox(width: 4),
              Text(
                chapter.readCount.toString(),
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
              SvgPicture.asset(
                'assets/icons/heart.svg',
                width: 14,
                height: 14,
                color: appColors.primaryBase,
              ),
              const SizedBox(width: 4),
              Text(
                chapter.voteCount.toString(),
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
              SvgPicture.asset(
                'assets/icons/message-box-circle.svg',
                width: 14,
                height: 14,
                color: appColors.primaryBase,
              ),
              const SizedBox(width: 4),
              Text(
                chapter.commentCount.toString(),
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
