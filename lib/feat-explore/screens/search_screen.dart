import 'dart:math';

import 'package:audiory_v0/feat-explore/screens/layout/search_top_bar.dart';
import 'package:audiory_v0/models/SearchStory.dart';
import 'package:audiory_v0/repositories/search_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/fake_string_generator.dart';
import 'package:audiory_v0/utils/use_paging_controller.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fquery/fquery.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});
  static const _pageSize = 5;

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final textTheme = Theme.of(context).textTheme;

    final searchValue = useState('');
    final isTyping = useState(true);
    // final currentPage = useState(1);

    final storyQuery = useQuery(
      ['search', 'stories', searchValue.value],
      () => SearchRepository.searchStory(keyword: searchValue.value),
      enabled: isTyping.value || searchValue.value.length > 2,
    );
    final profileQuery = useQuery(['search', 'users', searchValue.value],
        () => SearchRepository.searchUser(keyword: searchValue.value),
        enabled: isTyping.value || searchValue.value.length > 2);

    // final page = usePageController(initialPage: 1);
    final searchController = useTextEditingController();
    final fetchStory = useCallback((int pageKey,
        PagingController<int, SearchStory> pagingController) async {
      try {
        final newItems = await SearchRepository.searchStory(
            keyword: searchValue.value, offset: pageKey, limit: _pageSize);
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + newItems.length;
          pagingController.appendPage(newItems, nextPageKey);
        }
      } catch (error) {
        pagingController.error = error;
      }
    }, [searchValue.value]);

    final PagingController<int, SearchStory> pagingController =
        usePagingController(firstPageKey: 0, onPageRequest: fetchStory);

    // useEffect(() {
    //   if (currentPage.value == 1) {
    //     storiesList.value = (storyQuery.data ?? []);
    //   } else {
    //     storiesList.value += storyQuery.data ?? [];
    //   }
    // }, [storyQuery.data]);

    return Scaffold(
      appBar: SearchTopBar(
          controller: searchController,
          isTyping: isTyping.value,
          onSearchValueChange: (value) {
            // print(value);
            searchValue.value = value;
          },
          onSubmit: () {
            isTyping.value = false;
            pagingController.refresh();
          },
          onTap: () {
            isTyping.value = true;
          }),
      body: SafeArea(
          child: Material(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: HookBuilder(
                  builder: (context) {
                    final tabState = useState(0);
                    final tabController = useTabController(initialLength: 2);

                    if (!isTyping.value) {
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        TabBar(
                          controller: tabController,
                          onTap: (value) {
                            tabState.value = value;
                          },
                          labelColor: appColors?.primaryBase,
                          unselectedLabelColor: appColors?.inkLight,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          indicatorColor: appColors?.primaryBase,
                          labelStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          tabs: const [
                            Tab(
                              text: 'Tác phẩm',
                            ),
                            Tab(
                              text: 'Tác giả',
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        SearchFilterButton(
                          onTap: () {},
                        ),
                        const SizedBox(height: 12),
                        Builder(builder: (context) {
                          if (tabState.value == 1) {
                            return Expanded(
                                child: RefreshIndicator(
                                    onRefresh: () async {
                                      profileQuery.refetch();
                                    },
                                    child: Skeletonizer(
                                        enabled: false,
                                        // enabled: storyQuery.isFetching,
                                        child: ListView(children: [
                                          const SizedBox(height: 12),
                                          ...(profileQuery.data ?? [])
                                              .map((profile) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 16),
                                                  child:
                                                      Text(profile.username)))
                                              .toList()
                                        ]))));
                          }
                          return Expanded(
                              child: RefreshIndicator(
                                  onRefresh: () async {
                                    storyQuery.refetch();
                                  },
                                  child: Skeletonizer(
                                    enabled: storyQuery.isFetching,
                                    child: PagedListView<int, SearchStory>(
                                        pagingController: pagingController,
                                        builderDelegate:
                                            PagedChildBuilderDelegate<
                                                    SearchStory>(
                                                itemBuilder: (context, item,
                                                        index) =>
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 16),
                                                        child: StoryCardDetail(
                                                            searchStory:
                                                                item)))),

                                    // child: ListView(children: [
                                    //   const SizedBox(height: 24),
                                    //   Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.end,
                                    //       children: [
                                    //         Skeleton.keep(
                                    //             child: GestureDetector(
                                    //           onTap: () {
                                    //             //NOTE: Show bottom model
                                    //           },
                                    //           child: Container(
                                    //               padding: const EdgeInsets
                                    //                       .symmetric(
                                    //                   horizontal: 15,
                                    //                   vertical: 5),
                                    //               decoration: BoxDecoration(
                                    //                   color: appColors
                                    //                       ?.skyLightest,
                                    //                   borderRadius:
                                    //                       BorderRadius
                                    //                           .circular(28)),
                                    //               child: Row(
                                    //                   mainAxisSize:
                                    //                       MainAxisSize.min,
                                    //                   children: [
                                    //                     Text('Bộ lọc',
                                    //                         style: textTheme
                                    //                             .titleMedium
                                    //                             ?.copyWith(
                                    //                                 color: appColors
                                    //                                     ?.inkLight)),
                                    //                     const SizedBox(
                                    //                         width: 6),
                                    //                     SvgPicture.asset(
                                    //                       'assets/icons/sliders.svg',
                                    //                       width: 14,
                                    //                       height: 14,
                                    //                       color: appColors
                                    //                           ?.inkLight,
                                    //                     )
                                    //                   ])),
                                    //         ))
                                    //       ]),
                                    //   const SizedBox(height: 12),
                                    //   ...storiesList.value
                                    //       .map((story) => Padding(
                                    //           padding: const EdgeInsets.only(
                                    //               bottom: 16),
                                    //           child: StoryCardDetail(
                                    //               searchStory: story)))
                                    //       .toList()
                                    // ])
                                  )));
                        }),
                      ]);
                    }

                    return ListView(children: [
                      const SizedBox(height: 12),
                      if (searchValue.value.length < 2)
                        Text('Nhập ít nhất 3 ký tự để tìm kiếm',
                            style: textTheme.labelLarge),
                      if (searchValue.value.length > 2)
                        Text('Truyện',
                            style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 12),
                      if (searchValue.value.length > 2)
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Builder(builder: (_) {
                              if (storyQuery.isError) {
                                return Text(
                                    'Đã có lỗi xảy ra. Không thể tải gợi ý',
                                    style:
                                        Theme.of(context).textTheme.titleLarge);
                              }

                              if (storyQuery.isFetching) {
                                return Skeletonizer(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    generateFakeString(15),
                                    generateFakeString(10),
                                    generateFakeString(20),
                                    generateFakeString(10),
                                    generateFakeString(18),
                                  ]
                                      .map((e) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            e,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          )))
                                      .toList(),
                                ));
                              }

                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: (storyQuery.data ?? [])
                                      .sublist(0,
                                          min(5, storyQuery.data?.length ?? 0))
                                      .map((item) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: GestureDetector(
                                            onTap: () {
                                              searchController.text =
                                                  item.title;
                                              searchValue.value = item.title;
                                              pagingController.refresh();

                                              isTyping.value = false;
                                              tabController.animateTo(0);
                                              tabState.value = 0;
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: appColors?.skyLightest,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: Text(
                                                    item.title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  )),
                                            ),
                                          )))
                                      .toList());
                            })),
                      const SizedBox(height: 24),
                      if (searchValue.value.length > 2)
                        Text('Người dùng',
                            style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 12),
                      if (searchValue.value.length > 2)
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Builder(builder: (_) {
                              if (profileQuery.isError) {
                                return Text(
                                    'Đã có lỗi xảy ra. Không thể tải gợi ý',
                                    style:
                                        Theme.of(context).textTheme.titleLarge);
                              }

                              if (profileQuery.isFetching) {
                                return Skeletonizer(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    generateFakeString(15),
                                    generateFakeString(10),
                                    generateFakeString(20),
                                    generateFakeString(10),
                                    generateFakeString(18),
                                  ]
                                      .map((e) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            e,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          )))
                                      .toList(),
                                ));
                              }

                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: (profileQuery.data ?? [])
                                      .sublist(
                                          0,
                                          min(5,
                                              profileQuery.data?.length ?? 0))
                                      .map((item) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: GestureDetector(
                                            onTap: () {
                                              searchController.text =
                                                  item.fullName ?? 'Vô danh';
                                              searchValue.value =
                                                  item.fullName ?? 'Vô danh';
                                              pagingController.refresh();
                                              isTyping.value = false;
                                              tabController.animateTo(1);
                                              tabState.value = 1;
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: appColors?.skyLightest,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: Text(
                                                    item.fullName ?? 'Vô danh',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  )),
                                            ),
                                          )))
                                      .toList());
                            })),
                    ]);
                  },
                ),
              ))),
    );
  }
}

class SearchFilterButton extends StatelessWidget {
  final Function onTap;
  const SearchFilterButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final textTheme = Theme.of(context).textTheme;
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Skeleton.keep(
          child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                color: appColors?.skyLightest,
                borderRadius: BorderRadius.circular(28)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text('Bộ lọc',
                  style: textTheme.titleMedium
                      ?.copyWith(color: appColors?.inkLight)),
              const SizedBox(width: 6),
              SvgPicture.asset(
                'assets/icons/sliders.svg',
                width: 14,
                height: 14,
                color: appColors?.inkLight,
              )
            ])),
      ))
    ]);
  }
}
