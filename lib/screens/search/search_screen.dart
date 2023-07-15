import 'dart:math';

import 'package:audiory_v0/models/Author.dart';
import 'package:audiory_v0/models/Category.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/screens/home/header_with_link.dart';
import 'package:audiory_v0/screens/home/home_screen.dart';
import 'package:audiory_v0/screens/search/suggested_author.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../home/stories_mock.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(children: [
        const SizedBox(height: 24),
        CategoryCarousel(),
        const SizedBox(height: 24),
        HomeRecommendations(),
        const SizedBox(height: 24),
        AuthorRecommendation(),
        const SizedBox(height: 24),
        CategoryStories(categoryId: 1),
        const SizedBox(height: 24),
        CategoryStories(categoryId: 2),
      ]),
    );
  }
}

class AuthorRecommendation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      const HeaderWithLink(title: 'Có thể bạn sẽ thích', link: ''),
      const SizedBox(height: 12),
      Container(
          width: double.infinity,
          height: 124,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AUTHOR.length,
              itemBuilder: (BuildContext context, int index) {
                Author author = AUTHOR[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SuggestedAuthor(
                    name: author.name,
                    follower: author.follower,
                    coverUrl: author.coverUrl,
                  ),
                );
              })),
    ]);
  }
}

class CategoryStories extends StatelessWidget {
  final int categoryId;

  const CategoryStories({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderWithLink(title: 'Bí ẩn', link: ''),
        const SizedBox(height: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: STORIES.sublist(0, 1).asMap().entries.map((entry) {
            Story story = entry.value;
            int index = entry.key;
            return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: StoryCardDetail(
                  story: story,
                ));
          }).toList(),
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: STORIES
                  .map((story) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: StoryCardOverView(
                            title: story.title, coverUrl: story.coverUrl),
                      ))
                  .toList(),
            ))
      ],
    );
  }
}

class CategoryCarousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryCarouselState();
  }
}

class _CategoryCarouselState extends State<CategoryCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final int pageNum = (CATEGORIES.length / 6).ceil();
    return Container(
        height: 132,
        child: Column(children: [
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
                height: 132 - 16 - 6,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: List.generate(pageNum, (index) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: double.infinity,
                      child: LayoutGrid(
                          rowGap: 16,
                          columnGap: 16,
                          columnSizes: [
                            1.fr,
                            1.fr,
                            1.fr,
                          ],
                          rowSizes: [
                            1.fr,
                            1.fr,
                          ],
                          children: CATEGORIES
                              .sublist(index * 6,
                                  min(index * 6 + 6, CATEGORIES.length))
                              .asMap()
                              .entries
                              .map((entry) {
                            Category category = entry.value;
                            int index = entry.key;
                            return CategoryBadge(
                              imgUrl: category.coverUrl ?? '',
                              title: category.title ?? '',
                            );
                          }).toList()));
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(pageNum, (index) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(index),
                child: Container(
                    width: _current == index ? 6 : 4,
                    height: _current == index ? 6 : 4,
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 3.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? appColors.primaryBase
                          : appColors.skyLight,
                    )),
              );
            }).toList(),
          ),
        ]));
  }
}

class CategoryBadge extends StatelessWidget {
  final String imgUrl;
  final String title;

  const CategoryBadge({required this.imgUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Stack(children: [
      Container(
          width: double.infinity,
          // height: 47,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(imgUrl, fit: BoxFit.cover),
          )),
      Positioned(
        bottom: 1,
        left: 6,
        child: Container(
          width: 86,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
        ),
      )
    ]);
  }
}
