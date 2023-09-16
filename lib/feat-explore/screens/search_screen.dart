import 'dart:math';

import 'package:audiory_v0/feat-explore/screens/layout/search_top_bar.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/SearchStory.dart';
import 'package:audiory_v0/repositories/search_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/fake_string_generator.dart';
import 'package:audiory_v0/utils/use_paging_controller.dart';
import 'package:audiory_v0/widgets/cards/profile_card.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fquery/fquery.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});
  static const _pageSize = 10;

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final textTheme = Theme.of(context).textTheme;

    final isTyping = useState(true);
    final searchValue = useState('');
    final sortBy = useState<String?>(null);
    final category = useState<String?>(null);
    final isPaywall = useState<bool?>(null);
    final isMature = useState<bool>(false);

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
    }, [
      searchValue.value,
      sortBy.value,
    ]);

    final fetchProfile = useCallback(
        (int pageKey, PagingController<int, Profile> pagingController) async {
      try {
        final newItems = await SearchRepository.searchUser(
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

    final PagingController<int, SearchStory> storiesPagingController =
        usePagingController(firstPageKey: 0, onPageRequest: fetchStory);
    final PagingController<int, Profile> profilesPagingController =
        usePagingController(firstPageKey: 0, onPageRequest: fetchProfile);

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
            storiesPagingController.refresh();
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
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SearchStoryFilter(
                                  category: category.value,
                                  sortBy: sortBy.value,
                                  isMature: isMature.value,
                                  isPaywalled: isPaywall.value,
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        Builder(builder: (context) {
                          if (tabState.value == 1) {
                            return Expanded(
                                child: RefreshIndicator(
                                    onRefresh: () async {
                                      storiesPagingController.refresh();
                                    },
                                    child: PagedListView<int, Profile>(
                                        pagingController:
                                            profilesPagingController,
                                        builderDelegate:
                                            PagedChildBuilderDelegate<Profile>(
                                                itemBuilder:
                                                    (context, item, index) =>
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 8),
                                                            child: ProfileCard(
                                                              user: item,
                                                            ))))));
                          }
                          return Expanded(
                              child: RefreshIndicator(
                            onRefresh: () async {
                              storiesPagingController.refresh();
                            },
                            child: PagedListView<int, SearchStory>(
                                pagingController: storiesPagingController,
                                builderDelegate:
                                    PagedChildBuilderDelegate<SearchStory>(
                                        itemBuilder: (context, item,
                                                index) =>
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 16),
                                                child: StoryCardDetail(
                                                    searchStory: item)))),
                          ));
                        }),
                      ]);
                    }

                    return HookBuilder(builder: (_) {
                      final storyQuery = useQuery(
                        ['search', 'stories', searchValue.value],
                        () => SearchRepository.searchStory(
                            keyword: searchValue.value),
                        enabled: isTyping.value && searchValue.value.length > 2,
                      );
                      final profileQuery = useQuery(
                          ['search', 'users', searchValue.value],
                          () => SearchRepository.searchUser(
                              keyword: searchValue.value),
                          enabled:
                              isTyping.value && searchValue.value.length > 2);
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Builder(builder: (_) {
                                if (storyQuery.isError) {
                                  return Text(
                                      'Đã có lỗi xảy ra. Không thể tải gợi ý',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge);
                                }

                                if (storyQuery.isFetching) {
                                  return Skeletonizer(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      generateFakeString(15),
                                      generateFakeString(10),
                                      generateFakeString(20),
                                      generateFakeString(10),
                                      generateFakeString(18),
                                    ]
                                        .map((e) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: (storyQuery.data ?? [])
                                        .sublist(
                                            0,
                                            min(5,
                                                storyQuery.data?.length ?? 0))
                                        .map((item) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                searchController.text =
                                                    item.title;
                                                searchValue.value = item.title;
                                                storiesPagingController
                                                    .refresh();

                                                isTyping.value = false;
                                                tabController.animateTo(0);
                                                tabState.value = 0;
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        appColors?.skyLightest,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Builder(builder: (_) {
                                if (profileQuery.isError) {
                                  return Text(
                                      'Đã có lỗi xảy ra. Không thể tải gợi ý',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge);
                                }

                                if (profileQuery.isFetching) {
                                  return Skeletonizer(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      generateFakeString(15),
                                      generateFakeString(10),
                                      generateFakeString(20),
                                      generateFakeString(10),
                                      generateFakeString(18),
                                    ]
                                        .map((e) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: (profileQuery.data ?? [])
                                        .sublist(
                                            0,
                                            min(5,
                                                profileQuery.data?.length ?? 0))
                                        .map((item) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                searchController.text =
                                                    item.fullName ?? 'Vô danh';
                                                searchValue.value =
                                                    item.fullName ?? 'Vô danh';
                                                profilesPagingController
                                                    .refresh();
                                                isTyping.value = false;
                                                tabController.animateTo(1);
                                                tabState.value = 1;
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        appColors?.skyLightest,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: Text(
                                                      item.fullName ??
                                                          'Vô danh',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    )),
                                              ),
                                            )))
                                        .toList());
                              })),
                      ]);
                    });
                  },
                ),
              ))),
    );
  }
}

class SearchStoryFilter extends HookWidget {
  final String? category;
  final String? sortBy;
  final bool? isPaywalled;
  final bool isMature;

  const SearchStoryFilter(
      {super.key,
      required this.sortBy,
      required this.category,
      required this.isMature,
      required this.isPaywalled});

  @override
  Widget build(BuildContext context) {
    final categoryState = useState(category);
    final sortByState = useState(sortBy);
    final isPaywalledState = useState(isPaywalled);
    final isMatureState = useState(isMature);
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: ListView(
        children: [
          Text(
            'Cài đặt',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          //Note: Backgronud color
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
                  child: Text(
                    'Màu trang',
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
              const SizedBox(height: 12),
              //Note:Background colors option
              // Row(
              //   children: [
              //     ...DEFAULT_OPTION.asMap().entries.map((entry) {
              //       int idx = entry.key;
              //       Color val = entry.value;
              //       return GestureDetector(
              //           onTap: () {
              //             selectedOption.value = idx;
              //           },
              //           child: Padding(
              //               padding: const EdgeInsets.only(right: 8),
              //               child: Container(
              //                   height: 30,
              //                   width: 30,
              //                   decoration: BoxDecoration(
              //                     color: val,
              //                     shape: BoxShape.circle,
              //                     border: selectedOption.value == idx
              //                         ? Border.all(
              //                             color: appColors.primaryBase,
              //                             width: 2,
              //                             strokeAlign:
              //                                 BorderSide.strokeAlignOutside)
              //                         : null,
              //                   ))));
              //     }).toList(),
              //     GestureDetector(
              //         onTap: () {},
              //         child: Stack(
              //           children: [
              //             Container(
              //                 height: 30,
              //                 width: 30,
              //                 decoration: BoxDecoration(
              //                   color: appColors.primaryBase,
              //                   shape: BoxShape.circle,
              //                 ),
              //                 child: Center(
              //                     child: SvgPicture.asset(
              //                   'assets/icons/plus.svg',
              //                   color: Colors.white,
              //                   width: 16,
              //                   height: 16,
              //                 ))),
              //           ],
              //         )),
              //   ],
              // ),
            ],
          ),
        ],
      ),
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
