import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/screens/home/header_with_link.dart';
import 'package:audiory_v0/screens/search/search_screen.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'stories_mock.dart';

class HomeScreeen extends StatelessWidget {
  const HomeScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: ListView(
          children: [
            Banners(),
            const SizedBox(height: 32),
            HomeRecommendations(),
            const SizedBox(height: 32),
            HomeRankingList(),
            const SizedBox(height: 32),
            HotStories(),
            const SizedBox(height: 32),
            PaidStories(),
            const SizedBox(height: 32),
            ContinueReading(),
          ],
        ));
  }
}

class Banners extends StatelessWidget {
  final BANNERS_LIST = [
    'https://t3.ftcdn.net/jpg/03/21/97/42/360_F_321974259_BnmlxfkknMol8HiQ0dg1bwQizor48uB9.jpg',
    'https://t3.ftcdn.net/jpg/03/21/97/42/360_F_321974259_BnmlxfkknMol8HiQ0dg1bwQizor48uB9.jpg',
    'https://t3.ftcdn.net/jpg/03/21/97/42/360_F_321974259_BnmlxfkknMol8HiQ0dg1bwQizor48uB9.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 122,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: BANNERS_LIST.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: 240,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      BANNERS_LIST[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ));
          }),
    );
  }
}

class StoryCardOverView extends StatelessWidget {
  final String? coverUrl;
  final String title;

  const StoryCardOverView({this.title = '', this.coverUrl = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 95,
            height: 135,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(this.coverUrl ?? ''),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadows: const [
                BoxShadow(
                  color: Color(0x0C06070D),
                  blurRadius: 14,
                  offset: Offset(0, 7),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 95,
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    this.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF404446),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeRecommendations extends StatelessWidget {
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
              itemCount: STORIES.length,
              itemBuilder: (BuildContext context, int index) {
                Story story = STORIES[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: StoryCardOverView(
                      title: story.title, coverUrl: story.coverUrl),
                );
              })),
    ]);
  }
}

class RankingListBadge extends StatelessWidget {
  final String label;
  final bool selected;

  const RankingListBadge({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: ShapeDecoration(
        color: selected ? const Color(0xFF439A97) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  selected ? const Color(0xFFFFFDFD) : const Color(0xFF404446),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeRankingList extends StatelessWidget {
  static const OPTIONS = ['Truyện hot tháng', 'Truyện bình luận nhiều'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const HeaderWithLink(title: 'BXH Tháng này', link: ''),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: OPTIONS
                .map((option) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: RankingListBadge(
                      label: option,
                      selected: true,
                    )))
                .toList(),
          ),
        ),
        const SizedBox(height: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: STORIES.sublist(0, 5).asMap().entries.map((entry) {
            Story story = entry.value;
            int index = entry.key;
            return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: HomeRankingCard(
                  order: index + 1,
                  story: story,
                  icon: InkWell(
                    child: SvgPicture.asset(
                      'assets/icons/heart.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ));
          }).toList(),
        ),
      ]),
    );
  }
}

class HomeRankingCard extends StatelessWidget {
  final Story story;
  final int order;
  final Widget? icon;

  const HomeRankingCard(
      {required this.story,
      required this.order,
      this.icon = const SizedBox(width: 12, height: 12)});

  @override
  Widget build(BuildContext context) {
    Widget getBadgeWidget(int order) {
      if (order > 3) {
        return SizedBox(
            width: 24,
            height: 24,
            child: Center(
                child: Text(order.toString(),
                    style: Theme.of(context).textTheme.headlineMedium)));
      }
      String badgePath = '';
      switch (order) {
        case 1:
          badgePath = 'assets/images/gold_badge.png';
          break;
        case 2:
          badgePath = 'assets/images/silver_badge.png';
          break;
        case 3:
          badgePath = 'assets/images/bronze_badge.png';
          break;
      }
      return SizedBox(
        width: 24,
        height: 24,
        child: Center(
            child: Image.asset(
          badgePath,
          fit: BoxFit.fitWidth,
        )),
      );
    }

    ;
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getBadgeWidget(order),
          const SizedBox(width: 12),
          Container(
            width: 50,
            height: 70,
            decoration: ShapeDecoration(
              image: const DecorationImage(
                image: NetworkImage("https://via.placeholder.com/50x70"),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              shadows: const [
                BoxShadow(
                  color: Color(0x0C06070D),
                  blurRadius: 14,
                  offset: Offset(0, 7),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    story.title,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/heart.svg',
                        width: 8,
                        height: 8,
                        color: const Color(0xFF979C9E),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        story.voteCount.toString() ?? 'error',
                        style: const TextStyle(
                          color: Color(0xFF979C9E),
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class PaidStories extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderWithLink(title: 'Truyện trả phí', link: ''),
        const SizedBox(height: 12),
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

class HotStories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderWithLink(title: 'Thịnh hành', link: ''),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 176,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Image.network(
            'https://via.placeholder.com/347x176',
            fit: BoxFit.fill,
            loadingBuilder: (BuildContext ctx, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                );
              }
              ;
            },
          ),
        ),
        const SizedBox(height: 12),
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

class ContinueReading extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderWithLink(title: 'Tiếp tục đọc', link: ''),
        const SizedBox(height: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: STORIES.sublist(0, 3).asMap().entries.map((entry) {
            Story story = entry.value;
            int index = entry.key;
            return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: StoryCardDetail(
                  story: story,
                ));
          }).toList(),
        ),
      ],
    );
  }
}
