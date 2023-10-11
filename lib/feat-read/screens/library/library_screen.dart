import 'package:audiory_v0/feat-read/screens/library/current_reads.dart';
import 'package:audiory_v0/feat-read/screens/library/downloaded_stories.dart';
import 'package:audiory_v0/feat-read/screens/library/library_top_bar.dart';
import 'package:audiory_v0/feat-read/screens/library/reading_lists.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LibraryScreen extends HookWidget {
  const LibraryScreen({super.key});
  static const tabs = ['Đang đọc', 'Danh sách đọc', 'Tải xuống'];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final tabState = useState(0);

    return Scaffold(
        appBar: const LibraryTopBar(),
        body: Material(
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
                    Expanded(
                        child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 0),
                      child: Builder(
                        builder: (context) {
                          if (tabState.value == 1) return const ReadingLists();
                          if (tabState.value == 2) {
                            return const DownloadedStories();
                          }
                          return const CurrentReadings();
                        },
                      ),
                    )),
                  ],
                ))));
  }
}
