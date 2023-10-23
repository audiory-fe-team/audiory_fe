import 'package:audiory_v0/feat-read/widgets/chapter_item.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StoryChapterTab extends StatelessWidget {
  final Story? story;

  const StoryChapterTab({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cập nhật đến chương',
              style: textTheme.headlineSmall,
            ),
            IntrinsicHeight(
              child: Row(children: [
                Text('Mới nhất', style: textTheme.labelLarge),
                const VerticalDivider(),
                Text('Cũ nhất', style: textTheme.labelLarge)
              ]),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Column(
          children: (story?.chapters ?? []).asMap().entries.map((entry) {
            Chapter chapter = entry.value;
            int index = entry.key;
            return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ChapterItem(
                  chapter: chapter,
                  position: index,
                ));
          }).toList(),
        ),
      ],
    );
  }
}
