import 'package:audiory_v0/feat-write/widgets/chapter_actions_menu.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../theme/theme_constants.dart';

class EditChapterCard extends StatelessWidget {
  final int? index;
  final Chapter? chapter;
  final Story? story;
  final Function() onDeleteChapter;

  const EditChapterCard(
      {super.key,
      required this.chapter,
      this.index,
      this.story,
      required this.onDeleteChapter});

  Map<String, dynamic> getChapterStatus(context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    Map<String, dynamic> map = {
      'status': 'Đã lưu bản thảo',
      'color': Colors.deepOrange,
    };
    if (chapter?.isDraft == true) {
      map.update('status', (value) => 'Bản thảo');
      map.update('color', (value) => Colors.deepOrange[400]);
    } else if (chapter?.isPaywalled == true) {
      map.update('status', (value) => 'Chương trả phí');
      map.update('color', (value) => appColors.secondaryBase);
    } else if (chapter?.isDraft == false) {
      map.update('status', (value) => 'Đã đăng tải');
      map.update('color', (value) => appColors.primaryBase);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> chapterStatus = getChapterStatus(context);
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final popupMenuItem = chapter?.isPaywalled == true
        ? ['edit', 'preview']
        : ['edit', 'preview', 'delete'];

    return GestureDetector(
      onTap: () {
        context.pushNamed('composeChapter', extra: {
          'chapterId': chapter?.id,
          'story': story,
          'chapter': chapter
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFF4F4F4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Text(
                    chapter!.title == ''
                        ? '$index. Tiêu đề'
                        : '$index. ${chapter?.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF72777A),
                      fontSize: 16,
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Wrap(
                    children: [
                      PopupMenuButton(
                          onSelected: (value) {
                            print(value);
                            if (value == 1) {
                              onDeleteChapter();
                            }
                            if (value == 0) {
                              context.pushNamed('composeChapter', extra: {
                                'chapterId': chapter?.id,
                                'story': story,
                                'chapter': chapter
                              });
                            }
                          },
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => chapter?.isPaywalled == true
                              ? appPaywalledChapterPopupMenuItems(context)
                              : appChapterPopupMenuItems(context)),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${chapterStatus['status']}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: chapterStatus['color']),
                ),
                Text(
                  'Cập nhật ${appFormatDate(chapter?.updatedDate)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: appColors.inkLight,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Source Sans Pro',
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
