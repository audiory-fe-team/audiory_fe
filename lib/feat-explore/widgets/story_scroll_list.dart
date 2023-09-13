import 'dart:math';

import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/widgets/cards/story_card_overview.dart';
import 'package:flutter/material.dart';

class StoryScrollList extends StatelessWidget {
  final List<Story>? storyList;
  final int? length;

  const StoryScrollList({super.key, required this.storyList, this.length = 5});
  @override
  Widget build(BuildContext context) {
    final list = storyList ?? [];

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
                      title: story.title,
                      coverUrl: story.coverUrl,
                      id: story.id,
                    ),
                  ))
              .toList(),
        ));
  }
}
