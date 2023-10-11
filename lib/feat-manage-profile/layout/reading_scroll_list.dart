import 'dart:math';
import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/models/ReadingList.dart';
import 'package:audiory_v0/widgets/cards/story_card_overview.dart';
import 'package:flutter/material.dart';

class ReadingScrollList extends StatelessWidget {
  final List<ReadingList>? readingList;
  final int? length;

  const ReadingScrollList(
      {super.key, required this.readingList, this.length = 5});
  @override
  Widget build(BuildContext context) {
    final list = readingList ?? [];

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list
              .take(min(list.length, 10))
              .map((story) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: StoryCardOverView(
                      title: story.name,
                      coverUrl: story.coverUrl == ''
                          ? FALLBACK_IMG_URL
                          : story.coverUrl,
                      id: story.id,
                    ),
                  ))
              .toList(),
        ));
  }
}
