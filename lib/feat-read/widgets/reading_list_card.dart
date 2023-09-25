import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/models/ReadingList.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReadingListCard extends StatelessWidget {
  final ReadingList readingList;
  const ReadingListCard({super.key, required this.readingList});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final coverUrl = FALLBACK_IMG_URL;
    final readingListId = readingList.id ?? 'not-found';
    final title = readingList.name ?? 'Tiêu đề truyện';

    final isPrivate = readingList.isPrivate ?? false;

    return GestureDetector(
        onTap: () {
          GoRouter.of(context).go("/library/reading-list/$readingListId");
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
                                  Icon(
                                      isPrivate
                                          ? Icons.lock_rounded
                                          : Icons.public_rounded,
                                      size: 14,
                                      color: appColors.inkBase),
                                  const SizedBox(width: 2),
                                  SizedBox(
                                      width: 140,
                                      child: Text(
                                          isPrivate ? 'Riêng tư' : 'Công khai',
                                          style: textTheme.titleSmall?.copyWith(
                                              fontStyle: FontStyle.italic,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
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
                          if (value == "delete") {}
                        },
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  height: 36,
                                  value: 'notification',
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.notifications_active_rounded,
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
                                                  color:
                                                      appColors.secondaryBase),
                                        )
                                      ])),
                            ])),
              ]),
            ],
          ),
        ));
  }
}
