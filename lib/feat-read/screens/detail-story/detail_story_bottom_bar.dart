import 'package:audiory_v0/feat-read/screens/detail-story/add_to_list_modal.dart';
import 'package:audiory_v0/providers/story_database.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailStoryBottomBar extends StatefulWidget {
  final bool? hasDownload;
  final String storyId;
  final Function addToLibraryCallback;
  final bool isAddedToLibrary;
  final Function onRead;
  final bool isContinueReading;
  final int? continueChapter;

  const DetailStoryBottomBar({
    super.key,
    required this.addToLibraryCallback,
    // required this.downloadStoryCallback,
    required this.isAddedToLibrary,
    required this.storyId,
    required this.onRead,
    this.continueChapter,
    this.isContinueReading = false,
  });

  @override
  _DetailStoryBottomBarState createState() => _DetailStoryBottomBarState();
}

class _DetailStoryBottomBarState extends State<DetailStoryBottomBar> {
  final storyDb = StoryDatabase();

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    void handleAdd() {
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
          builder: (context) => AddToListModal(
                storyId: widget.storyId,
              ));
    }

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
                      'Thư viện',
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
            GestureDetector(
              onTap: () {
                handleAdd();
              },
              child: SizedBox(
                width: 50,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_rounded,
                      size: 24,
                      color: appColors.skyBase,
                    ),
                    Text(
                      'Thêm vào',
                      style: textTheme.labelLarge?.copyWith(
                        color: appColors.skyBase,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  widget.onRead();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(appColors.primaryBase),
                ),
                child: Text(
                  '${widget.isContinueReading ? 'Đọc tiếp' : 'Đọc'}${widget.continueChapter != null ? ' (chương ${widget.continueChapter})' : ''}',
                  style: textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
