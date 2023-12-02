import 'dart:math';

import 'package:audiory_v0/feat-read/widgets/chapter_item.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_date.dart';
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

    // final numOfPages = useState(1);
    final currentPage = useState(0);
    final isDesc = useState(false);

    List<Chapter> chaptersList = widget.story?.chapters ?? [];
    List<Chapter> paywalledChapters = widget.story?.chapters
            ?.where((element) =>
                element.isPaywalled == true && element.isPaid == false)
            .toList() ??
        [];
    final totalPages = (chaptersList.length / 10).ceil();
    // numOfPages.value = (chaptersList.length / 10).ceil();
    var pages = List.generate(
      totalPages,
      (index) => Column(
        children: [
          Column(
            children: (isDesc.value == true
                    ? chaptersList.reversed.toList()
                    : chaptersList)
                .getRange(
                    currentPage.value * 10,
                    currentPage.value + 1 == totalPages
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
              'Cập nhật vào ${appFormatDate(widget.story?.updatedDate)}',
              style: textTheme.titleMedium,
            ),
            IntrinsicHeight(
              child: Row(children: [
                TapEffectWrapper(
                  onTap: () {
                    isDesc.value = !isDesc.value;
                  },
                  child: Row(
                    children: [
                      Flexible(
                        child: Text('Sắp xếp',
                            style: textTheme.titleSmall
                                ?.copyWith(color: appColors.primaryBase)),
                      ),
                      Flexible(
                          child: isDesc == true
                              ? Icon(Icons.arrow_downward_sharp)
                              : Icon(Icons.arrow_upward)),
                    ],
                  ),
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
            width: totalPages <= 4 ? size.width / 2 : size.width,
            child: NumberPaginator(
              config: NumberPaginatorUIConfig(
                buttonSelectedBackgroundColor: appColors.primaryBase,
                buttonUnselectedForegroundColor: appColors.primaryBase,
              ),
              controller: paginatorController,
              numberPages: totalPages,
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
