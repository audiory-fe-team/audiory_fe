import 'package:audiory_v0/constants/gifts.dart';
import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/models/Gift.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/feat-read/widgets/chapter_item.dart';
import 'package:audiory_v0/services/profile_services.dart';
import 'package:audiory_v0/services/story_services.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/fake_string_generator.dart';
import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:audiory_v0/widgets/buttons/tap_effect_wrapper.dart';
import 'package:audiory_v0/widgets/cards/donate_item_card.dart';
import 'package:audiory_v0/widgets/story_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    final paginatorController = NumberPaginatorController();
    final storyQuery =
        useQuery(['story', id], () => StoryService().fetchStoryById(id));

    final authorQuery = useQuery(['profile', storyQuery.data?.author_id],
        () => ProfileService().fetchProfileById(storyQuery.data?.author_id),
        enabled: storyQuery.isSuccess);

    final tabState = useState(0);
    final selectedItem = useState<Gift>(GIFT_LIST[0]);

    Widget donateGiftModal() {
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
                  children: GIFT_LIST
                      .map((option) => TapEffectWrapper(
                          onTap: () {
                            selectedItem.value = option;
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: DonateItemCard(
                                gift: option,
                                selected: (selectedItem.value == option),
                              ))))
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
                Skeleton.keep(
                  child: Row(children: [
                    Image.asset(
                      'assets/images/chapter_colored.png',
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Chương',
                      style: sharedHeaderStyle,
                    )
                  ]),
                ),
                const SizedBox(height: 4),
                Text((story?.chapters?.length ?? '1000').toString(),
                    style: sharedNumberStyle)
              ],
            ),
            const VerticalDivider(),
            Column(
              children: [
                Skeleton.keep(
                  child: Row(children: [
                    Image.asset(
                      'assets/images/view_colored.png',
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Lượt đọc',
                      style: sharedHeaderStyle,
                    )
                  ]),
                ),
                const SizedBox(height: 4),
                Text((story?.read_count ?? '').toString(),
                    style: sharedNumberStyle)
              ],
            ),
            const VerticalDivider(),
            Column(
              children: [
                Skeleton.keep(
                  child: Row(children: [
                    Image.asset(
                      'assets/images/comment_colored.png',
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Bình luận',
                      style: sharedHeaderStyle,
                    )
                  ]),
                ),
                const SizedBox(height: 4),
                Text((story?.vote_count ?? '').toString(),
                    style: sharedNumberStyle)
              ],
            ),
            const VerticalDivider(),
            Column(
              children: [
                Skeleton.keep(
                  child: Row(children: [
                    Image.asset(
                      'assets/images/vote_colored.png',
                      width: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Bình chọn',
                      style: sharedHeaderStyle,
                    )
                  ]),
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
          Skeleton.replace(
              width: 110,
              height: 165,
              child: Container(
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
              )),
          const SizedBox(height: 24),
          Text(
            story?.title ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      );
    }

    Widget chapterView(
      Story? story,
    ) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cập nhật đến chương',
                style: textTheme.headlineSmall,
              ),
              IntrinsicHeight(
                child: Row(children: [
                  Text('Mới nhất', style: textTheme.labelLarge),
                  const VerticalDivider(),
                  Text('Cũ nhất', style: textTheme.labelLarge)
                ]),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            children: (story?.chapters ?? []).asMap().entries.map((entry) {
              Chapter chapter = entry.value;
              int index = entry.key;
              return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ChapterItem(
                    title: 'Chương ${index + 1}: ${chapter.title}',
                    time: '20',
                  ));
            }).toList(),
          ),
          NumberPaginator(
            config: NumberPaginatorUIConfig(
              buttonSelectedBackgroundColor: appColors.primaryBase,
              buttonUnselectedForegroundColor: appColors.primaryBase,
            ),
            controller: paginatorController,
            numberPages: 100,
            onPageChange: (index) {
              print(index);
            },
          )
        ],
      );
    }

    Widget detailView(Story? story) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontFamily: GoogleFonts.sourceSansPro().fontFamily),
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
              SizedBox(
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
            onTap: () {
              GoRouter.of(context).pop();
            },
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RefreshIndicator(
                onRefresh: () async {
                  storyQuery.refetch();
                  authorQuery.refetch();
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      Skeletonizer(
                          enabled: storyQuery.isFetching,
                          child: storyInfo(storyQuery.isFetching
                              ? skeletonStory
                              : storyQuery.data)),

                      const SizedBox(height: 12),
                      //NOTE: Profile image
                      Skeletonizer(
                          enabled: authorQuery.isFetching,
                          child: Material(
                              child: InkWell(
                                  onTap: () async {
                                    // context.go('/profile');
                                  },
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Skeleton.replace(
                                            width: 32,
                                            height: 32,
                                            child: Container(
                                              width: 32,
                                              height: 32,
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      authorQuery.data
                                                              ?.avatarUrl ??
                                                          ''),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: const CircleBorder(),
                                              ),
                                            )),
                                        const SizedBox(width: 8),
                                        Text(
                                          authorQuery.isFetching
                                              ? generateFakeString(16)
                                              : authorQuery.data?.fullName ??
                                                  '',
                                          style: textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400),
                                        )
                                      ])))),

                      const SizedBox(height: 24),
                      Skeletonizer(
                          enabled: storyQuery.isFetching,
                          child: interactionInfo(storyQuery.isFetching
                              ? skeletonStory
                              : storyQuery.data)),
                      const SizedBox(height: 24),
                      Skeletonizer(
                          enabled: storyQuery.isFetching,
                          child: SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 6,
                                runSpacing: 6,
                                children: ((storyQuery.isFetching
                                            ? skeletonStory.tags
                                            : storyQuery.data?.tags) ??
                                        [])
                                    .map((tag) => StoryTag(
                                          label: tag.name,
                                          selected: false,
                                        ))
                                    .toList(),
                              ))),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: TabBar(
                          onTap: (value) {
                            if (tabState.value != value) tabState.value = value;
                          },
                          controller: tabController,
                          labelColor: appColors.primaryBase,
                          unselectedLabelColor: appColors.inkLight,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
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
                      const SizedBox(height: 12),
                      Builder(builder: (context) {
                        if (tabState.value == 0) {
                          return Skeletonizer(
                              enabled: storyQuery.isFetching,
                              child: detailView(storyQuery.isFetching
                                  ? skeletonStory
                                  : storyQuery.data));
                        }
                        return Skeletonizer(
                            enabled: storyQuery.isFetching,
                            child: chapterView(storyQuery.isFetching
                                ? skeletonStory
                                : storyQuery.data));
                      }),
                    ],
                  ),
                ))),
        bottomNavigationBar: Material(
            elevation: 10,
            child: Container(
              height: 74,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TapEffectWrapper(
                      onTap: () {},
                      child: SizedBox(
                          width: 50,
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite,
                                  size: 24,
                                  color: appColors.primaryBase,
                                ),
                                Text('Yêu thích',
                                    style: textTheme.labelLarge!.copyWith(
                                      color: appColors.primaryBase,
                                    ))
                              ]))),
                  TapEffectWrapper(
                      onTap: () {},
                      child: SizedBox(
                          width: 50,
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bookmark,
                                  size: 24,
                                  color: appColors.primaryBase,
                                ),
                                Text('Lưu trữ',
                                    style: textTheme.labelLarge!.copyWith(
                                      color: appColors.primaryBase,
                                    ))
                              ]))),
                  Expanded(
                      child: FilledButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed("chapter_detail", pathParameters: {
                              "storyId": storyQuery.data?.id ?? '',
                              "chapterId":
                                  // storyQuery.data?.chapters?[0].id ?? ''
                                  '41ccaddf-3b96-11ee-8842-e0d4e8a18075'
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  appColors.primaryBase)),
                          child: Text(
                            'Đọc',
                            style: textTheme.titleMedium!
                                .copyWith(color: Colors.white),
                          )))
                ],
              ),
            )));
  }
}
