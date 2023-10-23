import 'package:audiory_v0/feat-write/provider/story_state_provider.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class StoryCardDetailWriter extends ConsumerWidget {
  final Story? story;
  void _displaySnackBar(String? content, BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: appColors.primaryBase,
      duration: const Duration(seconds: 3),
      content: Text(content as String),
      action: SnackBarAction(
        textColor: appColors.skyBase,
        label: 'Undo',
        onPressed: () {},
      ),
    ));
  }

  showAlertDialog(BuildContext context, WidgetRef ref) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Hủy"),
      onPressed: () {
        context.pop();
      },
    );
    Widget unPublishButton = TextButton(
      child: const Text("Dừng đăng"),
      onPressed: () async {
        context.pop();

        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       return const Center(child: CircularProgressIndicator());
        //     });
        // int code = await StoryRepostitory().deleteStoryById(story.id);

        // // ignore: use_build_context_synchronously
        // context.pop();

        // if (code == 200) {
        //   // ignore: use_build_context_synchronously
        //   _displaySnackBar('Dừng thành công ${story.title}', context);
        // } else {
        //   // ignore: use_build_context_synchronously
        //   _displaySnackBar('Dừng gặp lỗi ${story.title}', context);
        // }
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Xóa"),
      onPressed: () async {
        context.pop();

        showDialog(
            context: context,
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            });

        ref.read(storyDataProvider.notifier).deleteStoryOfUser(story);

        // ignore: use_build_context_synchronously
        // context.pop();

        _displaySnackBar('Xóa thành công ${story?.title}', context);

        // if (200 == '') {
        //   // ignore: use_build_context_synchronously
        //   _displaySnackBar('Xóa thành công ${story.title}', context);
        // } else {
        //   // ignore: use_build_context_synchronously
        //   _displaySnackBar('Xóa gặp lỗi ${story.title}', context);
        // }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Xác nhận xóa truyện ${story?.title}"),
      content: const Text("Tất cả nội dung sẽ bị xóa?"),
      actions: [cancelButton, continueButton, unPublishButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  const StoryCardDetailWriter({super.key, required this.story});
  Map<String, dynamic> getStoryStatus(context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    Map<String, dynamic> map = {
      'status': 'Đang tiến hành',
      'color': appColors.primaryBase,
    };
    if (story?.isCompleted == true) {
      map.update('status', (value) => 'Hoàn thành');
      map.update('color', (value) => Colors.blue);
    } else if (story?.isDraft ?? true) {
      map.update('status', (value) => 'Bản thảo');
      map.update('color', (value) => const Color.fromRGBO(255, 171, 64, 1));
    }
    return map;
  }

  String formatDate(String? date) {
    //use package intl
    DateTime dateTime = DateTime.parse(date as String);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final Map<String, dynamic> storyStatus = getStoryStatus(context);

    final popupMenuItem = ['edit', 'share', 'preview', 'delete'];
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
                      image: NetworkImage(story?.coverUrl ?? ''),
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
                          story?.title ?? '',
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
                                        'Cập nhật ${formatDate(story?.updatedDate)}',
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
                                    '${story?.chapters?.length ?? 'error'} chương + ${story?.draftCount} bản thảo',
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
                    _onSelectStoryAction(value, context, ref);
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
                        PopupMenuItem(
                            enabled: story?.isDraft == false,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            value: 2,
                            child: const Row(
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

  void _onSelectStoryAction(int value, BuildContext context, WidgetRef ref) {
    if (kDebugMode) {
      print('value $value');
    }

    switch (value) {
      case 0:
        context.pushNamed('composeStory', extra: {'storyId': story?.id});
        break;
      case 1:
        context.pushNamed('previewChapter',
            extra: {'storyId': story?.id, 'chapterId': null});
        break;
      case 3:
        showAlertDialog(context, ref);
        break;

      default:
    }
  }
}
