// import 'package:audioplayers/audioplayers.dart';

import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/screens/reading/reading_bottom_bar.dart';
import 'package:audiory_v0/feat-read/screens/reading/action_button.dart';
import 'package:audiory_v0/feat-read/screens/reading/chapter_navigate_button.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/providers/chapter_database.dart';
import 'package:audiory_v0/providers/story_database.dart';
import 'package:audiory_v0/theme/theme_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OfflineReadingScreen extends StatefulWidget {
  final String chapterId;
  final bool? showComment;

  OfflineReadingScreen({
    Key? key,
    required this.chapterId,
    this.showComment = false,
  }) : super(key: key);

  @override
  _OfflineReadingScreenState createState() => _OfflineReadingScreenState();
}

class _OfflineReadingScreenState extends State<OfflineReadingScreen> {
  final ChapterDatabase chapterDb = ChapterDatabase();
  final StoryDatabase storyDb = StoryDatabase();

  late ScrollController scrollController;
  late ValueNotifier<Color> bgColor;
  late ValueNotifier<int> fontSize;
  late ValueNotifier<bool> showCommentByParagraph;
  late ValueNotifier<bool> hideBars;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    // bgColor = ValueNotifier<Color>(Colors.white);
    fontSize = ValueNotifier<int>(18);
    showCommentByParagraph = ValueNotifier<bool>(true);
    hideBars = ValueNotifier<bool>(false);

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (hideBars.value) hideBars.value = false;
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!hideBars.value) hideBars.value = true;
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    bgColor.dispose();
    fontSize.dispose();
    showCommentByParagraph.dispose();
    hideBars.dispose();
    super.dispose();
  }

  void changeStyle(
      [Color? newBgColor, int? newFontSize, bool? isShowCommentByParagraph]) {
    bgColor.value = newBgColor ?? bgColor.value;
    fontSize.value = newFontSize ?? fontSize.value;
    showCommentByParagraph.value =
        isShowCommentByParagraph ?? showCommentByParagraph.value;
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: bgColor.value,
      body: SafeArea(
        child: Skeletonizer(
          enabled: false,
          child: RefreshIndicator(
            onRefresh: () async {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: scrollController,
                  child: FutureBuilder(
                      future: chapterDb.getChapter(widget.chapterId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('loading...');
                        }

                        return Column(children: [
                          const SizedBox(height: 24),
                          ...(snapshot.data?.paragraphs ?? [])
                              .asMap()
                              .entries
                              .map((entry) {
                            final para = entry.value;

                            return SizedBox(
                              width: double.infinity,
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 24, left: 4, right: 4, top: 4),
                                  child: Text(para.content ?? '',
                                      style: textTheme.bodyLarge?.copyWith(
                                        fontSize: fontSize.value.toDouble(),
                                        fontFamily:
                                            GoogleFonts.gelasio().fontFamily,
                                      ))),
                            );
                          }).toList()
                        ]);
                      })),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ReadingBottomBar(
        changeStyle: changeStyle,
        chapterId: widget.chapterId,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      resizeToAvoidBottomInset: true,
    );
  }
}
