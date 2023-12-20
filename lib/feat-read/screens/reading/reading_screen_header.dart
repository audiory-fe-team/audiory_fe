import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReadingScreenHeader extends StatelessWidget {
  final Chapter chapter;
  final Color textColor;

  const ReadingScreenHeader({
    super.key,
    required this.chapter,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    print(chapter);
    print(chapter.currentChapterVerion?.bannerUrl);
    return Column(children: [
      chapter.currentChapterVerion?.bannerUrl == ""
          ? const SizedBox(
              height: 0,
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AppImage(
                  url: chapter.publishedChapterVerion?.bannerUrl,
                  width: double.infinity,
                  height: 130,
                ),
              ),
            ),
      Text('Chương ${chapter.position}:',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: textColor)),
      Text(chapter.title ?? "",
          style:
              Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor),
          softWrap: true),
      const SizedBox(height: 6),
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
              Text(formatNumber(chapter.readCount ?? 0),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: textColor,
                      fontSize: 14,
                      fontStyle: FontStyle.italic))
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
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: textColor,
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
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
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: textColor,
                    fontSize: 14,
                    fontStyle: FontStyle.italic),
              )
            ],
          ),
        ]),
      )
    ]);
  }
}
