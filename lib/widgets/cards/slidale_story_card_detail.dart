import 'dart:math';

import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/models/SearchStory.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableStoryCardDetail extends StatelessWidget {
  final Story? story;
  final SearchStory? searchStory;
  final dynamic Function(String) onDeleteStory;

  const SlidableStoryCardDetail(
      {super.key, this.story, this.searchStory, required this.onDeleteStory});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final coverUrl =
        story?.coverUrl ?? searchStory?.coverUrl ?? FALLBACK_IMG_URL;
    final storyId = story?.id ?? searchStory?.id ?? 'not-found';
    final title = story?.title ?? searchStory?.title ?? 'Tiêu đề truyện';
    final description =
        story?.description ?? searchStory?.description ?? 'Mô tả truyện';
    final authorName =
        story?.author?.fullName ?? searchStory?.fullName ?? 'Tác giả';
    final voteCount = story?.voteCount ?? searchStory?.voteCount ?? 0;
    final readCount = story?.readCount ?? searchStory?.readCount ?? 0;
    final chapterNum =
        story?.publishedCount ?? searchStory?.publishedCount ?? 0;
    final List<String?> tags = story?.tags?.map((tag) => tag.name).toList() ??
        searchStory?.tags?.split(",") ??
        [];

    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {
          onDeleteStory(storyId);
        }),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              onDeleteStory(storyId);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xóa',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GestureDetector(
            onTap: () {
              GoRouter.of(context)
                  .push("/story/$storyId", extra: {'hasDownload': true});
            },
            child: Container(
              width: double.infinity,
              height: 145, //fix here because causing overflow
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
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
                        Container(
                          width: 95,
                          height: 135,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(coverUrl),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, //fixed here because overflow on android
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.titleMedium?.merge(
                                      const TextStyle(
                                          overflow: TextOverflow.ellipsis)),
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  description,
                                  maxLines: 2,
                                  style: textTheme.labelLarge?.copyWith(
                                      color: appColors.inkLight,
                                      fontStyle: FontStyle.italic,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/write.svg',
                                            width: 14,
                                            height: 14),
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
                                    const SizedBox(width: 6),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/heart.svg',
                                                width: 14,
                                                height: 14),
                                            const SizedBox(width: 3),
                                            Text(
                                                formatNumber(voteCount)
                                                    .toString(),
                                                style: textTheme.titleSmall
                                                    ?.copyWith(
                                                        fontStyle:
                                                            FontStyle.italic)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/chapter.svg',
                                            width: 14,
                                            height: 14),
                                        const SizedBox(width: 4),
                                        Text('$chapterNum chương',
                                            style: textTheme.titleSmall!
                                                .copyWith(
                                                    fontStyle:
                                                        FontStyle.italic)),
                                      ],
                                    ),
                                    const SizedBox(width: 6),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset('assets/icons/eye.svg',
                                            width: 14, height: 14),
                                        const SizedBox(width: 8),
                                        Text('${formatNumber(readCount)}',
                                            style: textTheme.titleSmall!
                                                .copyWith(
                                                    fontStyle:
                                                        FontStyle.italic)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                decoration: const BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: tags
                                      .sublist(0, min(3, tags.length))
                                      .map((tag) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: StoryDetailTag(
                                              content: tag as String)))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class StoryDetailTag extends StatelessWidget {
  final String content;
  const StoryDetailTag({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: ShapeDecoration(
        color: appColors.skyLightest,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(content,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: appColors.skyDark, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
