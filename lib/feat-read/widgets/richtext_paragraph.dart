import 'dart:convert';

import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/text.dart' as text;
import 'package:flutter/src/painting/text_style.dart' as quillTextStyle;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class RichTextParagraph extends StatefulWidget {
  final Key paragraphKey;
  final String? richText;

  // styles
  final double? fontSize;
  final Color? color;
  const RichTextParagraph(
      {super.key,
      this.richText = '',
      this.fontSize = 16,
      required this.paragraphKey,
      this.color = const Color(0xFF404446)});

  @override
  State<RichTextParagraph> createState() => _RichTextParagraphState();
}

class _RichTextParagraphState extends State<RichTextParagraph> {
  QuillController itemController = QuillController.basic();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //set controller document by richtext

    String actualBody = '[${widget.richText?.replaceFirst(RegExp(r','), '')}]';
    print(actualBody);
    itemController.document = widget.richText != "" && widget.richText != null
        ? Document.fromJson(jsonDecode(actualBody))
        : Document();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final fontSize = widget.fontSize;
    print(widget.richText);
    // return text.Text(widget.richText != '' && widget.richText != null
    //     ? widget.richText ?? ''
    //     : "trong");
    return QuillProvider(
      key: widget.key,
      configurations: QuillConfigurations(
        controller: itemController,
        sharedConfigurations: QuillSharedConfigurations(
            // locale: Locale('de'),

            // animationConfigurations: QuillAnimationConfigurations.disableAll(),
            ),
      ),
      child: Column(
        children: [
          QuillEditor.basic(
            configurations: QuillEditorConfigurations(
                embedBuilders: kIsWeb
                    ? FlutterQuillEmbeds.editorWebBuilders()
                    : FlutterQuillEmbeds.editorBuilders(
                        imageEmbedConfigurations:
                            QuillEditorImageEmbedConfigurations(
                                imageErrorWidgetBuilder: (context, _, __) {
                          return Image.network(FALLBACK_IMG_URL);
                        }, imageProviderBuilder: (img) {
                          print('img $img');
                          Uint8List bytes = base64Decode(img);

                          return MemoryImage(bytes)
                              as ImageProvider<MemoryImage>;
                        }),
                      ),
                showCursor: false,
                enableInteractiveSelection: false,
                customStyleBuilder: (_) {
                  //define text color here
                  return quillTextStyle.TextStyle(
                      color: widget.color, fontSize: fontSize);
                },
                customStyles: DefaultStyles(
                    paragraph: DefaultTextBlockStyle(
                        quillTextStyle.TextStyle(
                          fontSize: fontSize,
                          fontFamily: GoogleFonts.gelasio().fontFamily,
                        ),
                        const VerticalSpacing(0, 0),
                        const VerticalSpacing(0, 0),
                        const BoxDecoration(color: Colors.amber)),
                    bold: quillTextStyle.TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: appColors.secondaryBase)),
                readOnly: true,
                maxContentWidth: size.width - 32),
          )
        ],
      ),
    );
  }
}
