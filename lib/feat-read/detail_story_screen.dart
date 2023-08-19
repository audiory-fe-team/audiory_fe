import 'package:audiory_v0/models/Author.dart';
import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/feat-read/widgets/chapter.dart';
import 'package:audiory_v0/feat-read/widgets/commentCard.dart';
import 'package:audiory_v0/feat-read/widgets/detail_story_bottom_bar.dart';
import 'package:audiory_v0/feat-read/widgets/supporterCard.dart';
import 'package:audiory_v0/services/author_services.dart';
import 'package:audiory_v0/services/story_services.dart';
import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:audiory_v0/widgets/cards/donate_item_card.dart';
import 'package:audiory_v0/widgets/paginators/number_paginator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme/theme_constants.dart';
import '../widgets/category_badge.dart';
import 'package:readmore/readmore.dart';

class DetailStoryScreen extends HookConsumerWidget {
  final String id;

  @override
  const DetailStoryScreen({this.id = '', super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final tabController = useTabController(initialLength: 2);
    final storyQuery =
        useQuery(['story', id], () => StoryService().fetchStoryById(id));

    final authorQuery = useQuery(['author', storyQuery.data?.author_id],
        () => AuthorService().fetchAuthorById(storyQuery.data?.author_id),
        enabled: storyQuery.isSuccess);

    final tabState = useState(0);

    Widget donateGiftModal() {
      const GIFTS = [
        'rose',
        'teddy',
        'golden',
        'knife',
        'ring',
        'flower',
        'diamond',
        'golden',
      ];
      return Expanded(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Vật phẩm',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: 4,
                  runSpacing: 12,
                  children: GIFTS
                      .map((option) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: DonateItemCard(
                            name: option,
                          )))
                      .toList(),
                ),
              )
            ]),
      ));
    }

    Widget interactionInfo(Story? story) {
      final sharedNumberStyle =
          textTheme.titleLarge!.copyWith(color: appColors.inkLight);
      final sharedHeaderStyle = textTheme.titleSmall;
      return IntrinsicHeight(
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/chapter_colored.png',
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Chương',
                      style: sharedHeaderStyle,
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Text((story?.chapters?.length ?? '').toString(),
                    style: sharedNumberStyle)
              ],
            ),
            VerticalDivider(),
            Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/view_colored.png',
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Lượt đọc',
                      style: sharedHeaderStyle,
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Text((story?.read_count ?? '').toString(),
                    style: sharedNumberStyle)
              ],
            ),
            VerticalDivider(),
            Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/comment_colored.png',
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Bình luận',
                      style: sharedHeaderStyle,
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Text((story?.vote_count ?? '').toString(),
                    style: sharedNumberStyle)
              ],
            ),
            VerticalDivider(),
            Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/vote_colored.png',
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Bình chọn',
                      style: sharedHeaderStyle,
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Text((story?.vote_count ?? '').toString(),
                    style: sharedNumberStyle)
              ],
            ),
          ]));
    }

    Widget storyInfo(Story? story) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 165,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(story?.cover_url ?? ''),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            story?.title ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      );
    }

    Widget chapterView(Story? story, BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cập nhật đến chương',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                child: Row(children: [
                  Text(
                    'Mới nhất',
                    style: TextStyle(color: appColors.primaryBase),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text('Cũ nhất')
                ]),
              ),
            ],
          ),
          Column(
            children: (story?.chapters ?? []).asMap().entries.map((entry) {
              Chapter chapter = entry.value;
              int index = entry.key;
              return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ChapterItem(
                    title: 'Chương ${index + 1}: ' + chapter.title,
                    time: '20',
                  ));
            }).toList(),
          ),
          const ListWithPaginator()
        ],
      );
    }

    Widget detailView(Story? story, BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          Text('Giới thiệu', style: textTheme.headlineSmall),
          const SizedBox(
            height: 8,
          ),
          ReadMoreText(
            story?.description ?? '',
            trimLines: 4,
            colorClickableText: appColors.primaryBase,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Xem thêm',
            trimExpandedText: ' Ẩn bớt',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
            moreStyle:
                textTheme.titleMedium?.copyWith(color: appColors.primaryBase),
          ),
          const SizedBox(
            height: 24,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Người ủng hộ',
                style: textTheme.headlineSmall,
              ),
              Container(
                height: 34,
                child: AppIconButton(
                    title: 'Tặng quà',
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: appColors.primaryBase),
                    icon: Icon(
                      Icons.card_giftcard,
                      color: appColors.primaryBase,
                      size: 14,
                    ),
                    iconPosition: 'start',
                    color: appColors.primaryBase,
                    bgColor: appColors.primaryLightest,
                    onPressed: () => {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return donateGiftModal();
                              })
                        }),
              ),
            ],
          ),
          // _supporterList(),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bình luận nổi bật',
                style: textTheme.headlineSmall,
              ),
              GestureDetector(
                child: SvgPicture.asset(
                  'assets/icons/right-arrow.svg',
                  width: 24,
                  height: 24,
                  color: appColors.inkDark,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          // _commentList()
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
          storyQuery.data?.title ?? 'Loading...',
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            child: const Icon(Icons.more_vert_sharp),
          )
        ],
      ),
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(builder: (context) {
                  if (storyQuery.isLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: appColors.primaryBase,
                    ));
                  }
                  if (storyQuery.isError) {
                    return const Text('Failed');
                  }
                  return storyInfo(storyQuery.data);
                }),
                const SizedBox(height: 12),
                //NOTE: Author image
                Builder(builder: (context) {
                  if (authorQuery.isLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: appColors.primaryBase,
                    ));
                  }
                  if (authorQuery.isError) {
                    return const Text('Failed fetch author');
                  }
                  return Material(
                      child: InkWell(
                          onTap: () async {
                            // context.go('/profile');
                          },
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          authorQuery.data?.avatarUrl ?? ''),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: CircleBorder(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  authorQuery.data?.fullName ?? '',
                                  style: textTheme.titleMedium!
                                      .copyWith(fontWeight: FontWeight.w400),
                                )
                              ])));
                }),
                const SizedBox(height: 24),
                interactionInfo(storyQuery.data),
                const SizedBox(height: 24),
                Builder(builder: (context) {
                  if (storyQuery.isLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: appColors.primaryBase,
                    ));
                  }
                  if (storyQuery.isError) {
                    return const Text('Failed');
                  }
                  return SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 1,
                        runSpacing: 6,
                        children: (storyQuery.data?.tags ?? [])
                            .map((tag) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: RankingListBadge(
                                  label: tag.name,
                                  selected: false,
                                )))
                            .toList(),
                      ));
                }),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: TabBar(
                    onTap: (value) {
                      if (tabState.value != value) tabState.value = value;
                    },
                    controller: tabController,
                    labelColor: appColors.primaryBase,
                    unselectedLabelColor: appColors.inkLight,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                    indicatorColor: appColors.primaryBase,
                    labelStyle: textTheme.titleLarge,
                    tabs: const [
                      Tab(
                        text: 'Chi tiết',
                      ),
                      Tab(
                        text: 'Chương',
                      )
                    ],
                  ),
                ),
                Builder(builder: (context) {
                  if (tabState.value == 0) {
                    return detailView(storyQuery.data, context);
                  }
                  return chapterView(storyQuery.data, context);
                }),
              ],
            ),
          )),
      bottomNavigationBar: const DetailStoryBottomBar(),
    );
  }
}
