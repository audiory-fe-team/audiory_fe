// import 'package:audioplayers/audioplayers.dart';

import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/layout/reading_bottom_bar.dart';
import 'package:audiory_v0/feat-read/screens/reading/action_button.dart';
import 'package:audiory_v0/feat-read/screens/reading/chapter_audio_player.dart';
import 'package:audiory_v0/feat-read/screens/reading/chapter_drawer.dart';
import 'package:audiory_v0/feat-read/screens/reading/chapter_navigate_button.dart';
import 'package:audiory_v0/feat-read/screens/reading/comment_section.dart';
import 'package:audiory_v0/feat-read/screens/reading/reading_screen_header.dart';
import 'package:audiory_v0/feat-read/widgets/audio_bottom_bar.dart';
import 'package:audiory_v0/models/Paragraph.dart';
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
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReadingScreen extends HookWidget {
  final String chapterId;

  ReadingScreen({super.key, required this.chapterId});

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bgColor = useState(Colors.white);
    final fontSize = useState(18);
    final showCommentByParagraph = useState(true);
    final hideBars = useState(false);

    final curParaIndex = useState<int?>(null);
    final keyList = useState<List<GlobalKey>>([]);
    final scrollController = useScrollController();

    final sequenceState = useStream(player.sequenceStateStream);
    final playingState = useStream(player.playingStream);

    final chapterQuery = useQuery(
      ['chapter', chapterId],
      () => ChapterRepository().fetchChapterDetail(chapterId),
    );

    final storyQuery = useQuery(
        ['story', chapterQuery.data?.storyId],
        () =>
            StoryRepostitory().fetchStoryById(chapterQuery.data?.storyId ?? ''),
        enabled: chapterQuery.data?.storyId != null);

    void changeStyle(
        [Color? newBgColor, int? newFontSize, bool? isShowCommentByParagraph]) {
      bgColor.value = newBgColor ?? bgColor.value;
      fontSize.value = newFontSize ?? fontSize.value;
      showCommentByParagraph.value =
          isShowCommentByParagraph ?? showCommentByParagraph.value;
    }

    useEffect(() {
      final playlist = ConcatenatingAudioSource(
          children: (chapterQuery.data?.paragraphs ?? [])
              .asMap()
              .entries
              .map((entry) {
        int idx = entry.key;
        Paragraph p = entry.value;
        return AudioSource.uri(
            Uri.parse('${dotenv.get("AUDIO_BASE_URL")}${p.audioUrl}'),
            tag: MediaItem(
                id: p.id,
                title: storyQuery.data?.title ?? '',
                artist: 'Chương ${1} - Đoạn ${idx + 1}'));
      }).toList());
      try {
        player.setAudioSource(playlist);
      } catch (error) {
        print(error.toString());
      }
      return () {};
    }, [player, chapterQuery.data]);

    useEffect(() {
      final curIndex = sequenceState.data?.currentIndex;
      if (curIndex == null || playingState.data != true) return;
      curParaIndex.value = curIndex;

      return;
    }, [sequenceState.data?.currentIndex, playingState.data]);

    useEffect(() {
      final currentIndex = curParaIndex.value;
      if (currentIndex == null) return;
      final keyContext = keyList.value[currentIndex].currentContext;
      if (keyContext == null) return;
      Scrollable.ensureVisible(keyContext,
          duration: const Duration(seconds: 1), alignment: 0.5);

      return;
    }, [curParaIndex.value]);

    useEffect(() {
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
    }, []);

    useEffect(() {
      return () => player.dispose();
    }, []);

    return Scaffold(
      backgroundColor: bgColor.value,
      appBar: null,
      body: Skeletonizer(
        enabled: chapterQuery.isFetching,
        child: RefreshIndicator(
            onRefresh: () async {
              chapterQuery.refetch();
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
                          child: Container(
                            key: key,
                            margin: const EdgeInsets.only(bottom: 24),
                            padding: const EdgeInsets.all(8),
                            decoration: (curParaIndex.value == index)
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: appColors.primaryLightest)
                                : const BoxDecoration(),
                            child: Text(para.content ?? '',
                                style: textTheme.bodyLarge?.copyWith(
                                  fontSize: fontSize.value.toDouble(),
                                  fontFamily: GoogleFonts.gelasio().fontFamily,
                                )),
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
      ),
      bottomNavigationBar: hideBars.value
          ? null
          : ReadingBottomBar(
              changeStyle: changeStyle,
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
    );
  }
}
