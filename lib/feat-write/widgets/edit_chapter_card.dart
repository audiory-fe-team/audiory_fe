import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../theme/theme_constants.dart';

class EditChapterCard extends StatelessWidget {
  final int? index;
  final Chapter? chapter;
  const EditChapterCard({super.key, required this.chapter, this.index});

  Map<String, dynamic> getChapterStatus(context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    Map<String, dynamic> map = {
      'status': 'Đã lưu bản thảo',
      'color': Colors.deepOrange,
    };
    if (chapter?.isDraft as bool) {
      map.update('status', (value) => 'Đã lưu bản thảo');
      map.update('color', (value) => Colors.deepOrange[400]);
    } else if (chapter?.isPaywalled as bool) {
      map.update('status', (value) => 'Tính phí');
      map.update('color', (value) => Colors.orangeAccent);
    } else if (chapter?.isEnabled as bool) {
      map.update('status', (value) => 'Đã đăng tải');
      map.update('color', (value) => Colors.orangeAccent);
    }
    return map;
  }

  String formatDate(String? date) {
    //use package intl
    DateTime dateTime = DateTime.parse(date as String);

    //Date
    DateTime now = DateTime.now();

    bool diff = now.difference(dateTime).inDays == 1;
    if (diff) {
      return '${now.difference(dateTime).inHours} giờ trước';
    }
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> chapterStatus = getChapterStatus(context);
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return GestureDetector(
      onTap: () {
        context.pushNamed('composeChapter',
            extra: {'chapterId': chapter?.id, 'story': ''});
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  chapter!.title == ''
                      ? 'Chương $index : Tiêu đề'
                      : 'Chương $index : ${chapter?.title}',
                  style: const TextStyle(
                    color: Color(0xFF72777A),
                    fontSize: 16,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formatDate(chapter?.updatedDate),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: appColors.inkLight),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  chapterStatus['status'],
                  style: TextStyle(
                    color: chapterStatus['color'],
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'id: ${chapter?.id}',
                  style: const TextStyle(
                    color: Color(0xFF72777A),
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w400,
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
