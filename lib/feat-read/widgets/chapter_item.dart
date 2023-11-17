import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/format_number.dart';
import 'package:audiory_v0/utils/relative_time.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChapterItem extends StatelessWidget {
  final Chapter chapter;

  final bool? isPaid;
  final int? position;
  final Function(Chapter, int) onSelected; //chapterId, price,
  const ChapterItem(
      {super.key,
      required this.chapter,
      this.position = 0,
      required this.onSelected,
      this.isPaid});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;

    String formatDate(String? date) {
      DateTime currentDateTime = DateTime.now();
      //use package intl
      DateTime dateTime = DateTime.parse(date ?? currentDateTime.toString());
      int timeDiffInDays = currentDateTime.difference(dateTime).inDays;
      if (timeDiffInDays < 1) {
        return '${currentDateTime.difference(dateTime)} giờ trước';
      } else {
        return DateFormat('dd.MM.yyyy').format(dateTime);
      }
    }

    String formatReadCount(int readCount) {
      if (readCount <= 100) return '${readCount}';
      var formatter = NumberFormat('#,##,000');
      return formatter.format(readCount);
    }

    return GestureDetector(
      onTap: () {
        print(chapter.price);
        print(chapter.isPaid);
        chapter.price != 0
            ? chapter.isPaid == true
                ? GoRouter.of(context)
                    .push('/story/${chapter.storyId}/chapter/${chapter.id}')
                : onSelected(chapter, chapter.price ?? 0)
            : GoRouter.of(context)
                .push('/story/${chapter.storyId}/chapter/${chapter.id}');
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: appColors.skyLightest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chương  $position:',
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chapter.title ?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (chapter.price != 0)
              Column(children: [
                if (chapter.isPaid != true)
                  Icon(
                    Icons.lock,
                    color: appColors.primaryBase,
                    size: 16,
                  ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/coin.png',
                        width: 16,
                        height: 16,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${chapter.price} xu',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: appColors.inkBase, fontSize: 12),
                    ),
                  ],
                )
              ]),
            const SizedBox(width: 8),
            Column(children: [
              Text(
                formatRelativeTime(chapter.updatedDate),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: appColors.inkLight, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    size: 12,
                    color: appColors.secondaryBase,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    formatNumber(chapter.readCount ?? 0),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: appColors.inkLight),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
