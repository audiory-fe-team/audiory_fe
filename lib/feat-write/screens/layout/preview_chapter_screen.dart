import 'package:audiory_v0/feat-write/data/models/chapter_version_model/chapter_version_model.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart' as text;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/Chapter.dart';
import '../../../state/state_manager.dart';
import '../../../theme/theme_constants.dart';
import '../../provider/chapter_version_provider.dart';

class PreviewChapterScreen extends ConsumerStatefulWidget {
  final String? storyId;
  final String? chapterId;

  const PreviewChapterScreen({super.key, this.storyId, this.chapterId});

  @override
  ConsumerState<PreviewChapterScreen> createState() =>
      _PreviewChapterScreenState();
}

class _PreviewChapterScreenState extends ConsumerState<PreviewChapterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final theme = Theme.of(context).textTheme;
    final popupMenuItem = ['saveDraft', 'preview'];
    final String selectedValue = popupMenuItem[0];

    // final AsyncValue<Story?>? previewStory = widget.storyId != null
    //     ? ref.watch(storyByIdFutureProvider(widget.storyId as String))
    //     : null;
    final AsyncValue<List<Chapter>?>? chaptersOfStory = widget.storyId != null
        ? ref
            .watch(allChaptersStoryByIdFutureProvider(widget.storyId as String))
        : null;

    // final AsyncValue<ChapterVersion>? chapterVersion =
    //     ref.watch(chapterVersionByIdFutureProvider(widget.storyId as String));
    Widget contentWidget(String id) {
      return SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Center(
            child: text.Text(
              'Tiêu đề (bản thảo)',
              style: theme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: Divider(
              thickness: 1,
              color: appColors.skyBase,
            ),
          ),
          SizedBox(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: QuillEditor.basic(controller: _controller, readOnly: false),
          )),
        ],
      ));
    }

    return chaptersOfStory != null
        ? chaptersOfStory.when(
            data: (data) => Scaffold(
                appBar: CustomAppBar(
                  title: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              // height: 20,
                              child: FormBuilderDropdown(
                                  name: 'chapterVersion',
                                  initialValue: data?[0].id,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  selectedItemBuilder: (context) =>
                                      List.generate(
                                        data!.length,
                                        (index) => text.Text(
                                          'Chương ${data[0].position}',
                                          style: TextStyle(
                                              color: appColors.inkBase),
                                        ),
                                      ),
                                  focusColor: Colors.transparent,
                                  items: List.generate(
                                      data?.length as int,
                                      (index) => DropdownMenuItem(
                                            value: data?[index].id,
                                            child: text.Text(
                                              'Chương ${data?[index].is_draft == true ? '${data?[index].position} (bản thảo)' : data?[index].position}',
                                              style: TextStyle(
                                                  color: appColors.inkBase),
                                            ),
                                          ))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                body: contentWidget(data?[0].current_version_id as String)),
            error: (err, stack) => Scaffold(
                  body: Center(
                    child: text.Text(
                      err.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
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
