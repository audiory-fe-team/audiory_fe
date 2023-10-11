import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/layout/library_top_bar.dart';
import 'package:audiory_v0/feat-read/widgets/current_read_card.dart';
import 'package:audiory_v0/feat-read/widgets/selectable_current_read_card.dart';
import 'package:audiory_v0/models/LibraryStory.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/reading_list_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/random_library_story_card.dart';
import 'package:audiory_v0/widgets/cards/random_story_card.dart';
import 'package:audiory_v0/widgets/cards/slidale_story_card_detail.dart';
import 'package:audiory_v0/widgets/cards/story_card_detail.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/scrollable_sheet/draggable_scrollable_sheet.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../repositories/library_repository.dart';

class ReadingListScreen extends HookWidget {
  final String id;
  final String? name;
  const ReadingListScreen({super.key, required this.id, this.name});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final listStoriesQuery = useQuery(['readingList', 'stories', id],
        () => ReadingListRepository.fetchReadingListStoriesById(id));

    final readingListQuery = useQuery(
        ['readingList'], () => ReadingListRepository.fetchMyReadingList());

    final libraryQuery =
        useQuery(['library'], () => LibraryRepository.fetchMyLibrary());

    final readingListName =
        readingListQuery.data?.firstWhere((element) => element.id == id).name;

    void handleAdd() {
      final list = [];

      showModalBottomSheet(
          //enable scroll
          enableDrag: true,
          isDismissible: true, //dismiss bottom sheet when click out
          isScrollControlled: true,
          context: context,
          elevation: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          builder: (context) => DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.8,
                builder: (context, scrollController) => Scaffold(
                  body: SingleChildScrollView(
                    child: Container(
                      // height: size.height - 200,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Hủy',
                                    style: textTheme.bodyMedium,
                                  ),
                                )),
                            Flexible(
                                flex: 7,
                                child: GestureDetector(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: Text(
                                    'Chọn truyện để thêm ',
                                    textAlign: TextAlign.center,
                                    style: textTheme.headlineSmall
                                        ?.copyWith(color: appColors.inkDarkest),
                                  ),
                                )),
                            Flexible(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () async {
                                    try {
                                      for (var ele in list) {
                                        await ReadingListRepository
                                            .addStoryToReadingList(id, ele);
                                      }

                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      AppSnackBar.buildTopSnackBar(context,
                                          "Thêm lỗi", null, SnackBarType.error);
                                    }
                                    listStoriesQuery.refetch();
                                    await AppSnackBar.buildTopSnackBar(
                                        context,
                                        "Thêm thành công",
                                        null,
                                        SnackBarType.success);
                                  },
                                  child: Text(
                                    'Chọn',
                                    textAlign: TextAlign.center,
                                    style: textTheme.bodyMedium?.copyWith(
                                        color: appColors.primaryBase),
                                  ),
                                ))
                          ],
                        ),
                        const Divider(),

                        Column(
                          children: List.generate(
                            libraryQuery.data != null
                                ? libraryQuery.data?.libraryStory?.length as int
                                : 0,
                            (index) {
                              final currentStoryId = libraryQuery
                                  .data?.libraryStory?[index].storyId;

                              final isDuplicate = listStoriesQuery.data?.any(
                                      (element) =>
                                          element.id == currentStoryId) ??
                                  false;
                              if (!isDuplicate) {
                                return Skeletonizer(
                                  enabled: libraryQuery.isFetching,
                                  // child: RandomLibraryStoryCard(
                                  //     story: libraryQuery
                                  //             .data?.libraryStory?[index]
                                  //         as LibraryStory,
                                  //     onStorySelected: () async {
                                  //       String storyId = libraryQuery
                                  //           .data
                                  //           ?.libraryStory?[index]
                                  //           .storyId as String;

                                  //       if (list.contains(storyId)) {
                                  //       } else {
                                  //         list.add(storyId);
                                  //       }
                                  //     }),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: SelectableCurrentReadCard(
                                      story: libraryQuery
                                              .data?.libraryStory?[index]
                                          as LibraryStory,
                                      isEditable: false,
                                      onSelected: (storyId) {
                                        if (list.contains(storyId)) {
                                          list.remove(storyId);
                                        } else {
                                          list.add(storyId);
                                        }

                                        print('LIST length ${list.length}');
                                        print(list);
                                      },
                                    ),
                                  ),
                                );
                              }

                              return Container();
                            },
                          ).toList(),
                        ),
                        // ListView(
                        //     children: (libraryQuery.data?.libraryStory ?? [])
                        //         .map((e) => Container(
                        //             margin: const EdgeInsets.only(bottom: 16),
                        //             child: RandomLibraryStoryCard(
                        //               story: e,
                        //               onStorySelected: () {},
                        //             )))
                        //         .toList()),
                      ]),
                    ),
                  ),
                ),
              ));
    }

    handleDeleteStoryFromReadingList(String storyId) async {
      try {
        await ReadingListRepository.deleteStoryFromReadingList(id, storyId);
      } catch (error) {
        AppSnackBar.buildTopSnackBar(
            context, 'Xóa thất bại, thử lại sau.', null, SnackBarType.error);
      }
      listStoriesQuery.refetch();
      await AppSnackBar.buildTopSnackBar(
          context, 'Xóa thành công.', null, SnackBarType.success);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: Text(
            name ?? 'Danh sách đọc',
            style: textTheme.headlineMedium,
          ),
          actions: [
            PopupMenuButton(
                position: PopupMenuPosition.under,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: Icon(Icons.more_horiz, color: appColors.inkDarker)),
                onSelected: (value) {
                  if (value == "add") {
                    handleAdd();
                  }
                  if (value == "share") {}
                  if (value == "delete") {
                    // handleDelete();
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                          height: 36,
                          value: 'add',
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.add,
                                size: 18, color: appColors.inkLighter),
                            const SizedBox(width: 4),
                            Text(
                              'Thêm truyện',
                              style: textTheme.titleMedium,
                            )
                          ])),
                      PopupMenuItem(
                          height: 36,
                          value: 'share',
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.share,
                                size: 18, color: appColors.inkLighter),
                            const SizedBox(width: 4),
                            Text(
                              'Chia sẻ',
                              style: textTheme.titleMedium,
                            )
                          ])),
                      // PopupMenuItem(
                      //     height: 36,
                      //     value: 'delete',
                      //     child: Row(mainAxisSize: MainAxisSize.min, children: [
                      //       Icon(Icons.delete_outline_rounded,
                      //           size: 18, color: appColors.secondaryBase),
                      //       const SizedBox(width: 4),
                      //       Text(
                      //         'Xóa danh sách',
                      //         style: textTheme.titleMedium
                      //             ?.copyWith(color: appColors.secondaryBase),
                      //       )
                      //     ])),
                    ]),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            readingListQuery.refetch();
          },
          child: Material(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Builder(builder: (context) {
                  if (listStoriesQuery.isError) {
                    return Center(
                        child: Text('Đã có lỗi xảy ra. Vui lòng thử lại sau',
                            style: textTheme.titleLarge));
                  }
                  if (listStoriesQuery.isFetching == false &&
                      (listStoriesQuery.data ?? []).isEmpty) {
                    return Center(
                        child: Text('Danh sách trống',
                            style: textTheme.titleLarge));
                  }

                  return Skeletonizer(
                      enabled: listStoriesQuery.isFetching,
                      child: RefreshIndicator(
                          onRefresh: () async {
                            listStoriesQuery.refetch();
                            readingListQuery.refetch();
                          },
                          child: ListView(children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(readingListName ?? '',
                                      style: textTheme.titleLarge),
                                  const SizedBox(height: 4),
                                  Text(
                                      '${listStoriesQuery.data?.length ?? 0} truyện',
                                      style: textTheme.titleSmall),
                                ],
                              ),
                            ),
                            ...(listStoriesQuery.isFetching
                                    ? skeletonStories
                                    : (listStoriesQuery.data ?? []))
                                .map((e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: SlidableStoryCardDetail(
                                      story: e,
                                      onDeleteStory: (storyId) {
                                        handleDeleteStoryFromReadingList(
                                            storyId);
                                      },
                                    )))
                                .toList(),
                            const SizedBox(height: 24),
                          ])));
                }),
              )),
        ));
  }
}
