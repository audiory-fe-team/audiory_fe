import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class StoryCardDetailWriter extends StatelessWidget {
  final Story story;

  const StoryCardDetailWriter({super.key, required this.story});
  Map<String, dynamic> getStoryStatus(context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    Map<String, dynamic> map = {
      'status': 'Đang tiến hành',
      'color': Colors.black,
    };
    if (story.is_completed as bool) {
      map.update('status', (value) => 'Hoàn thành');
      map.update('color', (value) => appColors.primaryBase);
    } else if (story.is_draft as bool) {
      map.update('status', (value) => 'Bản thảo');
      map.update('color', (value) => Colors.orangeAccent);
    }
    return map;
  }

  String formatDate(String? date) {
    //use package intl
    DateTime dateTime = DateTime.parse(date as String);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final Map<String, dynamic> storyStatus = getStoryStatus(context);

    final popupMenuItem = ['edit', 'share', 'preview', 'cancel', 'delete'];
    final String selectedValue = popupMenuItem[0];

    return Container(
      width: double.infinity,
      height: 135,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                      image: NetworkImage(story.cover_url ?? ''),
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
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
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
                          '#${storyStatus['status']}',
                          style: textTheme.titleMedium!.merge(TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: storyStatus['color'])),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          story.title,
                          style: textTheme.titleLarge!.merge(
                              const TextStyle(overflow: TextOverflow.ellipsis)),
                        ),
                      ),
                      const SizedBox(height: 24),
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
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/icons/write.svg',
                                    width: 14, height: 14),
                                const SizedBox(width: 8),
                                SizedBox(
                                    width: 140,
                                    child: Text(
                                        'Cập nhật ${formatDate(story.updated_date)}',
                                        style: textTheme.titleSmall!.copyWith(
                                            fontStyle: FontStyle.italic,
                                            overflow: TextOverflow.ellipsis))),
                              ],
                            ),
                            const SizedBox(width: 6),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/icons/chapter.svg',
                                    width: 14, height: 14),
                                const SizedBox(width: 8),
                                Text(
                                    '${story.chapters?.length ?? 'error'} chương + ${story.draft_count} bản thảo',
                                    style: textTheme.titleSmall!
                                        .copyWith(fontStyle: FontStyle.italic)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            children: [
              PopupMenuButton(
                  onSelected: (value) {
                    _onSelectStoryAction(value, context);
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
                                Text('Xem trước'),
                              ],
                            )),
                        const PopupMenuItem(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            value: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.ios_share_rounded),
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
                                Icon(Icons.play_arrow),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Tạm dừng'),
                              ],
                            )),
                        const PopupMenuItem(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            value: 4,
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
        ],
      ),
    );
  }

  void _onSelectStoryAction(int value, BuildContext context) {
    if (kDebugMode) {
      print('value $value');
    }

    switch (value) {
      case 0:
        context.pushNamed('composeStory', extra: {'storyId': story.id});
        break;
      default:
    }
  }
}
