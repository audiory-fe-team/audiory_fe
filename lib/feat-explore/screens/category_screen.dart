import 'package:audiory_v0/feat-explore/screens/layout/category_top_bar.dart';
import 'package:audiory_v0/feat-explore/screens/search_screen.dart';
import 'package:audiory_v0/models/SearchStory.dart';
import 'package:audiory_v0/repositories/search_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/use_paging_controller.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryScreen extends HookWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});
  static const _pageSize = 10;

  @override
  Widget build(BuildContext context) {
    final sortBy = useState<String?>(null);
    // final category = useState<String?>(null);
    // final isPaywall = useState<String?>(null);
    final isMature = useState<String?>(null);

    final PagingController<int, SearchStory> storiesPagingController =
        usePagingController(
            firstPageKey: 0,
            onPageRequest: (int pageKey,
                PagingController<int, SearchStory> pagingController) async {
              try {
                final newItems = await SearchRepository.searchCategoryStories(
                    category: categoryName,
                    sortBy: sortBy.value,
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

    return Scaffold(
      appBar: CategoryTopBar(
        categoryName: categoryName,
      ),
      body: SafeArea(
          child: Material(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HookBuilder(builder: (context) {
                    return Expanded(
                        child: RefreshIndicator(
                      onRefresh: () async {
                        storiesPagingController.refresh();
                      },
                      child: CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(child: SizedBox(height: 12)),
                          SliverToBoxAdapter(child: SearchFilterButton(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return CategorySearchFilter(
                                    sortBy: sortBy.value,
                                    isMature: isMature.value,
                                    onSubmit: (
                                        {categoryValue,
                                        isMatureValue,
                                        isPaywalledValue,
                                        sortByValue,
                                        tagsValue}) {
                                      sortBy.value = sortByValue;
                                      isPaywalledValue;
                                      isMature.value = isMatureValue;

                                      //Reload:
                                      storiesPagingController.refresh();
                                    },
                                  );
                                },
                              );
                            },
                          )),
                          const SliverToBoxAdapter(child: SizedBox(height: 12)),
                          PagedSliverList<int, SearchStory>(
                              pagingController: storiesPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<SearchStory>(
                                      itemBuilder: (context, item, index) =>
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: StoryCardDetail(
                                                  searchStory: item))))
                        ],
                      ),
                    ));
                  })))),
    );
  }
}

class CategorySearchFilter extends HookWidget {
  static const SORT_BY_OPTION = [
    {'value': null, 'label': 'Độ phù hợp'},
    {'value': 'read_count', 'label': 'Lượt đọc'},
    {'value': 'vote_count', 'label': 'Lượt bình chọn'},
    {'value': 'updated_date', 'label': 'Ngày cập nhật'}
  ];
  // static const List<Map<String, String?>> PAYWALLED_OPTION = [
  //   {'value': null, 'label': 'Tất cả'},
  //   {'value': 'false', 'label': 'Truyện miễn phí'},
  //   {'value': 'true', 'label': 'Truyện trả phí'},
  // ];
  static const List<Map<String, String?>> MATURE_OPTION = [
    {'value': null, 'label': 'Tất cả'},
    {'value': 'true', 'label': 'Nội dung an toàn (dưới 18 tuổi)'},
  ];

  final String? sortBy;
  final String? isMature;
  final Function({
    String? sortByValue,
    String? isMatureValue,
  }) onSubmit;

  const CategorySearchFilter({
    super.key,
    required this.sortBy,
    required this.isMature,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();

    final sortByState = useState(sortBy);
    final isMatureState = useState(isMature);

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
                      sortByState.value = sortBy;
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
