import 'dart:convert';

import 'package:audiory_v0/feat-write/data/models/chapter_version_model/chapter_version_model.dart';
import 'package:audiory_v0/feat-write/screens/layout/content_moderation_dialog.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/chapter_version_repository.dart';
import 'package:audiory_v0/repositories/interaction_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/utils/quill_helper.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../repositories/chapter_repository.dart';
import '../../../theme/theme_constants.dart';
import '../../../widgets/input/text_input.dart';

import 'package:flutter/src/widgets/text.dart' as text;

class ComposeChapterScreen extends StatefulHookWidget {
  final String? storyTitle;
  final Story? story;
  final String? chapterId;
  final Chapter? chapter;
  final Function? callback;
  const ComposeChapterScreen(
      {super.key,
      this.storyTitle,
      this.story,
      this.chapterId,
      this.chapter,
      this.callback});

  @override
  State<ComposeChapterScreen> createState() => _ComposeChapterScreenState();
}

class _ComposeChapterScreenState extends State<ComposeChapterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _controller = QuillController.basic();

  // @override
  // void initState() {
  //   super.initState();
  //   _controller.document = widget.args.document;
  // }

  Widget _createChapterForm(
    UseQueryResult<Chapter?, dynamic> chapterByIdQuery,
  ) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Skeletonizer(
      enabled: chapterByIdQuery.isFetching,
      child: FormBuilder(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: FormBuilderImagePicker(
                        fit: BoxFit.fitWidth,
                        previewWidth: double.infinity,
                        previewHeight: 145,
                        placeholderWidget: Container(
                          decoration: BoxDecoration(
                            color: appColors.skyLightest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.add,
                            color: appColors.inkLight,
                          )),
                        ),
                        initialValue: [
                          chapterByIdQuery
                                      .data?.currentChapterVerion?.bannerUrl !=
                                  ''
                              ? chapterByIdQuery
                                  .data?.currentChapterVerion?.bannerUrl
                              : null
                        ],

                        availableImageSources: const [
                          ImageSourceOption.gallery
                        ], //only gallery
                        name: 'photos',
                        //display preview image in center
                        transformImageWidget: (context, displayImage) => Center(
                            child: Container(
                                decoration:
                                    BoxDecoration(color: appColors.skyLightest),
                                width: double.infinity,
                                child: displayImage)),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        showDecoration: false,
                        maxImages: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Skeletonizer(
                enabled: chapterByIdQuery.isFetching,
                child: AppTextInputField(
                  initialValue:
                      chapterByIdQuery.data?.title, //do not put ?? '' here
                  hintText: 'Nhập tiêu đề',
                  name: 'title',
                  marginVertical: 10,
                  textAlign: TextAlign.center,
                ),
              ),
              // text.Text(
              //   'Ảnh bìa ',
              //   style: Theme.of(context)
              //       .textTheme
              //       .titleLarge
              //       ?.copyWith(fontWeight: FontWeight.bold),
              // ),
              const SizedBox(
                height: 5,
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              )
            ]),
      ),
    );
  }

  int getCharactersLength() {
    var length = 0;
    length = _controller.document.toPlainText().split(' ').length;
    return length;
  }

  getChapterVersionDetail(chapterVersionId) {
    return ChapterVersionRepository()
        .fetchChapterVersionByChapterVersionId(chapterVersionId);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final _formReportKey = GlobalKey<FormBuilderState>();

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final chapterByIdQuery = useQuery(
      ['chapterById${widget.chapterId}', widget.chapter?.currentVersionId],
      enabled: true,
      refetchOnMount: RefetchOnMount.always,
      () => ChapterRepository().fetchAuthorChapterById(widget.chapterId),
    );

    final chapterVersionsQuery = useQuery(
      ['chapterVersions', widget.chapterId],
      enabled: true,
      refetchOnMount: RefetchOnMount.always,
      () => ChapterVersionRepository()
          .fetchChapterVersionsOfChapter(widget.chapterId),
    );

    onRevert({String chapterVersionId = ''}) {
      try {
        ChapterVersionRepository().revertChapterVersion(chapterVersionId);
        AppSnackBar.buildTopSnackBar(
            context, 'Khôi phục thành công', null, SnackBarType.success);
        context.pop();
        context.pop();
        chapterByIdQuery.refetch();
      } catch (e) {}
    }

    useEffect(() {
      _controller.document = chapterByIdQuery.isSuccess
          ? chapterByIdQuery.data?.currentChapterVerion?.richText != "" &&
                  chapterByIdQuery.data?.currentChapterVerion?.richText != null
              ? Document.fromJson(jsonDecode(
                  chapterByIdQuery.data?.currentChapterVerion?.richText ??
                      r'{"insert":"hello\n"}')['ops'])
              : Document()
          : Document();
    }, [chapterByIdQuery.isSuccess]);

    saveDraft() async {
      // print(_controller.document.toDelta());
      // print(_controller.document.toDelta().toJson().toString());
      // print(_controller.document.toDelta().compose(Delta()));
      // print(jsonEncode(_controller.document.toDelta()).toString());
      // print(
      //     '{"ops":${(Delta.fromOperations(_controller.document.toDelta().toList()))}');
      if (getCharactersLength() < 5) {
        AppSnackBar.buildTopSnackBar(
            context, 'Tối thiểu 5 từ', null, SnackBarType.error);
      } else {
        _formKey.currentState?.save();
        Map<String, String> body = {
          'chapter_id': widget.chapterId ?? '',
          'content': _controller.document.toPlainText(),
          'rich_text':
              '{"ops":${jsonEncode(_controller.document.toDelta()).toString()}}',
          'title': _formKey.currentState?.fields['title']?.value ?? '',
        };
        try {
          final res = await ChapterRepository().createChapterVersion(
              body, _formKey.currentState?.fields['photos']?.value);

          if (res == true) {
            // ignore: use_build_context_synchronously
            AppSnackBar.buildTopSnackBar(
                context, 'Lưu thành công', null, SnackBarType.success);
            chapterVersionsQuery.refetch();
            chapterByIdQuery.refetch();
          }

          print(res);
        } catch (e) {
          print(e);
        }
      }
    }

    handleCreateReport(String? chapterVersionId) async {
      Map<String, String> body = <String, String>{};

      body['description'] =
          _formReportKey.currentState?.fields['description']?.value;
      body['title'] = _formReportKey.currentState?.fields['title']?.value;
      body['reported_id'] = chapterVersionId ?? '';
      body['report_type'] = 'CONTENT_VIOLATION_COMPLAINT';
      body['user_id'] = widget.story?.authorId ?? '';
      print(body);
      try {
        final res = await InteractionRepository()
            .report(body, _formReportKey.currentState!.fields['photo']?.value);
        // ignore: use_build_context_synchronously
        context.pop();
        // ignore: use_build_context_synchronously
        context.pop();
        // ignore: use_build_context_synchronously
        context.pop();
        // ignore: use_build_context_synchronously
        AppSnackBar.buildTopSnackBar(
            context, 'Tạo báo cáo thành công', null, SnackBarType.success);
        print(res);
      } catch (e) {
        print(e);
      }
    }

    publishChapter() async {
      if (getCharactersLength() < 5) {
        AppSnackBar.buildTopSnackBar(
            context, 'Tối thiểu 5 từ', null, SnackBarType.error);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            });
        print('saving');
        _formKey.currentState?.save();
        Map<String, String> body = {
          'chapter_id': widget.chapterId ?? '',
          'content': _controller.document.toPlainText(),
          'rich_text':
              '{"ops":${jsonEncode(_controller.document.toDelta()).toString()}}',
          'title': _formKey.currentState?.fields['title']?.value ?? '',
        };

        final res = await ChapterRepository().createChapterVersion(
            body, _formKey.currentState?.fields['photos']?.value);

        final res2 = await ChapterRepository().publishChapter(widget.chapterId);
        print('res2 ${res2['code'] == '200'}');
        print('res2 ${res2['message']}');
        context.pop();
        if (res2['code'] == 200) {
          AppSnackBar.buildTopSnackBar(
              context, 'Đăng tải thành công', null, SnackBarType.success);
          chapterVersionsQuery.refetch();
          chapterByIdQuery.refetch();

          context.pop();
        } else {
          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Container(
                    height: size.height / 3,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: size.width / 3.5,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                    width: size.width / 4,
                                    height: size.width / 4,
                                    'assets/images/dialog_warning.png')),
                          ),
                          Text(
                            'Chương của bạn có chứa nội dung nhạy cảm. Nếu bạn vẫn muốn đăng tải chương này, hãy nhấn Tiếp tục',
                            textAlign: TextAlign.center,
                            style: textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: size.width / 3.2,
                                  child: AppIconButton(
                                    isOutlined: true,
                                    bgColor: appColors.inkBase,
                                    title: 'Chi tiết',
                                    textStyle: textTheme.bodySmall?.copyWith(
                                        color: appColors.primaryBase),
                                    onPressed: () async {
                                      final response =
                                          await ChapterVersionRepository()
                                              .fetchContentModeration(
                                                  res2['data']
                                                      ['current_version_id']);
                                      // ignore: use_build_context_synchronously
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          useSafeArea: true,
                                          builder: (context) {
                                            return ContentModerationDialog(
                                                paragraphs: response);
                                          });
                                    },
                                  )),
                              Container(
                                  width: size.width / 3.2,
                                  child: AppIconButton(
                                    title: 'Tiếp tục',
                                    textStyle: textTheme.bodySmall?.copyWith(
                                        color: appColors.skyLightest),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Thông báo'),
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 24.0),
                                                child: Text(
                                                  'Để đăng tải thành công truyện này, bạn cần bật nội dung trưởng thành cho truyện của mình',
                                                  textAlign: TextAlign.justify,
                                                  style: textTheme.titleMedium,
                                                ),
                                              ),
                                              actions: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        width: double.infinity,
                                                        child: AppIconButton(
                                                          isOutlined: true,
                                                          bgColor:
                                                              appColors.inkBase,
                                                          title: 'Kháng cáo',
                                                          textStyle: textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                  color: appColors
                                                                      .primaryBase),
                                                          onPressed: () async {
                                                            showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius
                                                                                .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8.0),
                                                                )),
                                                                useSafeArea:
                                                                    true,
                                                                backgroundColor:
                                                                    appColors
                                                                        .background,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Scaffold(
                                                                    body:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      // height:
                                                                      //     size.height -
                                                                      //         200,
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              8,
                                                                          horizontal:
                                                                              16),
                                                                      child: ListView(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      'Tạo báo cáo',
                                                                                      style: textTheme.headlineSmall,
                                                                                    ),
                                                                                  ),
                                                                                  Flexible(
                                                                                    flex: 2,
                                                                                    child: AppIconButton(
                                                                                        title: 'Tạo',
                                                                                        onPressed: () {
                                                                                          if (_formReportKey.currentState?.validate() ?? false) {
                                                                                            print('hei');
                                                                                            _formReportKey.currentState?.save();
                                                                                            handleCreateReport(res2['data']['current_version_id']);
                                                                                          } else {
                                                                                            print('false');
                                                                                          }
                                                                                        }),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            FormBuilder(
                                                                                key: _formReportKey,
                                                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    AppTextInputField(
                                                                                      name: 'title',
                                                                                      hintText: 'Nhập tiêu đề',
                                                                                      label: 'Tiêu đề báo cáo',
                                                                                      isRequired: true,
                                                                                      isNoError: false,
                                                                                      validator: FormBuilderValidators.required(errorText: 'Không được để trống'),
                                                                                    ),
                                                                                    AppTextInputField(
                                                                                      name: 'description',
                                                                                      hintText: 'Nhập nội dung',
                                                                                      label: 'Nội dung',
                                                                                      isRequired: true,
                                                                                      isTextArea: true,
                                                                                      maxLengthCharacters: 256,
                                                                                      minLines: 4,
                                                                                      validator: FormBuilderValidators.compose([
                                                                                        FormBuilderValidators.required(errorText: 'Không được để trống'),
                                                                                        FormBuilderValidators.max(256, errorText: 'Tối đa 256 ký tự')
                                                                                      ]),
                                                                                    ),
                                                                                    Text(
                                                                                      'Hình minh họa',
                                                                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    Center(
                                                                                      child: SizedBox(
                                                                                        width: size.width / 4,
                                                                                        height: 200,
                                                                                        child: FormBuilderImagePicker(previewAutoSizeWidth: true, maxImages: 1, backgroundColor: appColors.skyLightest, iconColor: appColors.primaryBase, decoration: const InputDecoration(border: InputBorder.none), name: 'photo'),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ))
                                                                          ]),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                        )),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                        width: double.infinity,
                                                        child: AppIconButton(
                                                          title:
                                                              'Bật truyện trưởng thành',
                                                          textStyle: textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                  color: appColors
                                                                      .skyLightest),
                                                          onPressed: () async {
                                                            Map<String, String>
                                                                body = {
                                                              'is_mature':
                                                                  'true'
                                                            };
                                                            Story? story = await StoryRepostitory()
                                                                .editStory(
                                                                    chapterByIdQuery
                                                                            .data
                                                                            ?.storyId ??
                                                                        '',
                                                                    body,
                                                                    ['']);

                                                            if (story != null) {
                                                              // ignore: use_build_context_synchronously
                                                              AppSnackBar.buildTopSnackBar(
                                                                  context,
                                                                  'Đã có thể đăng tải',
                                                                  null,
                                                                  SnackBarType
                                                                      .success);
                                                              widget.callback;
                                                            }
                                                            // ignore: use_build_context_synchronously
                                                            context.pop();
                                                            // ignore: use_build_context_synchronously
                                                            context.pop();
                                                          },
                                                        )),
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                    },
                                  )),
                            ],
                          )
                        ]),
                  ),
                );
              });
        }
      }
    }

    previewChapterVersion({String chapterVersionId = ''}) {
      showModalBottomSheet(
        backgroundColor: appColors.skyLightest,
        isScrollControlled: true,
        context: context,
        useSafeArea: true,
        builder: (context) => Container(
          height: size.height * 0.85,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    width: size.width,
                    child: text.Text(
                      'Bản xem trước',
                      style: textTheme.headlineMedium
                          ?.copyWith(color: appColors.inkBase),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          onRevert(chapterVersionId: chapterVersionId);
                        },
                        child: text.Text(
                          'Khôi phục',
                          style: textTheme.titleMedium
                              ?.copyWith(color: appColors.primaryBase),
                        ),
                      ))
                ],
              ),
              Expanded(
                // height: size.height * 0.75,
                child: ListView(
                  children: [
                    Container(
                        width: size.width,
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 4),
                        decoration: BoxDecoration(color: appColors.inkBase),
                        child: Center(
                          child: Text(
                            'Chỉ đọc',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: appColors.skyLightest),
                          ),
                        )),
                    FutureBuilder<ChapterVersion?>(
                        future: getChapterVersionDetail(chapterVersionId),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString(),
                                style: textTheme.titleMedium);
                          }
                          return Skeletonizer(
                            enabled: snapshot.connectionState ==
                                ConnectionState.waiting,
                            child: text.Text('${snapshot.data?.content}'),
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: Skeletonizer(
          enabled: chapterByIdQuery.isFetching,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                text.Text(
                  widget.story?.chapters?.length == 1
                      ? 'Chương 1'
                      : 'Chương ${chapterByIdQuery.data?.position ?? '1'}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: appColors.inkBase),
                ),
                PopupMenuButton(
                    onSelected: (value) {
                      switch (value) {
                        case 0:
                          saveDraft();
                          break;
                        case 1:
                          previewChapterVersion(
                              chapterVersionId:
                                  chapterByIdQuery.data?.currentVersionId ??
                                      '');
                          break;
                        case 2:
                          showModalBottomSheet(
                            backgroundColor: appColors.skyLightest,
                            isScrollControlled: true,
                            useSafeArea: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 24),
                                height: size.height - 80,
                                width: size.width,
                                child: Column(children: [
                                  text.Text(
                                    'Lịch sử sửa đổi',
                                    style: textTheme.headlineSmall,
                                  ),
                                  Container(
                                    height: size.height - 200,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            chapterVersionsQuery.data?.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              previewChapterVersion(
                                                  chapterVersionId:
                                                      chapterVersionsQuery
                                                              .data?[index]
                                                              .id ??
                                                          '');
                                            },
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  border: BorderDirectional(
                                                      bottom: BorderSide(
                                                          color: appColors
                                                              .inkLighter,
                                                          width: 0.5))),
                                              height: 50,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      flex: 4,
                                                      child: text.Text(
                                                        'Bản thảo ${chapterVersionsQuery.data?[index].versionName}',
                                                        style: textTheme.titleMedium?.copyWith(
                                                            color: chapterByIdQuery
                                                                        .data
                                                                        ?.currentVersionId ==
                                                                    chapterVersionsQuery
                                                                        .data?[
                                                                            index]
                                                                        .id
                                                                ? appColors
                                                                    .primaryBase
                                                                : appColors
                                                                    .inkBase),
                                                      ),
                                                    ),
                                                    chapterByIdQuery.data
                                                                ?.currentVersionId ==
                                                            chapterVersionsQuery
                                                                .data?[index].id
                                                        ? Flexible(
                                                            child: Icon(
                                                            Icons.check_circle,
                                                            color: appColors
                                                                .primaryBase,
                                                          ))
                                                        : SizedBox(
                                                            height: 0,
                                                          )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                ]),
                              );
                            },
                          );
                          break;
                        default:
                      }
                    },
                    icon: const Icon(Icons.arrow_drop_down),
                    itemBuilder: (context) => [
                          const PopupMenuItem(
                              value: 0, child: text.Text('Lưu bản thảo')),
                          const PopupMenuItem(
                              value: 1, child: text.Text('Xem trước')),
                          const PopupMenuItem(
                              value: 2, child: text.Text('Lịch sử sửa đổi')),
                        ])
              ],
            ),
          ),
        ),
        actions: [
          Skeletonizer(
            enabled: chapterByIdQuery.isFetching,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const text.Text('model');
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: GestureDetector(
                  child: text.Text(
                    'Đăng tải',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: appColors.primaryBase),
                  ),
                  onTap: () async {
                    publishChapter();
                  },
                )),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Skeletonizer(
            enabled: chapterByIdQuery.isFetching,
            child: chapterByIdQuery.data != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _createChapterForm(chapterByIdQuery),
                  )
                : Skeletonizer(
                    enabled: true,
                    child: Container(
                      child: Column(children: [
                        Text(''),
                        Container(
                          width: double.infinity,
                          height: 200,
                        )
                      ]),
                    )),
          ),
          Skeletonizer(
            enabled: chapterByIdQuery.isFetching,
            child: Container(
              // decoration:
              //     BoxDecoration(color: appColors.skyBase.withOpacity(0.4)),
              height: 500,
              child: QuillProvider(
                configurations: QuillConfigurations(
                  controller: _controller,
                  sharedConfigurations: QuillSharedConfigurations(
                    // locale: Locale('de'),
                    animationConfigurations:
                        QuillAnimationConfigurations.disableAll(),
                  ),
                ),
                child: Column(
                  children: [
                    QuillToolbar(
                        configurations: appQuillToolbarConfig(context)),
                    Expanded(
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                            readOnly: false, maxContentWidth: size.width - 32),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
