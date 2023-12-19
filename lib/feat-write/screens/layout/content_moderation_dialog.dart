import 'package:audiory_v0/feat-read/widgets/richtext_paragraph.dart';
import 'package:audiory_v0/models/paragraph/paragraph_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/src/painting/text_style.dart' as quillTextStyle;
import 'package:flutter/src/widgets/text.dart' as text;

class ContentModerationDialog extends StatefulWidget {
  final List<Paragraph>? paragraphs;
  const ContentModerationDialog({super.key, required this.paragraphs});

  @override
  State<ContentModerationDialog> createState() =>
      _ContentModerationDialogState();
}

class _ContentModerationDialogState extends State<ContentModerationDialog> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final _detailChapterController = QuillController.basic();

    final paragraphs = widget.paragraphs ?? [];
    return Container(
      height: size.height,
      child: Scaffold(
        appBar: CustomAppBar(title: const Text('Chi tiết vi phạm')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: appColors.skyLighter,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    'Đoạn văn chứa hình ảnh hoặc nội dung bị vi phạm',
                    style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  width: size.width - 32,
                  height: size.height,
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ListView.builder(
                      itemCount: paragraphs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Paragraph para = paragraphs[index];
                        bool isMature =
                            para.contentModeration[0]?.isMature == true;
                        bool isReactionary =
                            para.contentModeration[0]?.isReactionary == true;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: isMature || isReactionary
                                  ? appColors.secondaryLight
                                  : Colors.transparent),
                          child: Column(
                            children: [
                              Column(
                                children: paragraphs.asMap().entries.map((e) {
                                  return RichTextParagraph(
                                    paragraphKey: UniqueKey(),
                                    richText: e.value.richText,
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
            width: size.width - 32,
            child: AppIconButton(
              title: 'Tôi đã hiểu',
              textStyle:
                  textTheme.bodySmall?.copyWith(color: appColors.skyLightest),
              onPressed: () {
                context.pop();
              },
            )),
      ),
    );
  }
}
