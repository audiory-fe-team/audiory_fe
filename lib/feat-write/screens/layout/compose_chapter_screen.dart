import 'dart:convert';
import 'package:audiory_v0/feat-write/provider/chapter_version_provider.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/state/state_manager.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repositories/chapter_repository.dart';
import '../../../theme/theme_constants.dart';
import '../../../widgets/input/text_input.dart';

import 'package:flutter/src/widgets/text.dart' as text;

import '../../data/models/chapter_version_model/chapter_version_model.dart';

class ComposeChapterScreen extends ConsumerStatefulWidget {
  final String? storyTitle;
  final Story? story;
  final String? chapterId;
  const ComposeChapterScreen(
      {super.key, this.storyTitle, this.story, this.chapterId});

  @override
  ConsumerState<ComposeChapterScreen> createState() =>
      _ComposeChapterScreenState();
}

class _ComposeChapterScreenState extends ConsumerState<ComposeChapterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _controller = QuillController.basic();

  //
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.

    ref.read(chapterByIdFutureProvider(widget.chapterId as String));

    //get all chapter versions of  a chapter
  }

  Widget _createChapterForm(
      Chapter chapterByStoryId, ChapterVersion chapterVersion) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return FormBuilder(
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
                    width: MediaQuery.of(context).size.width / 3.3,
                    child: FormBuilderImagePicker(
                      initialValue: [
                        chapterVersion.bannerUrl != ''
                            ? chapterVersion.bannerUrl
                            : null
                      ],
                      // : [
                      //     'https://www.micreate.eu/wp-content/img/default-img.png'
                      //   ],

                      validator: FormBuilderValidators.required(),
                      backgroundColor: appColors.skyLighter,
                      availableImageSources: const [
                        ImageSourceOption.gallery
                      ], //only gallery
                      name: 'photos',
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      maxImages: 1,
                    ),
                  ),
                ],
              ),
            ),
            AppTextInputField(
              initialValue: chapterByStoryId.title,
              hintText: chapterByStoryId.title,
              name: 'title',
              marginVertical: 10,
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
              children: [
                // Container(
                //   width: 100,
                //   child: AppIconButton(
                //     onPressed: () {},
                //     title: 'Hủy',
                //     bgColor: appColors.skyLighter,
                //     color: appColors.inkDark,
                //   ),
                // ),
                // Container(
                //   width: 100,
                //   child: AppIconButton(
                //     onPressed: () {
                //       _formKey.currentState!.save();
                //       context.go(
                //           '/composeChapter/${_formKey.currentState!.value['title']}',
                //           extra: {_formKey.currentState!.value['title']});
                //     },
                //     title: 'Tạo mới',
                //   ),
                // )
              ],
            )
          ]),
    );
  }

  void _displaySnackBar(String? content) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: appColors.primaryBase,
      duration: const Duration(seconds: 3),
      content: text.Text(content as String),
      action: SnackBarAction(
        textColor: appColors.skyBase,
        label: 'Undo',
        onPressed: () {},
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final popupMenuItem = ['saveDraft', 'preview'];
    final String selectedValue = popupMenuItem[0];

    //riverpod state
    final AsyncValue<Chapter?>? chapterByStoryId =
        ref.watch(chapterByIdFutureProvider(widget.chapterId as String));

    final List<ChapterVersion> data =
        ref.watch(chapterVersionDataProvider(widget.chapterId as String));
    final isLoading = ref.watch(isLoadingChapterVersionsProvider);

    //create chapter version
    //call chapter version by chapterId
    return chapterByStoryId != null
        ? chapterByStoryId.when(
            data: (chapter) => Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: CustomAppBar(
                    // leading: IconButton(
                    //   icon: const Icon(Icons.arrow_back),
                    //   onPressed: () {
                    //     // context.push('/composeStory',
                    //     //     extra: {'storyId': widget.story?.id});
                    //         context.push('/composeStory',
                    //         extra: {'storyId': widget.story?.id});
                    //   },
                    // ),
                    title: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text.Text(
                            widget.story?.chapters?.length == 1
                                ? 'Chương 1'
                                : 'Chương ${chapter?.position}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: appColors.inkBase),
                          ),
                          PopupMenuButton(
                              onSelected: (value) {},
                              icon: const Icon(Icons.arrow_drop_down),
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: popupMenuItem[0],
                                        child: const text.Text('Lưu bản thảo')),
                                    PopupMenuItem(
                                        value: popupMenuItem[1],
                                        child: const text.Text('Xem trước')),
                                  ])
                        ],
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return const text.Text('model');
                              });
                        },
                        child: chapter?.isDraft as bool
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: GestureDetector(
                                  child: text.Text(
                                    'Đăng tải',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: appColors.primaryBase),
                                  ),
                                  onTap: () async {
                                    final validationSuccess =
                                        _formKey.currentState!.validate();
                                    if (validationSuccess) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          });
                                      //save data
                                      _formKey.currentState!.save();

                                      //create form data
                                      Map<String, String> body =
                                          <String, String>{};
                                      // print(
                                      //     'chapterId ${widget.story?.chapters?.elementAt(0).id}');
                                      // body['chapter_id'] = widget
                                      //     .story?.chapters
                                      //     ?.elementAt(0)
                                      //     .id as String;
                                      body['chapter_id'] =
                                          chapter?.id as String;
                                      body['title'] = _formKey
                                          .currentState!.fields['title']!.value;
                                      // body['timestamp'] = DateTime.timestamp().toIso8601String();
                                      body['version_name'] = 'version_name';

                                      //raw text==content: string
                                      //rich text: []
                                      body['content'] = jsonEncode(_controller
                                          .document
                                          .toPlainText()
                                          .toString());
                                      var json = jsonEncode(_controller.document
                                          .toDelta()
                                          .toJson());
                                      body['rich_text'] = json.toString();
                                      if (kDebugMode) {
                                        print(body);
                                      }
                                      //call api
                                      bool isCreated = await ChapterRepository()
                                          .createChapterVersion(
                                              body,
                                              _formKey.currentState!
                                                  .fields['photos']!.value);
                                      // ignore: use_build_context_synchronously
                                      context.pop();

                                      isCreated
                                          ? _displaySnackBar(
                                              'Tạo chương truyện thành công')
                                          : _displaySnackBar(
                                              'Tạo chương truyện thất bại');
                                      // ignore: use_build_context_synchronously
                                      context.pop();
                                      // ignore: use_build_context_synchronously
                                      context.go('/composeStory',
                                          extra: {'storyId': widget.story?.id});
                                    } else {
                                      _displaySnackBar('Không được để trống');
                                    }
                                  },
                                )),
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                      )
                    ],
                  ),
                  body: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(mainAxisSize: MainAxisSize.max, children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: FormBuilderDropdown(
                                name: 'chapterVersion',
                                initialValue: data[0].id,
                                selectedItemBuilder: (context) => List.generate(
                                      data.length,
                                      (index) => text.Text(
                                        'Bản ${data[0].timestamp}',
                                      ),
                                    ),
                                focusColor: appColors.primaryBase,
                                items: List.generate(
                                    data.length,
                                    (index) => DropdownMenuItem(
                                          value: data[index].id,
                                          child: text.Text(
                                            'Bản ${data[index].timestamp}',
                                          ),
                                        ))),
                          ),
                          // text.Text(data[0].richText as String),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child:
                                _createChapterForm(chapter as Chapter, data[0]),
                          ),
                          QuillToolbar.basic(
                            controller: _controller,
                            showAlignmentButtons: false,
                            showCodeBlock: false,
                            showBackgroundColorButton: false,
                            showIndent: false,
                            showInlineCode: false,
                            showLink: false,
                            showListCheck: false,
                            showQuote: false,
                            showSubscript: false,
                            showSuperscript: false,
                            showStrikeThrough: false,
                            showSmallButton: false,
                            showColorButton: false,
                            showDividers: false,
                            showClearFormat: false,
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: QuillEditor.basic(
                                controller: QuillController(
                                    document: Document.fromJson(
                                        jsonDecode(data[0].richText as String)),
                                    selection: const TextSelection.collapsed(
                                        offset: 0)),
                                readOnly: false),
                          )),
                        ]),
                ),
            error: (err, stack) => text.Text(
                  err.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
            loading: () => Scaffold(
                  body: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ))
        : const SizedBox(
            height: 0,
          );
  }
}
