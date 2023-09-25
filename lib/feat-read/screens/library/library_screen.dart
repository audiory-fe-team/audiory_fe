import 'package:audiory_v0/feat-read/layout/library_top_bar.dart';
import 'package:audiory_v0/feat-read/widgets/current_read_card.dart';
import 'package:audiory_v0/feat-read/widgets/reading_list_card.dart';
import 'package:audiory_v0/models/enum/SnackbarType.dart';
import 'package:audiory_v0/repositories/library_repository.dart';
import 'package:audiory_v0/repositories/reading_list_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
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
                    Expanded(
                        child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 0),
                      child: tabState.value == 0
                          ? const CurrentReadings(
                              key: ValueKey<String>("current_reading"))
                          : const ReadingLists(
                              key: ValueKey<String>("reading_list")),
                    )),

                    // AnimatedSwitcher(
                    //   duration: const Duration(milliseconds: 500),
                    //   transitionBuilder:
                    //       (Widget child, Animation<double> animation) {
                    //     return ScaleTransition(scale: animation, child: child);
                    //   },
                    //   child: const CurrentReadings(),
                    // )
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
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final textTheme = Theme.of(context).textTheme;
    final readingListQuery = useQuery(
        ['readingList'], () => ReadingListRepository.fetchMyReadingList());

    return Expanded(
        child: Skeletonizer(
            enabled: readingListQuery.isFetching,
            child: RefreshIndicator(
                onRefresh: () async {
                  readingListQuery.refetch();
                },
                child: ListView(children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                                color: appColors?.skyLightest,
                                borderRadius: BorderRadius.circular(28)),
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                      Text('Tạo danh sách đọc',
                                          style: textTheme.titleMedium
                                              ?.copyWith(
                                                  color: appColors?.inkLight)),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Icon(Icons.add_rounded,
                                          size: 14, color: appColors?.inkBase),
                                    ]))))
                      ]),
                  const SizedBox(height: 16),
                  ...(readingListQuery.data ?? [])
                      .map((e) => Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ReadingListCard(readingList: e)))
                      .toList(),
                ]))));
  }
}

class CurrentReadings extends HookWidget {
  const CurrentReadings({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryQuery =
        useQuery(['library'], () => LibraryRepository.fetchMyLibrary());

    handleDeleteStory(String id) async {
      try {
        await LibraryRepository.deleteStoryFromMyLibrary(id);
      } catch (error) {
        AppSnackBar.buildTopSnackBar(
            context, 'Xóa thất bại, thử lại sau.', null, SnackBarType.error);
      }
      libraryQuery.refetch();
      await AppSnackBar.buildTopSnackBar(
          context, 'Xóa thành công.', null, SnackBarType.success);
    }

    return Expanded(
        child: Skeletonizer(
            enabled: libraryQuery.isFetching,
            child: RefreshIndicator(
                onRefresh: () async {
                  libraryQuery.refetch();
                },
                child: ListView(
                    children: (libraryQuery.data?.libraryStory ?? [])
                        .map((e) => Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: CurrentReadCard(
                              story: e,
                              onDeleteStory: (id) => handleDeleteStory(id),
                            )))
                        .toList()))));
  }
}
