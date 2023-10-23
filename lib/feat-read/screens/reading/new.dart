// import 'package:audioplayers/audioplayers.dart';

import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-manage-profile/screens/profile_settings_screen.dart';
import 'package:audiory_v0/feat-read/screens/comment/comment_screen.dart';
import 'package:audiory_v0/feat-read/screens/reading/reading_bottom_bar.dart';
import 'package:audiory_v0/feat-read/screens/reading/action_button.dart';
import 'package:audiory_v0/feat-read/screens/reading/chapter_audio_player.dart';
import 'package:audiory_v0/feat-read/screens/reading/chapter_drawer.dart';
import 'package:audiory_v0/feat-read/screens/reading/chapter_navigate_button.dart';
import 'package:audiory_v0/feat-read/screens/reading/comment_section.dart';
import 'package:audiory_v0/feat-read/screens/reading/reading_screen_header.dart';
import 'package:audiory_v0/feat-read/screens/reading/audio_bottom_bar.dart';
import 'package:audiory_v0/models/paragraph/paragraph_model.dart';
import 'package:audiory_v0/providers/audio_player_provider.dart';
import 'package:audiory_v0/repositories/chapter_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OnlineReadingScreen extends ConsumerStatefulWidget {
  final String chapterId;
  final bool? showComment;
  const OnlineReadingScreen(
      {required this.chapterId, this.showComment, super.key});

  @override
  ConsumerState<OnlineReadingScreen> createState() =>
      _OnlineReadingScreenState();
}

class _OnlineReadingScreenState extends ConsumerState<OnlineReadingScreen> {
  Color? bgColor;
  int fontSize = 18;
  bool showCommentByParagraph = true;
  bool hideBars = false;
  Future? chapterFuture;
  Future? storyFuture;

  void initState() {
    super.initState();
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    bgColor = appColors?.background;
    chapterFuture = ChapterRepository().fetchChapterDetail(widget.chapterId);
    storyFuture = StoryRepostitory().fetchStoryById(widget.chapterId);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final audioPlayer = ref.watch(audioPlayerProvider);
    final curParaIndex = ref.watch(audioCurrentIndexProvider);
    final scrollController = ScrollController();

    final keyList = <List<GlobalKey>>([]);

    // final chapterQuery = useQuery(
    //   ['chapter', chapterId],
    //   () => ChapterRepository().fetchChapterDetail(chapterId),
    // );

    // final storyQuery = useQuery(
    //     ['story', chapterQuery.data?.storyId],
    //     () =>
    //         StoryRepostitory().fetchStoryById(chapterQuery.data?.storyId ?? ''),
    //     enabled: chapterQuery.data?.storyId != null);

    void changeStyle(
        [Color? newBgColor, int? newFontSize, bool? isShowCommentByParagraph]) {
          setState(() {
              bgColor = newBgColor ?? bgColor;
         fontSize = newFontSize ?? fontSize;
          showCommentByParagraph =
          isShowCommentByParagraph ?? showCommentByParagraph;
          });
    
    }

    void handleOpenCommentPara(String paraId) {
      showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          )),
          useSafeArea: true,
          backgroundColor: appColors?.background,
          context: context,
          builder: (context) {
            return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: CommentScreen(
                  chapterId: widget.chapterId,
                  paraId: paraId,
                ));
          });
    }

    // useEffect(() {
    //   final playlist = ConcatenatingAudioSource(
    //       children: (chapterQuery.data?.paragraphs ?? [])
    //           .asMap()
    //           .entries
    //           .map((entry) {
    //     int idx = entry.key;
    //     Paragraph p = entry.value;
    //     return AudioSource.uri(
    //         Uri.parse('${dotenv.get("AUDIO_BASE_URL")}${p.audioUrl}'),
    //         tag: MediaItem(
    //             id: p.id,
    //             title: storyQuery.data?.title ?? '',
    //             artist: 'Chương ${1} - Đoạn ${idx + 1}'));
    //   }).toList());
    //   try {
    //     player.setAudioSource(playlist);
    //   } catch (error) {
    //     print(error.toString());
    //   }
    //   return () {};
    // }, [player, chapterQuery.data]);

    // useEffect(() {
    //   final curIndex = sequenceState.data?.currentIndex;
    //   if (curIndex == null || playingState.data != true) return;
    //   curParaIndex.value = curIndex;

    //   return;
    // }, [sequenceState.data?.currentIndex, playingState.data]);

    // useEffect(() {
    //   final currentIndex = curParaIndex.value;
    //   if (currentIndex == null) return;
    //   final keyContext = keyList.value[currentIndex].currentContext;
    //   if (keyContext == null) return;
    //   Scrollable.ensureVisible(keyContext,
    //       duration: const Duration(seconds: 1), alignment: 0.5);

    //   return;
    // }, [curParaIndex.value]);

    // useEffect(() {
    //   scrollController.addListener(() {
    //     if (scrollController.position.userScrollDirection ==
    //         ScrollDirection.forward) {
    //       if (hideBars.value) hideBars.value = false;
    //     }
    //     if (scrollController.position.userScrollDirection ==
    //         ScrollDirection.reverse) {
    //       if (!hideBars.value) hideBars.value = true;
    //     }
    //   });
    // }, []);

    // useEffect(() {
    //   if (showComment == true) {
    //     showModalBottomSheet(
    //         isScrollControlled: true,
    //         context: context,
    //         builder: (context) {
    //           return CommentChapterScreen(chapterId: chapterId);
    //         });
    //   }
    // }, []);

  

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: FutureBuilder(future: chapterFuture, builder:(context, snapshot) {
            return Skeletonizer(
        child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                chapterFuture =  ChapterRepository().fetchChapterDetail(widget.chapterId);
              });
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: scrollController,
                  child: Column(children: [
                    const SizedBox(height: 24),
                    ReadingScreenHeader(
                      num: (storyQuery.data?.chapters ?? [])
                          .indexWhere((element) => element.id == chapterId),
                      chapter: chapterQuery.isFetching
                          ? skeletonChapter
                          : chapterQuery.data ?? skeletonChapter,
                    ),
                    const SizedBox(height: 24),
                    StreamBuilder(
                        stream: player.sequenceStream,
                        builder: ((context, snapshot) {
                          final a = snapshot.data;
                          if (a == null || a.isEmpty) {
                            return const SizedBox();
                          }
                          return ChapterAudioPlayer(
                            chapter: chapterQuery.data,
                            player: player,
                          );
                        })),
                    const SizedBox(height: 24),
                    ...((chapterQuery.isFetching
                                    ? skeletonChapter
                                    : chapterQuery.data)
                                ?.paragraphs ??
                            [])
                        .asMap()
                        .entries
                        .map((entry) {
                      final para = entry.value;
                      final index = entry.key;
                      final key = GlobalKey();
                      if (index == 0) {
                        keyList.value = [key];
                      } else {
                        keyList.value.add(key);
                      }
                      return GestureDetector(
                          onTap: () {
                            if (playingState.data == true) {
                              player.seek(null, index: index);
                            }
                          },
                          child: SizedBox(
                            key: key,
                            width: double.infinity,
                            child: Stack(children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.only(
                                      bottom: 4, left: 4, right: 4, top: 4),
                                  decoration: (curParaIndex.value == index)
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: appColors.primaryLightest)
                                      : const BoxDecoration(),
                                  child: Text(para.content ?? '',
                                      style: textTheme.bodyLarge?.copyWith(
                                        fontSize: fontSize.value.toDouble(),
                                        fontFamily:
                                            GoogleFonts.gelasio().fontFamily,
                                      ))),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: IconButton(
                                      visualDensity: const VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      onPressed: () =>
                                          handleOpenCommentPara(para.id),
                                      icon: Icon(Icons.mode_comment_outlined,
                                          size: 16,
                                          color: appColors.primaryBase))),
                              Positioned(
                                  bottom: 17,
                                  right: 18,
                                  child: Text('${para.commentCount}',
                                      style: textTheme.labelMedium?.copyWith(
                                          color: appColors.primaryBase,
                                          fontFamily:
                                              GoogleFonts.sourceSansPro()
                                                  .fontFamily,
                                          fontWeight: FontWeight.w600))),
                            ]),
                          ));
                    }).toList(),
                    Skeleton.keep(
                        child: SizedBox(
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ActionButton(
                              title: 'Bình chọn',
                              iconName: 'heart',
                              onPressed: () {}),
                          const SizedBox(width: 12),
                          ActionButton(
                              title: 'Tặng quà',
                              iconName: 'gift',
                              onPressed: () {}),
                          const SizedBox(width: 12),
                          ActionButton(
                              title: 'Chia sẻ',
                              iconName: 'share',
                              onPressed: () {}),
                        ],
                      ),
                    )),
                    const SizedBox(height: 24),
                    Skeleton.keep(child: SizedBox(child: Builder(
                      builder: (context) {
                        final chapters = storyQuery.data?.chapters;
                        final currentIndex = chapters
                            ?.indexWhere((element) => element.id == chapterId);
                        if (currentIndex == null) return const SizedBox();

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ChapterNavigateButton(
                              onPressed: () {
                                if (chapters == null) return;
                                if (currentIndex <= 0) return;
                                final prevChapterId =
                                    chapters[currentIndex - 1].id;
                                GoRouter.of(context).go(
                                    '/story/${storyQuery.data?.id}/chapter/$prevChapterId');
                              },
                              disabled: currentIndex <= 0 || chapters == null,
                            ),
                            const SizedBox(width: 12),
                            ChapterNavigateButton(
                              next: true,
                              onPressed: () {
                                if (chapters == null) return;
                                if (currentIndex + 1 >= chapters.length) return;
                                final nextChapterId =
                                    chapters[currentIndex + 1].id;
                                GoRouter.of(context).go(
                                    '/story/${storyQuery.data?.id}/chapter/$nextChapterId');
                              },
                              disabled: chapters == null ||
                                  currentIndex + 1 >= chapters.length,
                            ),
                          ],
                        );
                      },
                    ))),
                    const SizedBox(height: 24),
                    Builder(builder: (context) {
                      final paragraphs = chapterQuery.data?.paragraphs;
                      if (paragraphs == null || paragraphs.isEmpty) {
                        return const SizedBox();
                      }

                      return CommentSection(
                          chapterId: chapterId,
                          paraId: paragraphs[paragraphs.length - 1].id);
                    }),
                    const SizedBox(
                      height: 56,
                    )
                  ]),
                ))),
      
          }),
      bottomNavigationBar: ReadingBottomBar(
        changeStyle: changeStyle,
        chapterId: chapterId,
      ),
      floatingActionButton: AudioBottomBar(
        player: player,
        storyId: chapterQuery.data?.storyId,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      drawer: ChapterDrawer(
        currentChapterId: chapterId,
        story: storyQuery.data,
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
