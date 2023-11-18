import 'package:audiory_v0/constants/limits.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/providers/story_database.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailStoryBottomBar extends StatefulWidget {
  final bool? hasDownload;
  final String storyId;
  final Function addToLibraryCallback;
  final Function downloadStoryCallback;
  final bool isAddedToLibrary;

  const DetailStoryBottomBar(
      {super.key,
      required this.addToLibraryCallback,
      required this.downloadStoryCallback,
      required this.isAddedToLibrary,
      required this.storyId,
      this.hasDownload});

  @override
  _DetailStoryBottomBarState createState() => _DetailStoryBottomBarState();
}

class _DetailStoryBottomBarState extends State<DetailStoryBottomBar> {
  final storyDb = StoryDatabase();

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      elevation: 2,
      color: appColors.skyLightest,
      child: Container(
        height: 65,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // if (widget.isAddedToLibrary) {
                //   AppSnackBar.buildTopSnackBar(
                //     context,
                //     'Đã lưu truyện',
                //     null,
                //     SnackBarType.info,
                //   );
                //   return;
                // }
                widget.addToLibraryCallback();
              },
              child: SizedBox(
                width: 50,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bookmark_rounded,
                      size: 24,
                      color: widget.isAddedToLibrary
                          ? appColors.primaryBase
                          : appColors.skyBase,
                    ),
                    Text(
                      'Lưu trữ',
                      style: textTheme.labelLarge?.copyWith(
                        color: widget.isAddedToLibrary
                            ? appColors.primaryBase
                            : appColors.skyBase,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            widget.hasDownload == true
                ? FutureBuilder(
                    future: storyDb.getStory(widget.storyId),
                    builder: (context, snapshot) {
                      final isDownloaded = snapshot.data != null;
                      return GestureDetector(
                        onTap: () async {
                          final stories = await storyDb.getAllStories();
                          if (isDownloaded == true) {
                            AppSnackBar.buildTopSnackBar(
                              context,
                              'Đã tải truyện',
                              null,
                              SnackBarType.info,
                            );
                            return;
                          }
                          if (stories.length >= LIBRARY_STORY_LIMIT) {
                            AppSnackBar.buildTopSnackBar(
                              context,
                              'Giới hạn tải về là ${LIBRARY_STORY_LIMIT} truyện',
                              null,
                              SnackBarType.info,
                            );
                            return;
                          }
                          widget.downloadStoryCallback();
                        },
                        child: SizedBox(
                          width: 50,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download_rounded,
                                size: 24,
                                color: isDownloaded
                                    ? appColors.primaryBase
                                    : appColors.skyBase,
                              ),
                              Text(
                                'Tải xuống',
                                style: textTheme.labelLarge!.copyWith(
                                  color: isDownloaded
                                      ? appColors.primaryBase
                                      : appColors.skyBase,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox(
                    height: 0,
                  ),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  context.push(
                    '/story/5fb70bf9-3f5b-4557-a4e1-0bf951486b7c/chapter/cfadac60-a197-f34c-2d24-e9e173dbd054',
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(appColors.primaryBase),
                ),
                child: Text(
                  'Đọc',
                  style: textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
