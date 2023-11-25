import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ChapterDrawer extends HookWidget {
  final Story? story;
  final String currentChapterId;
  const ChapterDrawer(
      {super.key, required this.story, required this.currentChapterId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    if (story == null) {
      return Text('Không thể tải truyện');
    }

    return SafeArea(
        child: Drawer(
            backgroundColor: appColors.background,
            width: size.width * 0.8,
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  const SizedBox(height: 12),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            GoRouter.of(context)
                                .push('/story/${story?.id ?? ''}');
                          },
                          child: AppImage(
                              url: story?.coverUrl, width: 70, height: 94),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(
                                story?.title ?? '',
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                story?.author?.fullName ?? '',
                                style: Theme.of(context).textTheme.titleSmall,
                                softWrap: true,
                                maxLines: 2,
                              ),
                            ])),
                      ]),
                  const Divider(),
                  const SizedBox(height: 24),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(
                      Icons.format_list_bulleted_rounded,
                      size: 24,
                      color: appColors.secondaryBase,
                    ),
                    Text(
                      'Danh sách chương',
                      style: Theme.of(context).textTheme.titleLarge,
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ]),
                  const SizedBox(height: 16),
                  ...(story?.chapters ?? []).map((chapter) {
                    return Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                            color: chapter.id == currentChapterId
                                ? appColors.primaryLight
                                : appColors.skyLightest,
                            borderRadius: BorderRadius.circular(8)),
                        width: double.infinity,
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  GoRouter.of(context).push(
                                      '/story/${story?.id ?? ''}/chapter/${chapter.id}');
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12),
                                  child: Text(chapter.title ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              color:
                                                  chapter.id == currentChapterId
                                                      ? Colors.white
                                                      : appColors.inkBase,
                                              fontSize: 14,
                                              fontFamily:
                                                  GoogleFonts.sourceSansPro()
                                                      .fontFamily,
                                              fontWeight: FontWeight.w400)),
                                ))));
                  }).toList()
                ])));
  }
}
