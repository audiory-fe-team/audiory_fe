import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/layout/library_top_bar.dart';
import 'package:audiory_v0/feat-read/widgets/current_read_card.dart';
import 'package:audiory_v0/feat-read/widgets/reading_list_card.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LibraryScreen extends HookWidget {
  const LibraryScreen({super.key});
  static const tabs = ['Đang đọc', 'Danh sách đọc', 'Tải xuống'];

  @override
  Widget build(BuildContext context) {
    User? authUser = AuthRepository().currentUser;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final tabState = useState(0);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const LibraryTopBar(),
        body: Material(
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: tabs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final tabName = entry.value;
                        return InkWell(
                            onTap: () {
                              tabState.value = index;
                            },
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: index == tabState.value
                                                ? appColors.primaryBase
                                                : Colors.transparent,
                                            width: 2))),
                                child: Text(
                                  tabName,
                                  style: textTheme.headlineSmall,
                                )));
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: const CurrentReadings(),
                    )
                    // Builder(builder: (context) {
                    //   final currentWidget = tabState.value == 0
                    //       ? const CurrentReadings()
                    //       : (tabState.value == 1
                    //           ? const ReadingLists()
                    //           : const SizedBox());
                    //   return ;
                    // })
                  ],
                ))));
  }
}

class ReadingLists extends HookWidget {
  const ReadingLists({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Skeletonizer(
            enabled: false,
            child: RefreshIndicator(
                onRefresh: () async {
                  // chapterQuery.refetch();
                },
                child: ListView(
                    children: skeletonStories
                        .map((e) => Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ReadingListCard(story: skeletonStory)))
                        .toList()))));
  }
}

class CurrentReadings extends HookWidget {
  const CurrentReadings({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Skeletonizer(
            enabled: false,
            child: RefreshIndicator(
                onRefresh: () async {
                  // chapterQuery.refetch();
                },
                child: ListView(
                    children: skeletonStories
                        .map((e) => Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: CurrentReadCard(story: skeletonStory)))
                        .toList()))));
  }
}
