// import 'package:audioplayers/audioplayers.dart';

import 'dart:async';

import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/constants/theme_options.dart';
import 'package:audiory_v0/feat-read/screens/comment/comment_screen.dart';
import 'package:audiory_v0/feat-read/screens/detail-story/donate_gift_modal.dart';
import 'package:audiory_v0/feat-read/screens/reading/share_link_sheet.dart';
import 'package:audiory_v0/feat-read/screens/reading/reading_bottom_bar.dart';
import 'package:audiory_v0/feat-read/screens/reading/action_button.dart';
import 'package:audiory_v0/feat-read/screens/reading/chapter_audio_player.dart';
import 'package:audiory_v0/feat-read/screens/reading/chapter_drawer.dart';
import 'package:audiory_v0/feat-read/screens/reading/chapter_navigate_button.dart';
import 'package:audiory_v0/feat-read/screens/reading/reading_screen_header.dart';
import 'package:audiory_v0/feat-read/screens/reading/audio_bottom_bar.dart';
import 'package:audiory_v0/feat-read/screens/reading/reading_top_bar.dart';
import 'package:audiory_v0/feat-read/widgets/richtext_paragraph.dart';
import 'package:audiory_v0/models/paragraph/paragraph_model.dart';
import 'package:audiory_v0/providers/audio_player_provider.dart';
import 'package:audiory_v0/repositories/activities_repository.dart';
import 'package:audiory_v0/repositories/chapter_repository.dart';
import 'package:audiory_v0/repositories/reading_progress_repository.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OnlineReadingScreen extends HookConsumerWidget {
  final String chapterId;
  final String storyId;
  final bool? showComment;
  final int? initialOffset;

  OnlineReadingScreen(
      {super.key,
      required this.chapterId,
      required this.storyId,
      this.initialOffset,
      this.showComment = false});

  var localPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final bgColor = useState(appColors.background);
    final textColor = useState(appColors.inkBase);

    final selectedOption = useState(0);
    final fontSize = useState(18);
    final showCommentByParagraph = useState(true);
    final audioSpeed = useState<double>(1);
    final isKaraoke = useState(true);
    final voiceType = useState(0);

    final haveRead = useState(false);
    final hideBars = useState(false);

    final player = ref.watch(audioPlayerProvider);

    final keyList = useState<List<GlobalKey>>([]);
    final scrollController = useScrollController(
        keys: [chapterId],
        initialScrollOffset: (initialOffset ?? 0).toDouble());
    final playingState = useStream(localPlayer.playingStream);

    final curParaIndex = useState<int?>(null);

    final chapterQuery = useQuery(
      ['chapter', chapterId],
      () => ChapterRepository().fetchChapterDetail(chapterId),
      refetchOnMount: RefetchOnMount.always,
    );

    final storyQuery = useQuery(
      ['story', storyId],
      () => StoryRepostitory().fetchStoryById(storyId),
      refetchOnMount: RefetchOnMount.always,
    );

    void handleOpenCommentPara(String paraId) {
      showModalBottomSheet(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          )),
          useSafeArea: true,
          backgroundColor: appColors.background,
          context: context,
          builder: (context) {
            return Scaffold(
                body: CommentScreen(
              chapterId: chapterId,
              paraId: paraId,
            ));
          });
    }

    // Timer scheduleTimeout([int milliseconds = 10000]) =>
    //     Timer(Duration(milliseconds: milliseconds), () async {
    //       final SharedPreferences prefs = await SharedPreferences.getInstance();
    //       await prefs.remove('timer');
    //       localPlayer.stop();
    //     });

    handleShare() async {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: appColors.background,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          )),
          useSafeArea: true,
          context: context,
          builder: (_) {
            return ShareLinkSheet(
                appRoutePath: '/story/$storyId/chapter/$chapterId');
          });
    }

    setPlayList() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final currentVoice = prefs.getInt('voiceType') ?? 0;

      try {
        final playlist = ConcatenatingAudioSource(
            children: (chapterQuery.data?.paragraphs ?? [])
                .where((element) =>
                    element.audios != null &&
                    element.audios?.isNotEmpty == true)
                .toList()
                .asMap()
                .entries
                .map((entry) {
          int idx = entry.key;
          Paragraph p = entry.value;

          return AudioSource.uri(
              Uri.parse(
                  '${dotenv.get("AUDIO_BASE_URL")}${p.audios?[currentVoice].url}'),
              tag: MediaItem(
                  id: p.id,
                  title: storyQuery.data?.title ?? '',
                  extras: {
                    'position': chapterQuery.data?.position,
                    'storyId': storyId,
                    'chapterId': chapterId,
                  },
                  artist:
                      'Chương ${chapterQuery.data?.position} - Đoạn ${idx + 1}',
                  album: storyQuery.data?.id));
        }).toList());
        localPlayer.setAudioSource(playlist);

        // print(localPlayer.hashCode);
        // print('Set audio sources');

        localPlayer.currentIndexStream.listen((currentParaIndex) {
          if (currentParaIndex == null) return;
          curParaIndex.value = currentParaIndex;
          if (keyList.value.isNotEmpty != true) return;
          final keyContext = keyList.value[currentParaIndex].currentContext;
          if (keyContext == null) return;
          if (isKaraoke.value) {
            Scrollable.ensureVisible(keyContext,
                duration: const Duration(seconds: 1), alignment: 0.5);
          }

          return;
        });
      } catch (error) {
        print('Error set playlist');
      }
    }

    Future syncPreference() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      fontSize.value = prefs.getInt('fontSize') ?? 18;
      isKaraoke.value = prefs.getBool('isKaraoke') ?? true;
      audioSpeed.value = prefs.getDouble('audioSpeed') ?? 1;
      final newVoiceType = prefs.getInt('voiceType') ?? 0;
      if (voiceType.value != newVoiceType) {
        localPlayer.dispose();
        localPlayer = AudioPlayer();
        voiceType.value = newVoiceType;
      }

      showCommentByParagraph.value =
          prefs.getBool('showCommentByParagraph') ?? true;
      final savedOption = prefs.getInt('themeOption') ?? 0;
      selectedOption.value = savedOption;

      bgColor.value =
          THEME_OPTIONS[savedOption]["bgColor"] ?? appColors.background;
      textColor.value =
          THEME_OPTIONS[savedOption]["textColor"] ?? appColors.inkBase;

      final timerValue = prefs.getInt('timer');
      if (timerValue != null) {
        // scheduleTimeout(timerValue);
      }
      localPlayer.setSpeed(audioSpeed.value);
    }

    useEffect(() {
      if (chapterQuery.data?.paragraphs?.isEmpty != false) return;
      if (storyQuery.data == null) return;

      if (localPlayer.sequence != null ||
          localPlayer.sequence?.isEmpty == false) return;
      setPlayList();
    }, [localPlayer, voiceType.value, chapterQuery.data, storyQuery.data]);

    useEffect(() {
      syncPreference();
      return () {
        if (!player.playing) {
          localPlayer.stop();
        }
      };
    }, [chapterId]);

    useEffect(() {
      scrollController.addListener(() {
        if (!scrollController.hasClients) return;
        // Hide bar according to scroll direction
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (hideBars.value) hideBars.value = false;
        }
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (!hideBars.value) hideBars.value = true;
          if (haveRead.value) return;

          final offset = scrollController.offset.floor();
          ReadingProgressRepository.updateProgress(
              storyId: storyId, chapterId: chapterId, readingPosition: offset);

          ActivitiesRepository.sendActivity(
              actionEntity: 'CHAPTER', actionType: 'READ', entityId: chapterId);
          haveRead.value = true;
        }
      });

      final timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
        if (scrollController.hasClients) {
          final offset = scrollController.offset.floor();
          ReadingProgressRepository.updateProgress(
              storyId: storyId, chapterId: chapterId, readingPosition: offset);
        }
      });

      return () {
        timer.cancel();
        // scrollController.dispose();
      };
    }, [chapterId]);

    return Scaffold(
      appBar: hideBars.value ? null : ReadingTopBar(storyId: storyId),
      backgroundColor: bgColor.value,
      body: chapterQuery.isError
          ? const SafeArea(child: Center(child: Text('Không thể tải chương')))
          : SafeArea(
              child: Skeletonizer(
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
                            // num: (storyQuery.data?.chapters ?? [])
                            //     .indexWhere((element) => element.id == chapterId),
                            textColor: textColor.value,
                            chapter: chapterQuery.isFetching
                                ? skeletonChapter
                                : chapterQuery.data ?? skeletonChapter,
                          ),
                          const SizedBox(height: 24),

                          ChapterAudioPlayer(
                            player: localPlayer,
                            onFirstPlay: () {
                              player.stop();
                              ref
                                  .read(audioPlayerProvider.notifier)
                                  .setPlayer(localPlayer);
                            },
                            selectedThemeOption: selectedOption.value,
                          ),

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
                                    localPlayer.seek(null, index: index);
                                  }
                                },
                                onLongPress: () {
                                  curParaIndex.value = index;
                                  handleOpenCommentPara(para.id);
                                },
                                child: SizedBox(
                                  key: key,
                                  width: double.infinity,
                                  child: Stack(children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      padding: const EdgeInsets.only(
                                          bottom: 4, left: 4, right: 4, top: 4),
                                      decoration: (curParaIndex.value == index)
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: THEME_OPTIONS[
                                                      selectedOption.value]
                                                  ['audioBackground'])
                                          : const BoxDecoration(),

                                      // display the paragraph content in rich text
                                      child: (para.richText != null &&
                                              para.richText != "")
                                          ? RichTextParagraph(
                                              paragraphKey: UniqueKey(),
                                              richText: para.richText,
                                              fontSize:
                                                  fontSize.value.toDouble(),
                                              color: THEME_OPTIONS[
                                                      selectedOption.value]
                                                  ['textColor'],
                                            )
                                          : Text(
                                              para.content ?? '',
                                              style: textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontSize: fontSize.value
                                                          .toDouble(),
                                                      fontFamily:
                                                          GoogleFonts.gelasio()
                                                              .fontFamily,
                                                      color: textColor.value),
                                            ),
                                    ),
                                    if (showCommentByParagraph.value == true &&
                                        (para.commentCount ?? 0) > 0)
                                      Positioned(
                                          bottom: -3,
                                          right: 0,
                                          child: IconButton(
                                              style: IconButton.styleFrom(
                                                  elevation: 1,
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  backgroundColor:
                                                      THEME_OPTIONS[selectedOption.value]
                                                          ['audioBackground']),
                                              visualDensity: const VisualDensity(
                                                  horizontal: -4, vertical: -4),
                                              onPressed: () =>
                                                  handleOpenCommentPara(
                                                      para.id),
                                              icon: Icon(Icons.chat_bubble_outline,
                                                  size: 15,
                                                  color: THEME_OPTIONS[selectedOption.value]
                                                      ['textColor']))),
                                    if (showCommentByParagraph.value == true &&
                                        (para.commentCount ?? 0) > 0)
                                      Positioned(
                                          bottom: 9.5,
                                          right: 14,
                                          child: Text(
                                              '${para.commentCount}',
                                              style: textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      color:
                                                          THEME_OPTIONS[
                                                                  selectedOption
                                                                      .value]
                                                              ['textColor'],
                                                      fontFamily: GoogleFonts
                                                              .sourceSansPro()
                                                          .fontFamily,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w600))),
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
                                    onPressed: () {
                                      if (chapterQuery.data?.isVoted != true) {
                                        ActivitiesRepository.sendActivity(
                                            actionEntity: 'CHAPTER',
                                            actionType: 'VOTED',
                                            entityId: chapterId);
                                      } else {
                                        ActivitiesRepository.sendActivity(
                                            actionEntity: 'CHAPTER',
                                            actionType: 'UNVOTED',
                                            entityId: chapterId);
                                      }
                                    }),
                                const SizedBox(width: 12),
                                ActionButton(
                                    title: 'Tặng quà',
                                    iconName: 'gift',
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.7,
                                              child: DonateGiftModal(
                                                onAfterSendGift: () {
                                                  // donatorsQuery.refetch();
                                                },
                                                storyId: storyId,
                                                authorId:
                                                    storyQuery.data?.authorId,
                                              ),
                                            );
                                          });
                                    }),
                                const SizedBox(width: 12),
                                ActionButton(
                                    title: 'Chia sẻ',
                                    iconName: 'share',
                                    onPressed: () {
                                      handleShare();
                                    }),
                              ],
                            ),
                          )),
                          const SizedBox(height: 24),
                          Skeleton.keep(child: SizedBox(child: Builder(
                            builder: (context) {
                              final chapters = storyQuery.data?.chapters;
                              final currentIndex = chapters?.indexWhere(
                                  (element) => element.id == chapterId);
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
                                      GoRouter.of(context).push(
                                          '/story/${storyQuery.data?.id}/chapter/$prevChapterId');
                                    },
                                    disabled:
                                        currentIndex <= 0 || chapters == null,
                                  ),
                                  const SizedBox(width: 12),
                                  ChapterNavigateButton(
                                    next: true,
                                    onPressed: () {
                                      if (chapters == null) return;
                                      if (currentIndex + 1 >= chapters.length)
                                        return;
                                      final nextChapterId =
                                          chapters[currentIndex + 1].id;
                                      GoRouter.of(context).push(
                                          '/story/${storyQuery.data?.id}/chapter/$nextChapterId');
                                    },
                                    disabled: chapters == null ||
                                        currentIndex + 1 >= chapters.length,
                                  ),
                                ],
                              );
                            },
                          ))),
                          // const SizedBox(height: 24),
                          // Builder(builder: (context) {
                          //   final paragraphs = chapterQuery.data?.paragraphs;
                          //   if (paragraphs == null || paragraphs.isEmpty) {
                          //     return const SizedBox();
                          //   }

                          //   return CommentSection(
                          //       chapterId: chapterId,
                          //       paraId: paragraphs[paragraphs.length - 1].id);
                          // }),
                          const SizedBox(
                            height: 56,
                          )
                        ]),
                      ))),
            )),
      bottomNavigationBar: hideBars.value
          ? const SizedBox()
          : ReadingBottomBar(
              onChangeStyle: syncPreference,
              chapterId: chapterId,
              storyId: storyId,
              isVoted: chapterQuery.data?.isVoted ?? false,
            ),
      floatingActionButton: const AudioBottomBar(),
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
