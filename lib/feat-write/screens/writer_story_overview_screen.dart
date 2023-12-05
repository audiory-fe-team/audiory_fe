import 'package:audiory_v0/feat-write/screens/layout/compose_chapter_screen.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/chapter_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';

import 'package:audiory_v0/feat-write/widgets/edit_chapter_card.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../theme/theme_constants.dart';

class WriterStoryOverviewScreen extends StatefulHookWidget {
  final String? storyId;
  const WriterStoryOverviewScreen({super.key, this.storyId});

  @override
  State<WriterStoryOverviewScreen> createState() =>
      _WriterStoryOverviewScreenState();
}

class _WriterStoryOverviewScreenState extends State<WriterStoryOverviewScreen> {
  //tags
  double? _distanceToField;
  TextfieldTagsController? _controller;

  //check edit mode
  bool isEdit = true; //widget is not in initialize, add late instead
  bool? isPaywalled = false;
  //override init state when declare consumerStatefulWidget
  @override
  void initState() {
    super.initState();
    setState(() {
      isEdit = widget.storyId?.trim() != '';
      //tags initial
      _controller = TextfieldTagsController();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;

    //get editing story
    final editStoryByIdQuery = useQuery(
      ['editStory', widget.storyId],
      refetchOnMount: RefetchOnMount.always,
      () => StoryRepostitory().fetchStoryById(widget.storyId ?? ''),
    );

    //get all chapters of edit story
    final chaptersQuery = useQuery(
      ['chapters', widget.storyId],
      enabled: widget.storyId != "",
      () => StoryRepostitory().fetchAllChaptersStoryById(widget.storyId ?? ''),
    );

    handleDeleteChapter(chapterId) async {
      try {
        await ChapterRepository().deleteChapter(chapterId);
        // ignore: use_build_context_synchronously
        AppSnackBar.buildTopSnackBar(
            context, 'Xóa thành công', null, SnackBarType.success);
        chaptersQuery.refetch();
      } catch (e) {
        // ignore: use_build_context_synchronously
        AppSnackBar.buildTopSnackBar(
            context, 'Xóa không thành công', null, SnackBarType.error);
      }
    }

    handlePublishChapter(chapterId, status) async {
      if (status == false) {
        try {
          await ChapterRepository().unpublishChapter(chapterId);
          // ignore: use_build_context_synchronously
          AppSnackBar.buildTopSnackBar(
              context, 'Gỡ đăng tải thành công', null, SnackBarType.success);
          chaptersQuery.refetch();
        } catch (e) {
          // ignore: use_build_context_synchronously
          AppSnackBar.buildTopSnackBar(context, 'Gỡ đăng tải không thành công',
              null, SnackBarType.error);
        }
      } else {
        try {
          await ChapterRepository().publishChapter(chapterId);
          // ignore: use_build_context_synchronously
          AppSnackBar.buildTopSnackBar(
              context, 'Đăng tải thành công', null, SnackBarType.success);
          chaptersQuery.refetch();
        } catch (e) {
          // ignore: use_build_context_synchronously
          AppSnackBar.buildTopSnackBar(
              context, 'Đăng tải không thành công', null, SnackBarType.error);
        }
      }
    }

    Future<void> showConfirmChapterDeleteDialog(
        BuildContext context, Chapter chapter) async {
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;

      final textTheme = Theme.of(context).textTheme;
      return showDialog<void>(
        context: context, // User must tap button to close the dialog
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(child: Text('Xác nhận xóa?')),
            content: const Text('Bạn chắc chắn muốn xóa chương này'),
            actions: <Widget>[
              Container(
                width: 70,
                height: 30,
                child: AppIconButton(
                  bgColor: appColors.secondaryLight,
                  color: appColors.skyLight,
                  title: 'Có',
                  onPressed: () {
                    // Perform the action
                    handleDeleteChapter(chapter.id);
                    context.pop(); // Dismiss the dialog
                  },
                ),
              ),
              TextButton(
                child: Text(
                  'Hủy',
                  style: textTheme.titleMedium,
                ),
                onPressed: () {
                  context.pop(); // Dismiss the dialog
                },
              ),
            ],
          );
        },
      );
    }

    Widget chapterList(
        BuildContext context, Story? editStory, List<Chapter>? chaptersList) {
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 5,
        ),

        const SizedBox(
          height: 5,
        ),
        isEdit
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mục lục',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${chaptersList?.length ?? 0} chương',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: appColors.inkLighter),
                  ),
                ],
              )
            : const SizedBox(
                height: 0,
              ),
        // provider for chapters

        chaptersList != null && chaptersList.isNotEmpty == true
            ? Column(
                children: List?.generate(chaptersList.length ?? 0, (index) {
                  return EditChapterCard(
                    index: index + 1,
                    chapter: chaptersList[index],
                    story: editStory,
                    onDeleteChapter: () {
                      showConfirmChapterDeleteDialog(
                          context, chaptersList[index]);
                    },
                    onPublish: () {
                      handlePublishChapter(
                          chaptersList[index].id, chaptersList[index].isDraft);
                    },
                  );
                }),
              )
            : const SizedBox(
                height: 0,
              ),
        editStory != null
            ? Center(
                child: GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Thêm chương mới '),
                  ),
                  onTap: () async {
                    final length = chaptersList?.length ?? 0;
                    final res = await ChapterRepository().createChapter(
                        widget.storyId, (chaptersList?.length ?? 0) + 1);
                    chaptersQuery.refetch();

                    // ignore: use_build_context_synchronously
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        enableDrag: false,
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return ComposeChapterScreen(
                            chapterId: res?.id,
                            story: editStory,
                            chapter: res,
                            callback: () {
                              chaptersQuery.refetch();
                            },
                          );
                        });
                  },
                ),
              )
            : const SizedBox(
                height: 0,
              ),
        const SizedBox(
          height: 10,
        ),
      ]);
    }

    storyOverView(Story? story) {
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

      Map<String, dynamic> storyStatus = getStoryStatus(context);

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GestureDetector(
                onTap: () {
                  context
                      .pushNamed('composeStory', extra: {'storyId': story?.id});
                },
                child: AppImage(
                  width: size.width / 4,
                  height: size.height / 6,
                  url: story?.coverUrl,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
                width: double.infinity,
                height: size.height / 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${story?.title}',
                          style: textTheme.titleLarge,
                        ),
                        Text(
                          story?.description ?? '',
                          maxLines: 2,
                          style: textTheme.bodySmall?.copyWith(
                              color: appColors.inkLight,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${storyStatus['status']}',
                          style: textTheme.bodySmall
                              ?.copyWith(color: storyStatus['color']),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: AppIconButton(
                        bgColor: appColors.skyLightest,
                        onPressed: () {
                          context.pushNamed('composeStory',
                              extra: {'storyId': story?.id});
                        },
                        title: 'Chỉnh sửa',
                        textStyle: textTheme.titleMedium
                            ?.copyWith(color: appColors.primaryBase),
                      ),
                    )
                  ],
                )),
          )
        ],
      );
    }

    paywalledSection(Story? story) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Divider(
              color: appColors.skyLighter,
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  'Thương mại hóa',
                  style: textTheme.titleLarge,
                )),
                Flexible(
                    child: TextButton(
                  onPressed: () {
                    context.pushNamed('paywallStory', extra: {'story': story});
                  },
                  child: Text(
                    'Tiếp tục',
                    style: textTheme.bodySmall
                        ?.copyWith(color: appColors.primaryBase),
                  ),
                )),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true, //avoid keyboard resize screen=> false
      appBar: CustomAppBar(
        title: Skeletonizer(
          enabled: editStoryByIdQuery.data == null,
          child: Text(
            '${editStoryByIdQuery.data?.title}',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: appColors.inkBase),
          ),
        ),
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          editStoryByIdQuery.refetch();
          chaptersQuery.refetch();
        },
        child: SingleChildScrollView(
          child: Skeletonizer(
            enabled: editStoryByIdQuery.isFetching && chaptersQuery.isFetching,
            child: Column(

                // mainAxisSize: MainAxisSize.max,

                children: [
                  editStoryByIdQuery.data != null ||
                          editStoryByIdQuery.isError ||
                          widget.storyId == ''
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              storyOverView(editStoryByIdQuery.data),
                              paywalledSection(editStoryByIdQuery.data),
                              chapterList(context, editStoryByIdQuery.data,
                                  chaptersQuery.data),
                            ],
                          ),
                        )
                      : const Skeletonizer(
                          enabled: true, child: Text('loading'))
                ]),
          ),
        ),
      ),
    );
  }
}
