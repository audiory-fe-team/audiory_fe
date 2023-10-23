import 'dart:math';

import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/widgets/cards/expand_story_card.dart';
import 'package:audiory_v0/widgets/cards/story_card_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class StoryGridList extends StatelessWidget {
  final List<Story>? storyList;

  const StoryGridList({super.key, required this.storyList});
  @override
  Widget build(BuildContext context) {
    final list = storyList?.sublist(0, min(storyList?.length ?? 0, 6)) ?? [];
    final screenWidth = MediaQuery.of(context).size.width;
    final height = screenWidth * 1.1;
    return Column(children: [
      SizedBox(
          width: screenWidth,
          height: height,
          child: LayoutGrid(
              columnSizes: [1.fr, 1.fr, 1.fr],
              rowSizes: [1.fr, 1.fr],
              columnGap: screenWidth * 0.03,
              rowGap: screenWidth * 0.03,
              children: list
                  .map((e) => ExpandedStoryCard(
                        id: e.id,
                        title: e.title,
                        coverUrl: e.coverUrl,
                      ))
                  .toList()))
    ]);
  }
}
