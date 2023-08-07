import 'dart:ffi';

import 'package:audiory_v0/api/story_provider.dart';
import 'package:audiory_v0/feat-explore/models/filter.dart';
import 'package:audiory_v0/feat-explore/screens/layout/result_top_bar.dart';
import 'package:audiory_v0/feat-explore/screens/layout/search_top_bar.dart';
import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResultScreen extends HookConsumerWidget {
  final String keyword;
  final bool searchForAuthor; //NOTE: Search for stories or
  const ResultScreen({
    super.key,
    required this.keyword,
    this.searchForAuthor = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final tabController = useTabController(initialLength: 2, initialIndex: 0);
    final stories = ref.watch(storiesProvider(keyword));
    final tabState = useState(1);

    return Scaffold(
      appBar: ResultTopBar(keyword: keyword),
      body: SafeArea(
          child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabBar(
                    controller: tabController,
                    onTap: (value) {
                      if (tabState.value == value) return;
                      tabState.value = value;
                      // print("haha");
                      // GoRouter.of(context)
                      //     .goNamed("explore_result", queryParameters: {
                      //   "keyword": keyword,
                      //   "searchForAuthor": (value == 1),
                      // });
                    },
                    labelColor: appColors.primaryBase,
                    unselectedLabelColor: appColors.inkLight,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                    indicatorColor: appColors.primaryBase,
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
                  Builder(builder: (_) {
                    if (tabState.value == 0) {
                      return stories.when(
                          data: (stories) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: stories
                                    .map((story) =>
                                        StoryCardDetail(story: story))
                                    .toList(),
                              ),
                          error: (error, stack) {
                            print(error);
                            return const Center(
                                child: Text(
                                    'Oops, something unexpected happened'));
                          },
                          loading: () => Center(
                                  child: CircularProgressIndicator(
                                color: appColors.primaryBase,
                              )));
                    } else {
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 50,
                          color: Colors.amber,
                          margin: EdgeInsets.only(bottom: 12),
                        ),
                        Container(
                          height: 50,
                          color: Colors.amber,
                          margin: EdgeInsets.only(bottom: 12),
                        ),
                        Container(
                          height: 50,
                          color: Colors.amber,
                          margin: EdgeInsets.only(bottom: 12),
                        ),
                        Container(
                          height: 50,
                          color: Colors.amber,
                          margin: EdgeInsets.only(bottom: 12),
                        ),
                      ]); //2nd tabView
                    }
                  }),
                ],
              ))),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
