import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/models/LibraryStory.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CurrentReadCard extends StatelessWidget {
  final LibraryStory? libStory;
  final Story? story;
  final Function(String) onDeleteStory;
  final bool? isEditable;
  const CurrentReadCard(
      {super.key,
      this.story,
      required this.onDeleteStory,
      this.libStory,
      this.isEditable = true});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final coverUrl =
        libStory?.story.coverUrl ?? story?.coverUrl ?? FALLBACK_IMG_URL;
    final storyId = libStory?.storyId ?? story?.id ?? 'not-fount';

    final title = libStory?.story.title ?? story?.title ?? 'Tiêu đề truyện';

    final authorName = libStory?.story.author?.fullName ??
        story?.author?.fullName ??
        'Tiêu đề truyện';

    return GestureDetector(
        onTap: () {
          GoRouter.of(context).push("/story/$storyId");
        },
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                      width: 85,
                      height: 120,
                      decoration: BoxDecoration(
                        color: appColors.primaryLightest,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/write.svg',
                                      width: 14, height: 14),
                                  const SizedBox(width: 4),
                                  SizedBox(
                                      width: 140,
                                      child: Text(authorName,
                                          style: textTheme.titleSmall!.copyWith(
                                              fontStyle: FontStyle.italic,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (libStory != null)
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
                                    'Đã đọc: 34/56 chương',
                                    style: textTheme.labelLarge
                                        ?.copyWith(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: 0.6,
                                    color: appColors.primaryBase,
                                    backgroundColor: appColors.skyLightest,
                                    semanticsLabel: 'Current reading progress',
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    )),
              ),
              Column(mainAxisSize: MainAxisSize.max, children: [
                isEditable == true
                    ? Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: PopupMenuButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Icon(Icons.more_vert_rounded,
                                    size: 18, color: appColors.skyDark)),
                            onSelected: (value) {
                              if (value == "notification") {}
                              if (value == "delete") {
                                onDeleteStory(storyId);
                              }
                            },
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                      height: 36,
                                      value: 'notification',
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                                Icons
                                                    .notifications_active_rounded,
                                                size: 18,
                                                color: appColors.inkLighter),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Bật thông báo',
                                              style: textTheme.titleMedium,
                                            )
                                          ])),
                                  PopupMenuItem(
                                      height: 36,
                                      value: 'delete',
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.delete_outline_rounded,
                                                size: 18,
                                                color: appColors.secondaryBase),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Xóa truyện',
                                              style: textTheme.titleMedium
                                                  ?.copyWith(
                                                      color: appColors
                                                          .secondaryBase),
                                            )
                                          ])),
                                ]))
                    : const SizedBox(
                        height: 0,
                      ),
              ]),
            ],
          ),
        ));
  }
}
