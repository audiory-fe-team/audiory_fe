import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/widgets/cards/story_card_overview.dart';
import 'package:flutter/material.dart';

class StoryScrollList extends StatelessWidget {
  final List<Story> storyList;

  const StoryScrollList({super.key, required this.storyList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: storyList
              .map((story) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: StoryCardOverView(
                        title: story.title, coverUrl: story.coverUrl),
                  ))
              .toList(),
        ));
  }
}
