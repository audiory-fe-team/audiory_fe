import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/widgets/current_read_card.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/providers/chapter_database.dart';
import 'package:audiory_v0/providers/story_database.dart';
import 'package:audiory_v0/repositories/library_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DownloadedStories extends StatefulWidget {
  const DownloadedStories({Key? key}) : super(key: key);

  @override
  _DownloadedStoriesState createState() => _DownloadedStoriesState();
}

class _DownloadedStoriesState extends State<DownloadedStories> {
  late Future<List<Story>?> libraryData;
  final storyDb = StoryDatabase();
  final chapterDb = ChapterDatabase();
  int? syncProgress;

  @override
  void initState() {
    super.initState();
    libraryData = storyDb.getAllStories();
  }

  Future<void> handleDeleteStory(String id) async {
    try {
      await LibraryRepository.deleteStoryFromMyLibrary(id);
      await storyDb.deleteStory(id);
      setState(() {
        libraryData = storyDb.getAllStories();
      });
      await AppSnackBar.buildTopSnackBar(
          context, 'Xóa thành công.', null, SnackBarType.success);
    } catch (error) {
      AppSnackBar.buildTopSnackBar(
          context, 'Xóa thất bại, thử lại sau.', null, SnackBarType.error);
    }
  }

  Future<void> handleSyncStories() async {
    setState(() {
      syncProgress = 0;
    });
    final stories = await libraryData;
    try {
      await Future.wait((stories ?? []).map((story) async {
        final wholeStory = await LibraryRepository.downloadStory(story.id);

        // Save to offline database
        final noContentStory = wholeStory.copyWith(
            chapters: wholeStory.chapters
                ?.map((e) => e.copyWith(paragraphs: []))
                .toList());
        await storyDb.saveStory(noContentStory);

        await Future.forEach(wholeStory.chapters ?? [], (element) async {
          await chapterDb.saveChapters(element);
        });
        setState(() {
          syncProgress = (syncProgress ?? 0) + 1;
        });
      }).toList());

      await AppSnackBar.buildTopSnackBar(
          context, 'Cập nhật thành công.', null, SnackBarType.success);
    } catch (error) {
      // ignore: use_build_context_synchronously
      AppSnackBar.buildTopSnackBar(
          context,
          'Cập nhật thất bại $syncProgress/${stories?.length}, thử lại sau.',
          null,
          SnackBarType.error);
    }
    setState(() {
      syncProgress = null;
    });

    setState(() {
      libraryData = storyDb.getAllStories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: FutureBuilder<List<Story>?>(
        future: libraryData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Skeletonizer(
              enabled: true, // Enable skeleton loading
              child: ListView(
                  children: skeletonStories.map((e) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: CurrentReadCard(
                    story: e,
                    onDeleteStory: (id) => handleDeleteStory(id),
                  ),
                );
              }).toList()),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Bạn chưa tải truyện nào.'));
          } else {
            final libraryStoryList = snapshot.data!;
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  libraryData = storyDb.getAllStories();
                });
              },
              child: ListView(children: [
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Skeleton.shade(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                  color: appColors?.skyLightest,
                                  borderRadius: BorderRadius.circular(28)),
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () {
                                        if (syncProgress == null) {
                                          handleSyncStories();
                                        }
                                      },
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Cập nhật',
                                                style: textTheme.titleMedium
                                                    ?.copyWith(
                                                        color: appColors
                                                            ?.inkLight)),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            syncProgress == null
                                                ? Icon(Icons.sync_rounded,
                                                    size: 14,
                                                    color: appColors?.inkBase)
                                                : Center(
                                                    child: SizedBox(
                                                        width: 14,
                                                        height: 14,
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: appColors
                                                                    ?.primaryBase,
                                                                strokeWidth:
                                                                    2))),
                                          ])))))
                    ]),
                if (syncProgress != null) ...[
                  const SizedBox(height: 12),
                  Text(
                      'Đang cập nhập ${syncProgress}/${libraryStoryList.length}'),
                  const SizedBox(height: 6),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: syncProgress! / libraryStoryList.length,
                        color: appColors?.primaryBase,
                        backgroundColor: appColors?.skyLightest,
                      )),
                ],
                const SizedBox(height: 12),
                ...libraryStoryList.map((e) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: CurrentReadCard(
                      story: e,
                      onDeleteStory: (id) => handleDeleteStory(id),
                    ),
                  );
                }).toList()
              ]),
            );
          }
        },
      ),
    );
  }
}
