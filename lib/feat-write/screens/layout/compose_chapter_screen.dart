import 'dart:convert';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../repositories/chapter_repository.dart';
import '../../../theme/theme_constants.dart';
import '../../../widgets/input/text_input.dart';

import 'package:flutter/src/widgets/text.dart' as text;

class ComposeChapterScreen extends StatefulWidget {
  final String? storyTitle;
  final Story? story;
  final String? chapterId;
  const ComposeChapterScreen(
      {super.key, this.storyTitle, this.story, this.chapterId});

  @override
  State<ComposeChapterScreen> createState() => _ComposeChapterScreenState();
}

class _ComposeChapterScreenState extends State<ComposeChapterScreen> {
  //d1f0648b-40b0-11ee-a0bf-0242ac1b0002
  final _formKey = GlobalKey<FormBuilderState>();
  final _controller = QuillController.basic();

  Widget _createChapterForm() {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return FormBuilder(
      key: _formKey,
      initialValue: const {'title': '', 'content': 'Miêu tả'},
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppTextInputField(
              hintText: 'Nhập tiêu đề cho chương ${widget.story!.title}',
              name: 'title',
              marginVertical: 10,
            ),
            text.Text(
              'Ảnh bìa',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FormBuilderImagePicker(
                  validator: FormBuilderValidators.required(),
                  backgroundColor: appColors.skyLighter,

                  availableImageSources: const [
                    ImageSourceOption.gallery
                  ], //only gallery
                  name: 'photos',
                  // decoration: const InputDecoration(labelText: 'Pick Photos'),
                  maxImages: 1,
                ),
              ],
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pushNamed('composeStory',
                extra: {'storyId': widget.story?.id});
          },
        ),
        title: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text.Text(
                widget.story?.chapters?.length == 1
                    ? 'Chương 1'
                    : 'Chương ${widget.story?.chapters?.length}',
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
                  final validationSuccess = _formKey.currentState!.validate();
                  if (validationSuccess) {
                    //save data
                    _formKey.currentState!.save();

                    //create form data
                    Map<String, String> body = <String, String>{};
                    print(
                        'chapterId ${widget.story?.chapters?.elementAt(0).id as String}');
                    body['chapter_id'] =
                        widget.story?.chapters?.elementAt(0).id as String;
                    body['title'] =
                        _formKey.currentState!.fields['title']!.value;
                    // body['timestamp'] = DateTime.timestamp().toIso8601String();
                    body['version_name'] = 'version_name';

                    //raw text==content: string
                    //rich text: []
                    body['content'] = jsonEncode(
                        _controller.document.toPlainText().toString());
                    var json =
                        jsonEncode(_controller.document.toDelta().toJson());
                    body['rich_text'] = json;
                    if (kDebugMode) {
                      print(body);
                    }
                    //call api
                    bool isCreated = await ChapterRepository()
                        .createChapterVersion(body,
                            _formKey.currentState!.fields['photos']!.value);
                    isCreated
                        ? _displaySnackBar('Tạo chương truyện thành công')
                        : _displaySnackBar('Tạo chương truyện thất bại');
                  }
                },
              )),
            ),
          )
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _createChapterForm(),
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
          child: QuillEditor.basic(controller: _controller, readOnly: false),
        )),
      ]),
    );
  }
}
