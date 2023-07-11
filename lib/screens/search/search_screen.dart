import 'package:audiory_v0/models/Author.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/screens/home/header_with_link.dart';
import 'package:audiory_v0/screens/home/home_screen.dart';
import 'package:audiory_v0/screens/search/suggested_author.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:flutter/material.dart';
import '../home/stories_mock.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: ListView(children: [
        HomeRecommendations(),
        const SizedBox(height: 24),
        AuthorRecommendation(),
        const SizedBox(height: 24),
        CategoryStories(),
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
          height: 180,
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

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      scrollDirection: Axis.horizontal,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(100, (index) {
        return Center(
          child: Text(
            'Item $index',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        );
      }),
    );
  }
}

class CategoryBadge extends StatelessWidget {
  final String imgUrl;
  final String title;

  const CategoryBadge({required this.imgUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 47,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 46.88,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0x1125282B), Colors.black],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadows: [
                BoxShadow(
                  color: Color(0x0C06070D),
                  blurRadius: 14,
                  offset: Offset(0, 7),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          SizedBox(
            width: 86,
            child: Text(
              'Romantic',
              style: TextStyle(
                color: Color(0xFFFFFDFD),
                fontSize: 16,
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.02,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
