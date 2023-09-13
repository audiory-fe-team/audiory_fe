import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-explore/screens/layout/result_top_bar.dart';
import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/repositories/profile.repository.dart';
import 'package:audiory_v0/repositories/story.repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ResultScreen extends HookConsumerWidget {
  final String keyword;
  final bool searchForProfile; //NOTE: Search for stories or
  const ResultScreen({
    super.key,
    required this.keyword,
    this.searchForProfile = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final tabController = useTabController(
        initialLength: 2, initialIndex: searchForProfile ? 1 : 0);

    final storiesQuery = useQuery(['story', 'search', keyword],
        () => StoryRepostitory().fetchStories(keyword: keyword),
        enabled: searchForProfile == false);

    final profileQuery = useQuery(['profile', 'search', keyword],
        () => ProfileRepository().fetchAllProfiles(keyword: keyword),
        enabled: searchForProfile == true);

    final tabState = useState(0);

    return Scaffold(
      appBar: ResultTopBar(keyword: keyword),
      body: SafeArea(
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabBar(
                    controller: tabController,
                    onTap: (value) {
                      GoRouter.of(context)
                          .pushNamed("explore_result", queryParameters: {
                        "keyword": keyword,
                        "searchForProfile": (value == 1),
                      });
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
                  const SizedBox(height: 24),
                  Builder(builder: (_) {
                    if (tabState.value == 0) {
                      if (storiesQuery.isError) {
                        return Center(
                            child: Text(storiesQuery.error.toString()));
                      }
                      return Skeletonizer(
                          enabled: storiesQuery.isFetching,
                          child: Expanded(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: (storiesQuery.isFetching
                                            ? skeletonStories
                                            : (storiesQuery.data ?? []))
                                        .map((story) => GestureDetector(
                                            onTap: () {
                                              GoRouter.of(context)
                                                  .push("/story/${story.id}");
                                            },
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 24),
                                                child: StoryCardDetail(
                                                    story: story))))
                                        .toList(),
                                  ))));
                    } else {
                      if (profileQuery.isError) {
                        return Center(
                            child: Text(profileQuery.error.toString()));
                      }
                      return Skeletonizer(
                          enabled: profileQuery.isFetching,
                          child: Expanded(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: (profileQuery.isFetching
                                            ? skeletonProfiles
                                            : (profileQuery.data ??
                                                skeletonProfiles))
                                        .map((profile) =>
                                            Text(profile.fullName ?? ''))
                                        .toList(),
                                  ))));
                    }
                  }),
                ],
              ))),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
