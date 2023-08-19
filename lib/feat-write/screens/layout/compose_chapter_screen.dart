import 'package:audiory_v0/widgets/buttons/dropdown_button.dart';
import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/theme_constants.dart';
import '../../../widgets/input/text_input.dart';

import 'package:flutter/src/widgets/text.dart' as text;

class ComposeChapterScreen extends StatefulWidget {
  final String? storyTitle;
  const ComposeChapterScreen({super.key, this.storyTitle});

  @override
  State<ComposeChapterScreen> createState() => _ComposeChapterScreenState();
}

class _ComposeChapterScreenState extends State<ComposeChapterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _controller = QuillController.basic();

  Widget _createChapterForm() {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return FormBuilder(
      key: _formKey,
      initialValue: {'title': '', 'description': 'Miêu tả'},
      child: Column(children: [
        AppTextInputField(
          hintText: 'Nhập tiêu đề',
          name: 'title',
          marginVertical: 10,
        ),
        Row(
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

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final popupMenuItem = ['saveDraft', 'preview'];
    final String selectedValue = popupMenuItem[0];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/composeStory');
          },
        ),
        title: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text.Text(
                // '${widget.storyTitle}',SSss
                'Chương 1',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: appColors.inkBase),
              ),
              PopupMenuButton(
                  onSelected: (value) {},
                  icon: Icon(Icons.arrow_drop_down),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            value: popupMenuItem[0],
                            child: text.Text('Lưu bản thảo')),
                        PopupMenuItem(
                            value: popupMenuItem[1],
                            child: text.Text('Xem trước')),
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
                    return Container(
                      child: text.Text('model'),
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: GestureDetector(
                onTap: null,
                child: text.Text(
                  'Đăng tải',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: appColors.primaryBase),
                ),
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
