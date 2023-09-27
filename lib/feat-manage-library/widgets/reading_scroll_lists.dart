import 'dart:math';
import 'package:audiory_v0/models/ReadingList.dart';
import 'package:audiory_v0/widgets/cards/reading_card_overview.dart';
import 'package:audiory_v0/widgets/cards/story_card_overview.dart';
import 'package:flutter/material.dart';

class ReadingScrollList extends StatelessWidget {
  final List<ReadingList>? storyList;
  final int? length;

  const ReadingScrollList(
      {super.key, required this.storyList, this.length = 5});
  @override
  Widget build(BuildContext context) {
    final list = storyList ?? [];

    return SingleChildScrollView(
      child: Column(
        children: list
            .take(min(list.length, 10))
            .map((story) => Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width - 32,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ReadingCardOverview(
                      title: story.name ?? 'blank',
                      coverUrl: story.coverUrl ??
                          'https://e0.pxfuel.com/wallpapers/650/337/desktop-wallpaper-aesthetic-cute-for-instagram-highlights-some-highlight-covers-for-instagram-stories-from-our-big-catalog.jpg',
                      id: story.id,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
