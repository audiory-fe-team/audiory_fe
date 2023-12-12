import 'package:audiory_v0/models/LibraryStory.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/paragraph/paragraph_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/providers/chapter_database.dart';
import 'package:audiory_v0/providers/story_database.dart';
import 'package:audiory_v0/repositories/library_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;

class CurrentReadCard extends HookWidget {
  final LibraryStory? libStory;
  final Story? story;
  final Function(String) onDeleteStory;
  final Function()? refetch;
  final bool? isEditable;

  CurrentReadCard(
      {super.key,
      this.story,
      required this.onDeleteStory,
      this.libStory,
      this.isEditable = true,
      this.refetch});

  final Dio dio = Dio();
  final storyDb = StoryDatabase();
  final chapterDb = ChapterDatabase();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final downloadProgress = useState<double?>(null);

    final coverUrl = libStory?.story.coverUrl ?? story?.coverUrl;
    final storyId = libStory?.storyId ?? story?.id ?? 'not-found';
    final downloadSnapshot = useFuture(storyDb.getStory(storyId));

    final title = libStory?.story.title ?? story?.title ?? 'Tiêu đề truyện';

    final authorName = libStory?.story.author?.fullName ??
        story?.author?.fullName ??
        'Tiêu đề truyện';
    final isPinned = libStory?.isPinned ?? false;
    final isDownloaded = downloadSnapshot.data != null;

    handleDownloadStory() async {
      final storyInDb = await storyDb.getStory(storyId);

      if (storyInDb != null) {
        try {
          await storyDb.deleteStory(storyId);
          await AppSnackBar.buildTopSnackBar(
              context, 'Xóa thành công.', null, SnackBarType.success);
        } catch (error) {
          AppSnackBar.buildTopSnackBar(
              context, 'Xóa thất bại, thử lại sau.', null, SnackBarType.error);
        }
        if (refetch != null) refetch!();
        return;
      }

      downloadProgress.value = 0;
      try {
        final wholeStory = await LibraryRepository.downloadStory(storyId);
        var directory = await getApplicationDocumentsDirectory();

        // Save to offline database
        final noContentStory = wholeStory.copyWith(
            chapters: wholeStory.chapters
                ?.map((e) => e.copyWith(paragraphs: []))
                .toList());
        await storyDb.saveStory(noContentStory);

        await Future.forEach<Chapter>(wholeStory.chapters ?? [],
            (chapter) async {
          await chapterDb.saveChapters(chapter);
          await Future.forEach<Paragraph>(chapter.paragraphs ?? [],
              (para) async {
            if (para.audios == null || para.audios!.isEmpty) return;
            try {
              para.audios?.forEach((element) async {
                await dio.download(
                    '${dotenv.get("AUDIO_BASE_URL")}${element.url}',
                    "${directory.path}/${element.url}",
                    onReceiveProgress: (rec, total) {});
              });
            } catch (error) {}
          });
          downloadProgress.value =
              ((chapter.position ?? 1) / (wholeStory.chapters?.length ?? 1));
        });

        AppSnackBar.buildTopSnackBar(
            context, 'Tải truyện thành công', null, SnackBarType.success);
        if (refetch != null) refetch!();
      } catch (error) {
        AppSnackBar.buildTopSnackBar(
            context, error.toString(), null, SnackBarType.warning);
      }
      downloadProgress.value = null;
    }

    handlePinStory() async {
      try {
        await LibraryRepository.updateLibraryStory(
            storyId, libStory?.isAvailableOffline ?? false, !(isPinned));

        if (isPinned) {
          AppSnackBar.buildTopSnackBar(
              context, 'Gỡ ghim truyện thành công', null, SnackBarType.success);
        } else {
          AppSnackBar.buildTopSnackBar(
              context, 'Ghim truyện thành công', null, SnackBarType.success);
        }
        if (refetch != null) refetch!();
      } catch (error) {
        AppSnackBar.buildTopSnackBar(context, 'Đã có lỗi xảy ra. Thử lại sau',
            null, SnackBarType.warning);
      }
    }

    return GestureDetector(
        onTap: () {
          GoRouter.of(context)
              .push("/story/$storyId", extra: {'hasDownLoad': true});
        },
        child: Container(
            width: double.infinity,
            height: 128,
            padding: const EdgeInsets.all(4),
            decoration: ShapeDecoration(
              color: isPinned ? appColors.primaryLightest : null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Stack(clipBehavior: Clip.none, children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppImage(
                            url: coverUrl,
                            width: 85,
                            height: 120,
                            fit: BoxFit.fill),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      title,
                                      maxLines: 2,
                                      style: textTheme.titleMedium?.merge(
                                          const TextStyle(
                                              overflow: TextOverflow.ellipsis)),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/icons/write.svg',
                                          width: 14, height: 14),
                                      const SizedBox(width: 4),
                                      SizedBox(
                                          width: 140,
                                          child: Text(authorName,
                                              style: textTheme.titleSmall!
                                                  .copyWith(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      overflow: TextOverflow
                                                          .ellipsis))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (downloadProgress.value != null) ...[
                              const Text('Đang tải xuống'),
                              const SizedBox(height: 2),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: downloadProgress.value!,
                                    color: appColors.primaryBase,
                                    backgroundColor: appColors.skyLightest,
                                  )),
                            ],
                            if (libStory?.readingProgress != null &&
                                libStory?.readingProgress?.chapterId != null)
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'Đã đọc: ${libStory?.readingProgress?.chapterPosition}/${libStory?.readingProgress?.numChapter} chương',
                                        style: textTheme.labelLarge?.copyWith(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: LinearProgressIndicator(
                                        value: (libStory?.readingProgress
                                                    ?.chapterPosition ??
                                                0) /
                                            (libStory?.readingProgress
                                                    ?.numChapter ??
                                                1),
                                        color: appColors.primaryBase,
                                        backgroundColor: appColors.skyLightest,
                                        semanticsLabel:
                                            'Current reading progress',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        )),
                  ),
                  isEditable == true
                      ? Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(children: [
                            PopupMenuButton(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(Icons.more_vert_rounded,
                                        size: 18, color: appColors.skyDark)),
                                onSelected: (value) {
                                  if (value == "pin") {
                                    handlePinStory();
                                  }
                                  if (value == "download") {
                                    handleDownloadStory();
                                  }
                                  if (value == "delete") {
                                    onDeleteStory(storyId);
                                  }
                                },
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                          height: 36,
                                          value: 'pin',
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.push_pin,
                                                    size: 18,
                                                    color:
                                                        appColors.inkLighter),
                                                const SizedBox(width: 4),
                                                Text(
                                                  isPinned
                                                      ? 'Bỏ ghim truyện'
                                                      : 'Ghim truyện',
                                                  style: textTheme.titleMedium
                                                      ?.copyWith(
                                                          color: appColors
                                                              .inkLighter),
                                                )
                                              ])),
                                      PopupMenuItem(
                                          height: 36,
                                          value: 'download',
                                          child: Builder(builder: (context) {
                                            return Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                      isDownloaded
                                                          ? Icons.close_rounded
                                                          : Icons
                                                              .download_rounded,
                                                      size: 18,
                                                      color:
                                                          appColors.inkLighter),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    isDownloaded
                                                        ? 'Xóa tải xuống'
                                                        : 'Tải truyện xuống',
                                                    style: textTheme.titleMedium
                                                        ?.copyWith(
                                                            color: appColors
                                                                .inkLighter),
                                                  )
                                                ]);
                                          })),
                                      PopupMenuItem(
                                          height: 36,
                                          value: 'delete',
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                    Icons
                                                        .delete_outline_rounded,
                                                    size: 18,
                                                    color: appColors
                                                        .secondaryBase),
                                                const SizedBox(width: 4),
                                                Text(
                                                  'Xóa khỏi thư viện',
                                                  style: textTheme.titleMedium
                                                      ?.copyWith(
                                                          color: appColors
                                                              .secondaryBase),
                                                )
                                              ])),
                                    ])
                          ]))
                      : const SizedBox(
                          height: 0,
                        ),
                ],
              ),
              if (isPinned)
                Positioned(
                    top: 4,
                    right: 4,
                    child: Transform.rotate(
                        angle: 45 * math.pi / 180,
                        child: Icon(Icons.push_pin,
                            size: 18, color: appColors.primaryBase))),
              if (isDownloaded)
                Positioned(
                    top: 4,
                    right: 24,
                    child: Icon(Icons.download_done_rounded,
                        size: 18, color: appColors.secondaryBase)),
            ])));
  }
}
