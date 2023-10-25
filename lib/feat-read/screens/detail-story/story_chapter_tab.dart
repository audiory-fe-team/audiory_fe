import 'dart:math';

import 'package:audiory_v0/feat-read/widgets/chapter_item.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/tap_effect_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StoryChapterTab extends StatefulHookWidget {
  final Story? story;
  final Function(Chapter, int, int) handleBuyChapter;

  const StoryChapterTab(
      {super.key, required this.story, required this.handleBuyChapter});

  @override
  State<StoryChapterTab> createState() => _StoryChapterTabState();
}

class _StoryChapterTabState extends State<StoryChapterTab> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final paginatorController = NumberPaginatorController();

    final numOfPages = useState(1);
    final currentPage = useState(0);
    final isDesc = useState(false);

    List<Chapter> chaptersList = widget.story?.chapters ?? [];
    List<Chapter> paywalledChapters = widget.story?.chapters
            ?.where((element) =>
                element.isPaywalled == true && element.isPaid == true)
            .toList() ??
        [];
    numOfPages.value = (chaptersList.length / 10).ceil();

    var pages = List.generate(
      numOfPages.value,
      (index) => Column(
        children: [
          Column(
            children:
                (isDesc.value ? chaptersList.reversed.toList() : chaptersList)
                    .getRange(
                        currentPage.value * 10,
                        currentPage.value + 1 == numOfPages.value
                            ? currentPage.value * 10 +
                                min(10, chaptersList.length.remainder(10))
                            : currentPage.value * 10 + 10)
                    .toList()
                    .asMap()
                    .entries
                    .map((entry) {
              Chapter chapter = entry.value;
              int index = isDesc.value
                  ? chaptersList.length -
                      1 -
                      (entry.key + currentPage.value * 10)
                  : entry.key + currentPage.value * 10;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ChapterItem(
                  onSelected: (chapter, price) {
                    widget.handleBuyChapter(
                        chapter, price, paywalledChapters.length);
                  },
                  chapter: chapter,
                  position: index + 1,
                  //ispaywalled
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
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
                TapEffectWrapper(
                  onTap: () {
                    isDesc.value = !isDesc.value;
                  },
                  child: Text(
                      isDesc.value ? 'Đọc chương mới nhất' : 'Đọc từ cũ nhất',
                      style: textTheme.titleSmall
                          ?.copyWith(color: appColors.primaryBase)),
                ),
              ]),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          child: pages[currentPage.value],
        ),
        Center(
          child: SizedBox(
            width: numOfPages.value <= 4 ? size.width / 2 : double.infinity,
            child: NumberPaginator(
              config: NumberPaginatorUIConfig(
                buttonSelectedBackgroundColor: appColors.primaryBase,
                buttonUnselectedForegroundColor: appColors.primaryBase,
              ),
              controller: paginatorController,
              numberPages: numOfPages.value,
              onPageChange: (index) {
                currentPage.value = index;
              },
            ),
          ),
        )
      ],
    );
  }
}
