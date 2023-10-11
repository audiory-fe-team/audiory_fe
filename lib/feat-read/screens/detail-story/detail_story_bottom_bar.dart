import 'package:audiory_v0/models/enum/SnackbarType.dart';
import 'package:audiory_v0/providers/story_database.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/tap_effect_wrapper.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailStoryBottomBar extends StatefulWidget {
  final String storyId;
  final Function addToLibraryCallback;
  final Function downloadStoryCallback;
  final bool isAddedToLibrary;

  const DetailStoryBottomBar({
    super.key,
    required this.addToLibraryCallback,
    required this.downloadStoryCallback,
    required this.isAddedToLibrary,
    required this.storyId,
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

    return Material(
      elevation: 10,
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
            TapEffectWrapper(
              onTap: () {
                if (widget.isAddedToLibrary) {
                  AppSnackBar.buildTopSnackBar(
                    context,
                    'Đã lưu truyện',
                    null,
                    SnackBarType.info,
                  );
                  return;
                }
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
                      style: textTheme.labelLarge!.copyWith(
                        color: widget.isAddedToLibrary
                            ? appColors.primaryBase
                            : appColors.skyBase,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: storyDb.getStory(widget.storyId),
              builder: (context, snapshot) {
                final isDownloaded = snapshot.data != null;
                return TapEffectWrapper(
                  onTap: () {
                    if (isDownloaded == true) {
                      AppSnackBar.buildTopSnackBar(
                        context,
                        'Đã tải truyện',
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
            ),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  context.push(
                    '/story/${widget.storyId}/chapter/41ccaddf-3b96-11ee-8842-e0d4e8a18075',
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
