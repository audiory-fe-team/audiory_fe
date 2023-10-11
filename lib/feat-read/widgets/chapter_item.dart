import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChapterItem extends StatelessWidget {
  final String? storyId;
  final Chapter? chapter;

  final int? price;
  final bool? isPaid;
  final String title;
  final int? position;
  final String time;
  final Function(Chapter, int) onSelected; //chapterId, price,
  const ChapterItem(
      {super.key,
      required this.title,
      required this.time,
      this.chapter,
      this.position = 0,
      this.price = 0,
      this.storyId,
      required this.onSelected,
      this.isPaid});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    String formatDate(String? date) {
      DateTime currentDateTime = DateTime.now();
      //use package intl
      DateTime dateTime = DateTime.parse(date as String);
      int timeDiffInDays = currentDateTime.difference(dateTime).inDays;
      if (timeDiffInDays < 1) {
        return '${currentDateTime.difference(dateTime)} giờ trước';
      } else {
        return DateFormat('dd.MM.yyyy').format(dateTime);
      }
    }

    String formatReadCount(int readCount) {
      var formatter = NumberFormat('#,##,000');

      return formatter.format(readCount);
    }

    return GestureDetector(
      onTap: () {
        price != 0
            ? onSelected(chapter as Chapter, price ?? 0)
            : GoRouter.of(context)
                .push('/story/$storyId/chapter/${chapter?.id}');
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
            SizedBox(
              width: (size.width - 32) / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chương  $position:',
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 6,
              child: price != 0
                  ? chapter?.isPaid == true
                      ? Text(
                          formatDate(time),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: appColors.inkLighter),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 3,
                              child: GestureDetector(
                                child: Image.asset(
                                  'assets/images/coin.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                '$price xu',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: appColors.inkLighter),
                              ),
                            ),
                          ],
                        )
                  : Text(
                      formatDate(time),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontStyle: FontStyle.italic,
                          color: appColors.inkLighter),
                    ),
            ),
            Flexible(
              flex: 3,
              child: price != 0 && chapter?.isPaid != true
                  ? Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.lock,
                        color: appColors.inkLight,
                        size: 16,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                            flex: 2,
                            child: Icon(
                              Icons.remove_red_eye,
                              size: 12,
                              color: appColors.inkLighter,
                            )),
                        Flexible(
                          flex: 6,
                          child: Text(
                            formatReadCount(chapter?.readCount as int),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: appColors.inkLighter),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
