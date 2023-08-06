import 'dart:convert';

import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../theme/theme_constants.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({super.key});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final _controller = QuillController.basic();
  late String _textContent = '_blank';
  late Object json;

  void getRichTextData(delta) {
    setState(() {
      json = _controller.document.toDelta().toJson();
    });
    print(delta);
    print('json');
    print(json);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
            margin: EdgeInsets.all(12),
            alignment: Alignment.bottomRight,
            child: AppIconButton(
              title: 'Tạo mới',
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: appColors.skyBase),
              icon: null,
              iconPosition: null,
              onPressed: () =>
                  getRichTextData(_controller.document.toDelta().toJson()),
              color: appColors.skyLight,
              bgColor: appColors.inkBase,
            ),
          ),
          QuillToolbar.basic(
              controller: _controller, showAlignmentButtons: false),
          QuillEditor.basic(controller: _controller, readOnly: false),
          // QuillEditor.basic(
          //     controller: QuillController(
          //         document: Document.fromJson(json),
          //         selection: TextSelection.collapsed(offset: 0)),
          //     readOnly: true)
        ]),
      ),
    );
  }
}
