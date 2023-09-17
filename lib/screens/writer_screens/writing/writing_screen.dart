// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:audiory_v0/widgets/buttons/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/theme_constants.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({super.key});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final _controller = QuillController.basic();

  QuillController? _controllerRead;
  late String _textContent = '_blank';
  List<dynamic>? json = [];

  Future<void> readJson() async {
    // final String response = await rootBundle.loadString(
    //     'D:/K16A/SU23/CAPSTONE/Audiory_UI/audiory_fe/assets/mock_data/sample_data_nomedia.json');
    // final data = await jsonDecode(response);
    // print(data);
    final mock_json = jsonDecode(await rootBundle
        .loadString('assets/mock_data/sample_data_nomedia.json'));
    setState(() {
      // json = data as List<dynamic>;
      json = mock_json;
    });
    print('in');
    print(json?.isEmpty);
  }

  void getRichTextData(delta) {
    print(delta);
    setState(() {
      json = _controller.document.toDelta().toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
            margin: const EdgeInsets.all(12),
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
          Container(
            margin: const EdgeInsets.all(12),
            alignment: Alignment.bottomRight,
            child: AppIconButton(
              title: 'Back',
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: appColors.skyBase),
              icon: null,
              iconPosition: null,
              onPressed: () => context.go('/'),
              color: appColors.skyLight,
              bgColor: appColors.inkBase,
            ),
          ),
          QuillToolbar.basic(
              controller: _controller, showAlignmentButtons: false),
          QuillEditor.basic(controller: _controller, readOnly: false),
          Container(
            margin: const EdgeInsets.all(12),
            alignment: Alignment.bottomRight,
            child: AppIconButton(
              title: 'Lấy json từ file',
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: appColors.skyBase),
              icon: null,
              iconPosition: null,
              onPressed: () => readJson(),
              color: appColors.skyLight,
              bgColor: appColors.inkBase,
            ),
          ),
          Expanded(
              child: QuillEditor.basic(
                  controller: QuillController(
                      document: json!.isNotEmpty
                          ? Document.fromJson(json as List<dynamic>)
                          : Document()
                        ..insert(0, 'Empty'),
                      selection: const TextSelection.collapsed(offset: 0)),
                  readOnly: true)),
        ]),
      ),
    );
  }
}
