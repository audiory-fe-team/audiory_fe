import 'dart:math';

import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/models/SearchStory.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StoryCardDetail extends StatelessWidget {
  final Story? story;
  final SearchStory? searchStory;

  const StoryCardDetail({super.key, this.story, this.searchStory});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final coverUrl = story?.coverUrl ?? searchStory?.coverUrl ?? '';
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
    final List<String> tags =
        story?.tags?.map((tag) => tag.name ?? '').toList() ??
            searchStory?.tags?.split(",") ??
            [];

    return GestureDetector(
        onTap: () {
          GoRouter.of(context).push("/story/$storyId");
        },
        child: Container(
          width: double.infinity,
          height: 145, //fix here because causing overflow
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Skeleton.shade(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AppImage(
                            url: coverUrl,
                            width: 95,
                            height: 135,
                          ))),
                ],
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
                              maxLines: 2,
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
                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_rounded,
                                      size: 16, color: appColors.primaryLight),
                                  const SizedBox(width: 4),
                                  Text(authorName,
                                      style: textTheme.titleSmall!.copyWith(
                                          fontStyle: FontStyle.italic,
                                          overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                              const SizedBox(width: 6),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.favorite_rounded,
                                      size: 14,
                                      color: appColors.secondaryLighter),
                                  const SizedBox(width: 3),
                                  Text(formatNumber(voteCount).toString(),
                                      style: textTheme.titleSmall?.copyWith(
                                          fontStyle: FontStyle.italic)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.reorder_rounded,
                                      size: 14, color: appColors.primaryBase),
                                  const SizedBox(width: 3),
                                  Text('$chapterNum chương',
                                      style: textTheme.titleSmall!.copyWith(
                                          fontStyle: FontStyle.italic)),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.visibility_rounded,
                                    size: 14,
                                    color: Colors.lightBlue,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(formatNumber(readCount),
                                      style: textTheme.titleSmall!.copyWith(
                                          fontStyle: FontStyle.italic)),
                                ],
                              ),
                            ],
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
                                      padding: const EdgeInsets.only(right: 8),
                                      child: StoryDetailTag(content: tag)))
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
        ));
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
