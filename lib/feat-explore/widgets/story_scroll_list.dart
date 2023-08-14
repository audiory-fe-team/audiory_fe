import 'dart:math';

import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/models/StoryServer.dart';
import 'package:audiory_v0/widgets/cards/story_card_overview.dart';
import 'package:flutter/material.dart';

class StoryScrollList extends StatelessWidget {
  final List<Story>? storyList;
  final List<StoryServer>? storyServerList;
  final int? length;

  const StoryScrollList(
      {super.key,
      this.storyList,
      this.storyServerList = const [],
      this.length = 5});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: storyServerList!
              .take(min(storyServerList!.length, 10))
              .map((story) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: StoryCardOverView(
                        title: story.title, coverUrl: story.cover_url),
                  ))
              .toList(),
        ));
  }
}
