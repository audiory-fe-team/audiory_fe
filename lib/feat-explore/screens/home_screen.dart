import 'package:audiory_v0/feat-explore/widgets/home_rank_card.dart';
import 'package:audiory_v0/feat-explore/widgets/story_scroll_list.dart';
import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/feat-explore/widgets/header_with_link.dart';
import 'package:audiory_v0/feat-explore/screens/layout/home_top_bar.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/mock_data.dart';

class HomeScreeen extends StatelessWidget {
  const HomeScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeTopBar(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 32),
              const HomeBanners(),
              const SizedBox(height: 32),

              //NOTE: Recommendations section
              const HeaderWithLink(title: 'Có thể bạn sẽ thích', link: ''),
              const SizedBox(height: 12),
              const StoryScrollList(storyList: STORIES),
              const SizedBox(height: 32),
              //NOTE: Ranking section
              const HomeRankingList(),
              const SizedBox(height: 32),

              //NOTE: Hot section
              const HeaderWithLink(title: 'Thịnh hành', link: ''),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 176,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://via.placeholder.com/347x176',
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(height: 12),
              const StoryScrollList(storyList: STORIES),
              const SizedBox(height: 32),

              //NOTE: Paid section
              const HeaderWithLink(title: 'Truyện trả phí', link: ''),
              const SizedBox(height: 12),
              const StoryScrollList(storyList: STORIES),
              const SizedBox(height: 32),

              //NOTE: Continue reading section
              const HeaderWithLink(title: 'Tiếp tục đọc', link: ''),
              const SizedBox(height: 12),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: STORIES.sublist(0, 3).asMap().entries.map((entry) {
                    Story story = entry.value;
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(color: Colors.amber));
                    // child: StoryCardDetail(
                    //   story: story,
                    // ));
                  }).toList()),
              const SizedBox(height: 32),
            ],
          )),
    );
  }
}

class HomeBanners extends StatelessWidget {
  static const List<String> bannerList = [
    'https://t3.ftcdn.net/jpg/03/21/97/42/360_F_321974259_BnmlxfkknMol8HiQ0dg1bwQizor48uB9.jpg',
    'https://t3.ftcdn.net/jpg/03/21/97/42/360_F_321974259_BnmlxfkknMol8HiQ0dg1bwQizor48uB9.jpg',
    'https://t3.ftcdn.net/jpg/03/21/97/42/360_F_321974259_BnmlxfkknMol8HiQ0dg1bwQizor48uB9.jpg'
  ];

  const HomeBanners({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 122,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bannerList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: 240,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      bannerList[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                ));
          }),
    );
  }
}

class RankingListBadge extends StatelessWidget {
  final String label;
  final bool selected;

  const RankingListBadge(
      {super.key, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: ShapeDecoration(
        color: selected ? appColors.primaryBase : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: selected ? appColors.inkBase : appColors.primaryBase,
                  )),
        ],
      ),
    );
  }
}

class HomeRankingList extends StatelessWidget {
  static const options = ['Truyện hot tháng', 'Truyện bình luận nhiều'];

  const HomeRankingList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const HeaderWithLink(title: 'BXH Tháng này', link: ''),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: options
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
