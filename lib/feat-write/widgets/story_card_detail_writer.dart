import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/feat-write/widgets/story_actions_menu.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class StoryCardDetailWriter extends StatelessWidget {
  final Story? story;
  final Function() callBackRefetch;

  showAlertDialog(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Hủy",
        style: textTheme.titleMedium,
      ),
      onPressed: () {
        context.pop();
      },
    );
    Widget unPublishButton = Container(
      width: 120,
      height: 40,
      child: AppIconButton(
        bgColor: appColors.inkBase,
        title: 'Dừng đăng',
        textStyle:
            textTheme.titleMedium?.copyWith(color: appColors.skyLightest),
        onPressed: () async {
          context.pop();

          showDialog(
              context: context,
              builder: (context) {
                return const Center(child: CircularProgressIndicator());
              });

          int code = await StoryRepostitory().unPublishStory(story?.id ?? '');

          // ignore: use_build_context_synchronously
          context.pop();

          if (code == 200) {
            // ignore: use_build_context_synchronously
            AppSnackBar.buildTopSnackBar(
                context,
                'Dừng đăng thành công ${story?.title}',
                null,
                SnackBarType.success);

            callBackRefetch();
          } else {
            // ignore: use_build_context_synchronously
          }
        },
      ),
    );
    Widget continueButton = Container(
      width: 80,
      height: 40,
      child: AppIconButton(
        bgColor: appColors.secondaryLight,
        title: 'Xóa',
        textStyle:
            textTheme.titleMedium?.copyWith(color: appColors.skyLightest),
        onPressed: () async {
          context.pop();

          showDialog(
              context: context,
              builder: (context) {
                return const Center(child: CircularProgressIndicator());
              });

          int code = await StoryRepostitory().deleteStory(story?.id ?? '');

          // ignore: use_build_context_synchronously
          context.pop();

          if (code == 200) {
            // ignore: use_build_context_synchronously
            AppSnackBar.buildTopSnackBar(context,
                'Xóa thành công ${story?.title}', null, SnackBarType.success);
            callBackRefetch();
          } else {
            // ignore: use_build_context_synchronously
          }
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Xác nhận xóa truyện ${story?.title}?"),
      content: const Text("Tất cả nội dung sẽ bị xóa?"),
      actionsOverflowAlignment: OverflowBarAlignment.end,
      actionsOverflowButtonSpacing: 3,
      actions: story?.isDraft == true
          ? [cancelButton, continueButton]
          : [cancelButton, continueButton, unPublishButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  const StoryCardDetailWriter(
      {super.key, required this.story, required this.callBackRefetch});
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

  Map<String, dynamic> getPaywalledStatus(context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    Map<String, dynamic> map = {
      'status': 'Truyện trả phí',
      'color': appColors.secondaryBase,
    };

    return map;
  }

  String formatDate(String? date) {
    //use package intl

    DateTime dateTime = DateTime.parse(date ?? "");
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final Map<String, dynamic> storyStatus = getStoryStatus(context);
    final Map<String, dynamic> paywalledStatus = getPaywalledStatus(context);

    final popupMenuItem = ['edit', 'delete'];
    final String selectedValue = popupMenuItem[0];

    return GestureDetector(
      onTap: () {
        context.pushNamed('editStoryOverview', extra: {'storyId': story?.id});
      },
      child: Container(
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
                  Stack(children: [
                    Container(
                      width: 95,
                      height: 135,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(story?.coverUrl == ""
                              ? FALLBACK_IMG_URL
                              : story?.coverUrl ?? FALLBACK_IMG_URL),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    story?.isPaywalled == true
                        ? Positioned(
                            bottom: 0,
                            child: Container(
                              width: 95,
                              height: 24,
                              decoration:
                                  BoxDecoration(color: appColors.secondaryBase),
                              child: Text(
                                '${paywalledStatus['status']}',
                                style: textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: appColors.skyLightest),
                                textAlign: TextAlign.center,
                              ),
                            ))
                        : const SizedBox(
                            height: 0,
                          )
                  ]),
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
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                '#${storyStatus['status']}',
                                style: textTheme.titleMedium!.merge(TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: storyStatus['color'])),
                              ),
                            ),
                            // story?.isPaywalled == true
                            //     ? Flexible(
                            //         child: Text(
                            //           '#${paywalledStatus['status']}',
                            //           style: textTheme.titleMedium!.merge(
                            //               TextStyle(
                            //                   overflow: TextOverflow.ellipsis,
                            //                   color: paywalledStatus['color'])),
                            //         ),
                            //       )
                            //     : const SizedBox(
                            //         height: 0,
                            //       )
                          ],
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            story?.title ?? '',
                            style: textTheme.titleLarge!.merge(const TextStyle(
                                overflow: TextOverflow.ellipsis)),
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
                                  SvgPicture.asset('assets/icons/chapter.svg',
                                      width: 14, height: 14),
                                  const SizedBox(width: 8),
                                  Text('${story?.publishedCount ?? '0'} chương',
                                      style: textTheme.titleSmall!.copyWith(
                                          fontStyle: FontStyle.italic)),
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
                                  Text('${story?.draftCount ?? 0} bản thảo',
                                      style: textTheme.titleSmall!.copyWith(
                                          fontStyle: FontStyle.italic)),
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
                    itemBuilder: (context) => story?.isPaywalled == true
                        ? [
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
                          ]
                        : appStoryActionsMenu(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectStoryAction(value, BuildContext context) {
    switch (value) {
      case 0:
        context.pushNamed('composeStory', extra: {'storyId': story?.id});
        break;
      case 1:
        context.pushNamed('previewChapter',
            extra: {'storyId': story?.id, 'chapterId': ''});
        break;
      case 3:
        showAlertDialog(context);
        break;

      default:
    }
  }
}
