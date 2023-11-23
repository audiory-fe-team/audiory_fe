import 'package:audiory_v0/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../theme/theme_constants.dart';

class ReadingCardOverview extends StatelessWidget {
  final String id;
  final String? coverUrl;
  final String title;

  const ReadingCardOverview(
      {super.key, this.title = '', this.coverUrl = '', required this.id});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push("/story/$id");
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 32,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                flex: 2,
                child: Skeleton.shade(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AppImage(url: coverUrl, width: 95, height: 135),
                ))),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge),
                  Row(
                    children: [
                      Flexible(
                          child: Icon(
                        Icons.book_outlined,
                        color: appColors.inkBase,
                        size: 17,
                      )),
                      SizedBox(
                        width: 6,
                      ),
                      Flexible(
                        child: Text(title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: Wrap(
                alignment: WrapAlignment.end,
                children: [
                  PopupMenuButton(
                      onSelected: (value) {
                        // _onSelectStoryAction(value, context, ref);
                      },
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                            const PopupMenuItem(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                value: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Chỉnh sửa'),
                                  ],
                                )),
                            const PopupMenuItem(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                value: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.remove_red_eye_rounded),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Chia sẻ'),
                                  ],
                                )),
                            const PopupMenuItem(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                value: 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.delete),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Xóa'),
                                  ],
                                )),
                          ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
