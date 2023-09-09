import 'dart:math';

import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/models/Category.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/feat-explore/widgets/header_with_link.dart';
import 'package:audiory_v0/feat-explore/screens/layout/explore_top_bar.dart';
import 'package:audiory_v0/repositories/category.repository.dart';
import 'package:audiory_v0/repositories/story.repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_outlined_button.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:audiory_v0/widgets/cards/story_card_overview.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fquery/fquery.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ExploreTopBar(),
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(children: [
            const SizedBox(height: 24),
            CategoryCarousel(),
            const SizedBox(height: 24),
            const HeaderWithLink(title: 'Thịnh hành', link: ''),
            const SizedBox(height: 12),
            // StoryScrollList(storyList: STORIES),
            const SizedBox(height: 24),
            // const AuthorRecommendation(),
            const SizedBox(height: 24),
            const CategoryStories(categoryId: 1),
            const SizedBox(height: 24),
            const CategoryStories(categoryId: 2),
          ])),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}

// class AuthorRecommendation extends StatelessWidget {
//   const AuthorRecommendation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(mainAxisSize: MainAxisSize.min, children: [
//       const HeaderWithLink(title: 'Có thể bạn sẽ thích', link: ''),
//       const SizedBox(height: 12),
//       SizedBox(
//           width: double.infinity,
//           height: 124,
//           child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: AUTHOR.length,
//               itemBuilder: (BuildContext context, int index) {
//                 Author author = AUTHOR[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 12),
//                   child: SuggestedAuthor(
//                     name: author.name,
//                     follower: author.follower,
//                     coverUrl: author.coverUrl,
//                   ),
//                 );
//               })),
//     ]);
//   }
// }

class CategoryStories extends HookWidget {
  final int categoryId;

  const CategoryStories({super.key, required this.categoryId});

  @override
  Widget build(
    BuildContext context,
  ) {
    final storyList =
        useQuery(['story_all'], () => StoryRepostitory().fetchStories());

    if (storyList.isLoading) {
      return const Text('Loading...');
    }
    if (storyList.isError) {
      return const Text('Oops something happen');
    }

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
          children: storyList.data!.sublist(0, 1).asMap().entries.map((entry) {
            Story story = entry.value;
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
              children: (storyList.data ?? [])
                  .map((story) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: StoryCardOverView(
                            title: story.title,
                            coverUrl: story.cover_url,
                            id: story.id),
                      ))
                  .toList(),
            ))
      ],
    );
  }
}

class CategoryCarousel extends HookConsumerWidget {
  final CarouselController _controller = CarouselController();

  CategoryCarousel({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = useState(0);

    final categories =
        useQuery(['categories'], () => CategoryRepository().fetchCategory());

    if (categories.isLoading) {
      return const Text('Loading...');
    }
    if (categories.isError) {
      return const Text('Oops something happen');
    }

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final int pageNum = ((categories.data ?? []).length / 6).ceil();

    return SizedBox(
        height: 132,
        child: Column(children: [
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
                height: 132 - 16 - 6,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  current.value = index;
                }),
            items: List.generate(pageNum, (index) {
              return Builder(
                builder: (BuildContext context) {
                  return SizedBox(
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
                          children: (categories.data ?? [])
                              .sublist(
                                  index * 6,
                                  min(index * 6 + 6,
                                      (categories.data ?? []).length))
                              .asMap()
                              .entries
                              .map((entry) {
                            Category category = entry.value;
                            return CategoryBadge(
                              imgUrl: category.imageUrl ?? '',
                              title: category.name ?? '',
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
                    width: current.value == index ? 6 : 4,
                    height: current.value == index ? 6 : 4,
                    margin: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 3.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: current.value == index
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

  const CategoryBadge({super.key, required this.imgUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
          width: double.infinity,
          // height: 47,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(imgUrl, fit: BoxFit.cover),
          )),
      Positioned(
        bottom: 1,
        left: 6,
        child: SizedBox(
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

class SuggestedAuthor extends StatelessWidget {
  final String coverUrl;
  final String name;
  final int follower;

  const SuggestedAuthor(
      {super.key,
      required this.name,
      required this.follower,
      required this.coverUrl});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 70,
                    height: 70,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(coverUrl),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    )),
                const SizedBox(height: 4),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/user.svg',
                          width: 8,
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              "230,5 k",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              height: 21,
              child: AppOutlinedButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero, // Set this
                    padding: EdgeInsets.zero,
                    side: BorderSide(color: appColors.secondaryBase),
                    alignment: Alignment.center // and this
                    ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/heart.svg',
                      width: 10,
                      height: 10,
                      color: appColors.secondaryBase,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Theo dõi',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: appColors.secondaryBase),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
