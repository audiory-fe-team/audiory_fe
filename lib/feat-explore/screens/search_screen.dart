import 'dart:math';

import 'package:audiory_v0/feat-explore/screens/layout/search_top_bar.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/SearchStory.dart';
import 'package:audiory_v0/repositories/category_repository.dart';
import 'package:audiory_v0/repositories/search_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/fake_string_generator.dart';
import 'package:audiory_v0/utils/use_paging_controller.dart';
import 'package:audiory_v0/widgets/cards/profile_card.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:audiory_v0/widgets/paginators/infinite_scroll_paginator.dart';

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
    final isPaywall = useState<String?>(null);
    final isMature = useState<String?>(null);
    final tags = useState<String?>(null);

    final searchController = useTextEditingController();

    final PagingController<int, SearchStory> storiesPagingController =
        usePagingController(
            firstPageKey: 0,
            onPageRequest: (int pageKey,
                PagingController<int, SearchStory> pagingController) async {
              try {
                final newItems = await SearchRepository.searchStory(
                    keyword: searchValue.value,
                    category: category.value,
                    tags: tags.value,
                    sortBy: sortBy.value,
                    isPaywalled: isPaywall.value,
                    isMature: isMature.value,
                    offset: pageKey,
                    limit: _pageSize);
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
            });
    final PagingController<int, Profile> profilesPagingController =
        usePagingController(
            firstPageKey: 0,
            onPageRequest: (int pageKey,
                PagingController<int, Profile> pagingController) async {
              try {
                final newItems = await SearchRepository.searchUser(
                    keyword: searchValue.value,
                    offset: pageKey,
                    limit: _pageSize);
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
            });

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
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: HookBuilder(
                  builder: (context) {
                    final tabState = useState(0);
                    final tabController = useTabController(initialLength: 2);

                    if (!isTyping.value) {
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TabBar(
                            onTap: (value) {
                              if (tabState.value != value) {
                                tabState.value = value;
                              }
                            },
                            controller: tabController,
                            labelColor: appColors?.inkBase,
                            unselectedLabelColor: appColors?.inkLighter,
                            labelPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            indicatorColor: appColors?.primaryBase,
                            indicatorWeight: 2.5,
                            indicatorPadding:
                                const EdgeInsets.symmetric(horizontal: 24),
                            labelStyle: textTheme.headlineSmall,
                            tabs: const [
                              Tab(
                                text: 'Tác phẩm',
                              ),
                              Tab(
                                text: 'Tác giả',
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Builder(builder: (context) {
                          if (tabState.value == 1) {
                            return Expanded(
                                child: RefreshIndicator(
                                    onRefresh: () async {
                                      profilesPagingController.refresh();
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
                              child: AppInfiniteScrollList(
                                  topItems: [
                                    if (tabState.value == 0)
                                      SearchFilterButton(
                                        onTap: () {
                                          showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) {
                                              return SearchStoryFilter(
                                                sortBy: sortBy.value,
                                                category: category.value,
                                                isMature: isMature.value,
                                                isPaywalled: isPaywall.value,
                                                tags: tags.value,
                                                storyList:
                                                    storiesPagingController
                                                        .itemList,
                                                onSubmit: (
                                                    {categoryValue,
                                                    isMatureValue,
                                                    isPaywalledValue,
                                                    sortByValue,
                                                    tagsValue}) {
                                                  sortBy.value = sortByValue;
                                                  tags.value = tagsValue;
                                                  category.value =
                                                      categoryValue;
                                                  isPaywall.value =
                                                      isPaywalledValue;
                                                  isMature.value =
                                                      isMatureValue;

                                                  //Reload:
                                                  storiesPagingController
                                                      .refresh();
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    const SizedBox(height: 12),
                                  ],
                                  itemBuilder: (context, item, index) =>
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 16),
                                          child: StoryCardDetail(
                                              searchStory: item)),
                                  controller: storiesPagingController),
                            ),
                          );
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

                                                FocusScope.of(context)
                                                    .unfocus();
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
                                                FocusScope.of(context)
                                                    .unfocus();
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
  static const SORT_BY_OPTION = [
    {'value': null, 'label': 'Độ phù hợp'},
    {'value': 'read_count', 'label': 'Lượt đọc'},
    {'value': 'vote_count', 'label': 'Lượt bình chọn'},
    {'value': 'updated_date', 'label': 'Ngày cập nhật'}
  ];
  static const List<Map<String, String?>> PAYWALLED_OPTION = [
    {'value': null, 'label': 'Tất cả'},
    {'value': 'false', 'label': 'Truyện miễn phí'},
    {'value': 'true', 'label': 'Truyện trả phí'},
  ];
  static const List<Map<String, String?>> MATURE_OPTION = [
    {'value': null, 'label': 'Tất cả'},
    {'value': 'true', 'label': 'Nội dung an toàn (dưới 18 tuổi)'},
  ];

  final String? category;
  final String? sortBy;
  final String? isPaywalled;
  final String? isMature;
  final String? tags;
  final List<SearchStory>? storyList;
  final Function({
    String? categoryValue,
    String? sortByValue,
    String? isPaywalledValue,
    String? isMatureValue,
    String? tagsValue,
  }) onSubmit;

  const SearchStoryFilter(
      {super.key,
      required this.sortBy,
      required this.category,
      required this.isMature,
      required this.isPaywalled,
      required this.onSubmit,
      required this.tags,
      required this.storyList});

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final categoriesQuery =
        useQuery(['categories'], () => CategoryRepository().fetchCategory());

    final categoryState = useState(category);
    final sortByState = useState(sortBy);
    final isPaywalledState = useState(isPaywalled);
    final isMatureState = useState(isMature);
    final tagsState = useState(tags);

    final sortedTags = useMemoized(() {
      final Map<String, int> tagsOccurMap = {};
      storyList?.forEach((story) {
        story.tags?.split(",").forEach((tag) {
          tagsOccurMap[tag] = (tagsOccurMap[tag] ?? 0) + 1;
        });
      });

      final sortedTags = tagsOccurMap.entries.toList();
      sortedTags.sort((a, b) {
        return b.value - a.value;
      });
      return sortedTags;
    }, []);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: ListView(
        children: [
          const SizedBox(height: 16),
          Text(
            'Sắp xếp theo',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Container(
              decoration: BoxDecoration(
                  color: appColors?.skyLightest,
                  border: Border.all(
                      color: appColors?.skyLighter ?? Colors.transparent),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...SORT_BY_OPTION.map((option) {
                    return Row(children: [
                      Radio(
                        visualDensity:
                            const VisualDensity(horizontal: -2, vertical: -2),
                        activeColor: appColors?.primaryBase,
                        splashRadius: 0,
                        value: option['value'],
                        groupValue: sortByState.value,
                        onChanged: (value) {
                          sortByState.value = value;
                        },
                      ),
                      Text(
                        option['label'] ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: appColors?.inkLight),
                      )
                    ]);
                  }).toList(),
                ],
              )),
          const SizedBox(height: 24),
          Text(
            'Thẻ',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children:
                    sortedTags.sublist(0, min(10, sortedTags.length)).map((e) {
                  final tagName = e.key;
                  final isSelected =
                      tagsState.value?.contains(tagName) ?? false;
                  return GestureDetector(
                      onTap: () {
                        if (isSelected == false) {
                          tagsState.value = '${tagsState.value ?? ''}$tagName,';
                        } else {
                          String? newCategoryString =
                              tagsState.value?.replaceAll('$tagName,', "");
                          newCategoryString =
                              newCategoryString?.replaceAll(tagName, "");
                          tagsState.value = newCategoryString;
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? appColors?.primaryBase
                                : Colors.transparent,
                            border: Border.all(
                                color: appColors?.primaryBase ??
                                    Colors.transparent,
                                width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(e.key,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: isSelected
                                          ? Colors.white
                                          : appColors?.primaryBase))));
                }).toList(),
              )),
          const SizedBox(height: 24),
          Text(
            'Thể loại',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
                color: appColors?.skyLightest,
                border: Border.all(
                    color: appColors?.skyLighter ?? Colors.transparent),
                borderRadius: BorderRadius.circular(8)),
            child: Expanded(
                child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 5,
              ),
              padding: EdgeInsets.zero,
              physics:
                  const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true,
              children: [
                ...(categoriesQuery.data ?? []).map((category) {
                  return Row(mainAxisSize: MainAxisSize.min, children: [
                    Transform.scale(
                        scale: 0.8,
                        child: Checkbox(
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          activeColor: appColors?.primaryBase,
                          splashRadius: 0,
                          value: categoryState.value
                                  ?.contains(category.name ?? '#') ??
                              false,
                          onChanged: (value) {
                            final categoryName = (category.name ?? '');
                            if (value == true) {
                              categoryState.value =
                                  '${categoryState.value ?? ''}$categoryName,';
                            } else {
                              String? newCategoryString = categoryState.value
                                  ?.replaceAll('$categoryName,', "");
                              newCategoryString = newCategoryString?.replaceAll(
                                  categoryName, "");
                              categoryState.value = newCategoryString;
                            }
                          },
                        )),
                    Text(
                      category.name ?? 'option',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: appColors?.inkLight),
                    )
                  ]);
                }).toList(),
              ],
            )),
          ),
          const SizedBox(height: 24),
          Text(
            'Loại truyện',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Container(
              decoration: BoxDecoration(
                  color: appColors?.skyLightest,
                  border: Border.all(
                      color: appColors?.skyLighter ?? Colors.transparent),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...PAYWALLED_OPTION.map((option) {
                    return Row(children: [
                      Radio(
                        visualDensity:
                            const VisualDensity(horizontal: -2, vertical: -2),
                        activeColor: appColors?.primaryBase,
                        splashRadius: 0,
                        value: option['value'],
                        groupValue: isPaywalledState.value,
                        onChanged: (value) {
                          isPaywalledState.value = value;
                        },
                      ),
                      Text(
                        option['label'] ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: appColors?.inkLight),
                      )
                    ]);
                  }).toList(),
                ],
              )),
          const SizedBox(height: 24),
          Text(
            'Nội dung',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Container(
              decoration: BoxDecoration(
                  color: appColors?.skyLightest,
                  border: Border.all(
                      color: appColors?.skyLighter ?? Colors.transparent),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...MATURE_OPTION.map((option) {
                    return Row(children: [
                      Radio(
                        visualDensity:
                            const VisualDensity(horizontal: -2, vertical: -2),
                        activeColor: appColors?.primaryBase,
                        splashRadius: 0,
                        value: option['value'],
                        groupValue: isMatureState.value,
                        onChanged: (value) {
                          isMatureState.value = value;
                        },
                      ),
                      Text(
                        option['label'] ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: appColors?.inkLight),
                      )
                    ]);
                  }).toList(),
                ],
              )),
          const SizedBox(height: 16),
          Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      isMatureState.value = isMature;
                      isPaywalledState.value = isPaywalled;
                      categoryState.value = category;
                      sortByState.value = sortBy;
                      tagsState.value = tags;
                    },
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        side: BorderSide(
                          color: appColors?.primaryBase ?? Colors.transparent,
                          width: 1,
                        )),
                    child: Text(
                      'Đặt lại',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: appColors?.primaryBase),
                    ))),
            const SizedBox(width: 20),
            Expanded(
                child: FilledButton(
                    onPressed: () {
                      onSubmit(
                          sortByValue: sortByState.value,
                          categoryValue: categoryState.value,
                          tagsValue: tagsState.value,
                          isPaywalledValue: isPaywalledState.value,
                          isMatureValue: isMatureState.value);
                      Navigator.pop(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: appColors?.primaryBase,
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                    ),
                    child: Text(
                      'Áp dụng',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ))),
          ]),
          const SizedBox(height: 16),
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
