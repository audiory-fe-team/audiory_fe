import 'package:audiory_v0/feat-explore/screens/category_screen.dart';
import 'package:audiory_v0/feat-explore/screens/layout/tag_top_bar.dart';
import 'package:audiory_v0/feat-explore/screens/search_screen.dart';
import 'package:audiory_v0/models/SearchStory.dart';
import 'package:audiory_v0/repositories/search_repository.dart';
import 'package:audiory_v0/utils/use_paging_controller.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:audiory_v0/widgets/paginators/infinite_scroll_paginator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchTagScreen extends HookWidget {
  final String tagId;
  final String tagName;
  const SearchTagScreen(
      {super.key, required this.tagId, required this.tagName});
  static const _pageSize = 100;

  @override
  Widget build(BuildContext context) {
    final sortBy = useState<String?>(null);
    final isMature = useState<String?>(null);
    final PagingController<int, SearchStory> storiesPagingController =
        usePagingController(
            firstPageKey: 0,
            onPageRequest: (int pageKey,
                PagingController<int, SearchStory> pagingController) async {
              try {
                final newItems = await SearchRepository.searchTagStories(
                    tagId: tagId,
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
      appBar: TagTopBar(
        tagName: tagName,
      ),
      body: SafeArea(
          child: Material(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HookBuilder(builder: (context) {
                    return Expanded(
                        child: RefreshIndicator(
                      onRefresh: () async {
                        storiesPagingController.refresh();
                      },
                      child: AppInfiniteScrollList(
                          topItems: [
                            const SizedBox(height: 12),
                            SearchFilterButton(
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
                            ),
                            const SizedBox(height: 12),
                          ],
                          itemBuilder: (context, item, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: StoryCardDetail(searchStory: item)),
                          controller: storiesPagingController),
                    ));
                  })))),
    );
  }
}
