// import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/layout/bottom_bar.dart';
import 'package:audiory_v0/feat-read/models/position_audio.dart';
import 'package:audiory_v0/feat-read/widgets/audio_bottom_bar.dart';
import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/models/Paragraph.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/repositories/chapter_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';
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
    }, [player, chapterQuery.data]);

    useEffect(() {
      final curIndex = sequenceState.data?.currentIndex;
      if (curIndex == null || playingState.data != true) return;
      curParaIndex.value = curIndex;
    }, [sequenceState.data?.currentIndex, playingState.data]);

    useEffect(() {
      final currentIndex = curParaIndex.value;
      if (currentIndex == null) return;
      final keyContext = keyList.value[currentIndex].currentContext;
      if (keyContext == null) return;
      Scrollable.ensureVisible(keyContext,
          duration: const Duration(seconds: 1), alignment: 0.5);
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
            child: SafeArea(
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
                                      fontFamily:
                                          GoogleFonts.gelasio().fontFamily,
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
                                    GoRouter.of(context).go(
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
                      ]),
                    ))),
          )),
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

class ChapterDrawer extends HookWidget {
  final Story? story;
  final String currentChapterId;
  const ChapterDrawer(
      {super.key, required this.story, required this.currentChapterId});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return SafeArea(
        child: Drawer(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
          const SizedBox(height: 12),
          Expanded(
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  GoRouter.of(context).push('/story/${story?.id ?? ''}');
                },
                child: Container(
                  width: 70,
                  height: 97,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: NetworkImage(story?.coverUrl ?? FALLBACK_IMG_URL),
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
            const SizedBox(width: 8),
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    story?.title ?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                    softWrap: true,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    story?.author?.fullName ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                    softWrap: true,
                    maxLines: 2,
                  ),
                ]),
          ])),
          Divider(),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.format_list_bulleted_rounded,
              size: 24,
              color: appColors.secondaryBase,
            ),
            Text(
              'Danh sách chương',
              style: Theme.of(context).textTheme.titleLarge,
              softWrap: true,
              maxLines: 2,
            ),
          ]),
          const SizedBox(height: 16),
          ...(story?.chapters ?? []).map((chapter) {
            return Container(
                margin: EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                    color: chapter.id == currentChapterId
                        ? appColors.primaryLight
                        : appColors.skyLightest,
                    borderRadius: BorderRadius.circular(8)),
                width: double.infinity,
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          GoRouter.of(context).go(
                              '/story/${story?.id ?? ''}/chapter/${chapter.id}');
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Text(chapter.title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: chapter.id == currentChapterId
                                          ? Colors.white
                                          : appColors.inkBase,
                                      fontSize: 16,
                                      fontFamily: GoogleFonts.sourceSansPro()
                                          .fontFamily,
                                      fontWeight: FontWeight.w400)),
                        ))));
          }).toList()
        ])));
  }
}

class AudioControl extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const AudioControl({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Row(mainAxisSize: MainAxisSize.min, children: [
      IconButton(
          onPressed: () {
            audioPlayer.seekToPrevious();
          },
          icon: Icon(
            Icons.skip_previous_rounded,
            size: 24,
            color: appColors.inkBase,
          )),
      IconButton(
          onPressed: () {
            audioPlayer.seek(
                Duration(seconds: max(audioPlayer.position.inSeconds - 10, 0)));
          },
          icon: Icon(
            Icons.replay_10,
            size: 24,
            color: appColors.inkBase,
          )),
      StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: ((context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (!(playing ?? false)) {
              return FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(appColors.primaryBase),
                      shape: const MaterialStatePropertyAll(CircleBorder()),
                      elevation: const MaterialStatePropertyAll(1)),
                  onPressed: audioPlayer.play,
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    size: 24,
                    color: Colors.white,
                  ));
            } else if (processingState != ProcessingState.completed) {
              return FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(appColors.primaryBase),
                      shape: const MaterialStatePropertyAll(CircleBorder()),
                      elevation: const MaterialStatePropertyAll(1)),
                  onPressed: audioPlayer.pause,
                  child: const Icon(
                    Icons.pause_rounded,
                    size: 24,
                    color: Colors.white,
                  ));
            }

            return FilledButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(appColors.primaryBase),
                    shape: const MaterialStatePropertyAll(CircleBorder()),
                    elevation: const MaterialStatePropertyAll(1)),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  size: 24,
                  color: Colors.white,
                ),
                onPressed: () {
                  audioPlayer.seek(Duration.zero);
                  audioPlayer.play();
                });
          })),
      IconButton(
          onPressed: () {
            audioPlayer.seek(Duration(
                seconds: min(audioPlayer.position.inSeconds + 10,
                    audioPlayer.duration?.inSeconds ?? 0)));
          },
          icon: Icon(
            Icons.forward_10,
            size: 24,
            color: appColors.inkBase,
          )),
      IconButton(
          onPressed: () {
            audioPlayer.seekToNext();
          },
          icon: Icon(
            Icons.skip_next_rounded,
            size: 24,
            color: appColors.inkBase,
          )),
    ]);
  }
}

class AudioMedia extends StatelessWidget {
  final String title;
  final String artist;

  const AudioMedia({super.key, required this.title, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(title, style: Theme.of(context).textTheme.titleMedium),
      Text(artist, style: Theme.of(context).textTheme.titleSmall),
    ]);
  }
}

class ChapterAudioPlayer extends HookWidget {
  final Chapter? chapter;
  final AudioPlayer player;
  final Function? onPlayNextPara;
  const ChapterAudioPlayer(
      {super.key,
      required this.chapter,
      this.onPlayNextPara,
      required this.player});

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final positionAudioStream = useStream(
        Rx.combineLatest3<Duration, Duration, Duration?, PositionAudio>(
            player.positionStream,
            player.bufferedPositionStream,
            player.durationStream,
            (position, bufferedPosition, duration) =>
                PositionAudio(position, bufferedPosition, duration)));
    final position = positionAudioStream.data;
    // final sequenceStateStream = useStream(player.sequenceStateStream);
    // final totalDuration = sequenceStateStream.data?.sequence.fold(Duration.zero,
    //     (previous, element) => previous + (element.duration ?? Duration.zero));
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: appColors?.skyLightest,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Text(
              'Nghe audio',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            SizedBox(
                width: double.infinity,
                child: Text('Cung cấp bởi FPT AI',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontStyle: FontStyle.italic))),
            Skeleton.keep(
                child: ProgressBar(
              barHeight: 4,
              baseBarColor: Colors.white,
              bufferedBarColor: appColors?.primaryLightest,
              progressBarColor: appColors?.primaryBase,
              thumbColor: appColors?.primaryBase,
              thumbRadius: 5,
              timeLabelTextStyle: Theme.of(context).textTheme.labelLarge,
              progress: position?.position ?? Duration.zero,
              buffered: position?.bufferedPosition ?? Duration.zero,
              total: position?.duration ?? Duration.zero,
              onSeek: player.seek,
            )),
            // StreamBuilder<SequenceState?>(
            //     stream: player.sequenceStateStream,
            //     builder: (context, snapshot) {
            //       final state = snapshot.data;
            //       if (state?.sequence.isEmpty ?? true) {
            //         return const SizedBox();
            //       }
            //       final metadata = state!.currentSource!.tag as MediaItem;
            //       return AudioMedia(
            //           title: metadata.title, artist: metadata.artist ?? '');
            //     }),
            AudioControl(audioPlayer: player)
          ],
        ));
  }
}

class SettingModel extends HookWidget {
  final Function([Color? bgColor, int? fontSize, bool? showCommentByParagraph])
      changeStyle;

  const SettingModel({super.key, required this.changeStyle});

  @override
  Widget build(BuildContext context) {
    final selectedOption = useState(0);
    final fontSize = useState(16);
    final showCommentByParagraph = useState(false);

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final List<Color> DEFAULT_OPTION = [
      appColors.skyLightest,
      appColors.inkBase,
      appColors.primaryLightest,
    ];

    final sizeController = useTextEditingController(text: "16");

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Cài đặt',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            //Note: Backgronud color
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    child: Text(
                      'Màu trang',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                const SizedBox(height: 12),
                //Note:Background colors option
                Row(
                  children: [
                    ...DEFAULT_OPTION.asMap().entries.map((entry) {
                      int idx = entry.key;
                      Color val = entry.value;
                      return GestureDetector(
                          onTap: () {
                            selectedOption.value = idx;
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: val,
                                    shape: BoxShape.circle,
                                    border: selectedOption.value == idx
                                        ? Border.all(
                                            color: appColors.primaryBase,
                                            width: 2,
                                            strokeAlign:
                                                BorderSide.strokeAlignOutside)
                                        : null,
                                  ))));
                    }).toList(),
                    GestureDetector(
                        onTap: () {},
                        child: Stack(
                          children: [
                            Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: appColors.primaryBase,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                  'assets/icons/plus.svg',
                                  color: Colors.white,
                                  width: 16,
                                  height: 16,
                                ))),
                          ],
                        )),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            //NOTE: Font size
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    child: Text(
                      'Cỡ chữ',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: appColors.skyLighter),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Expanded(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                int curVal = int.parse(sizeController.text);
                                if (curVal <= 10) return;
                                sizeController.text = (curVal - 1).toString();
                              },
                              child: SvgPicture.asset(
                                'assets/icons/remove.svg',
                                width: 16,
                                height: 16,
                                color: appColors.skyBase,
                              )),
                          const SizedBox(width: 4),
                          Container(
                            width: 30,
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.bodyMedium,
                              controller: sizeController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                              onTap: () {
                                int curVal = int.parse(sizeController.text);
                                if (curVal >= 32) return;
                                sizeController.text = (curVal + 1).toString();
                              },
                              child: SvgPicture.asset(
                                'assets/icons/plus.svg',
                                width: 16,
                                height: 16,
                                color: appColors.primaryBase,
                              )),
                        ],
                      ))),
                )
              ],
            ),
            const SizedBox(height: 16),
            //NOTE: Other settings
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    child: Text(
                      'Cài đặt khác',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Hiện bình luận theo đoạn',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: showCommentByParagraph.value,
                          onChanged: (value) {
                            showCommentByParagraph.value = value ?? false;
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          fillColor: MaterialStatePropertyAll(
                            appColors.primaryBase,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            const SizedBox(height: 16),
            Row(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          side: BorderSide(
                            color: appColors.primaryBase,
                            width: 1,
                          )),
                      child: Text(
                        'Đặt lại',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: appColors.primaryBase),
                      ))),
              const SizedBox(width: 20),
              Expanded(
                  child: FilledButton(
                      onPressed: () {
                        changeStyle(DEFAULT_OPTION[selectedOption.value],
                            fontSize.value, showCommentByParagraph.value);
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: appColors.primaryBase,
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Text(
                        'Áp dụng',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ))),
            ])
          ],
        ),
      ),
    );
  }
}

class ChapterNavigateButton extends StatelessWidget {
  final bool next;
  final bool disabled;
  final Function onPressed;
  const ChapterNavigateButton(
      {super.key,
      this.next = false,
      required this.onPressed,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Expanded(
        child: FilledButton(
      onPressed: () {
        onPressed();
      },
      style: FilledButton.styleFrom(
          backgroundColor:
              disabled ? appColors.skyLighter : appColors.primaryBase,
          minimumSize: Size.zero, // Set this
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          alignment: Alignment.center // and this
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          !next
              ? SvgPicture.asset(
                  'assets/icons/left-arrow.svg',
                  width: 12,
                  height: 12,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            width: 4,
          ),
          Text(
            next ? 'Chương sau' : 'Chương trước',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(
            width: 4,
          ),
          next
              ? SvgPicture.asset(
                  'assets/icons/right-arrow.svg',
                  width: 12,
                  height: 12,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ],
      ),
    ));
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final String iconName;
  final Function onPressed;

  const ActionButton(
      {super.key,
      required this.title,
      required this.iconName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
          backgroundColor: appColors.primaryLightest,
          minimumSize: Size.zero, // Set this
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          alignment: Alignment.center // and this
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/$iconName.svg',
            width: 12,
            height: 12,
            color: appColors.primaryBase,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600, color: appColors.primaryBase),
          )
        ],
      ),
    );
  }
}

class ReadingScreenHeader extends StatelessWidget {
  final int num;
  final Chapter chapter;

  const ReadingScreenHeader({
    super.key,
    required this.num,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Column(children: [
      Text('Chương ' + (num + 1).toString() + ":",
          style: Theme.of(context).textTheme.bodyLarge),
      Text(chapter.title,
          style: Theme.of(context).textTheme.bodyLarge, softWrap: true),
      const SizedBox(height: 12),
      Container(
        height: 24,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/eye.svg',
                width: 14,
                height: 14,
                color: appColors.primaryBase,
              ),
              const SizedBox(width: 4),
              Text(
                chapter.readCount.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
          const SizedBox(width: 24),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/heart.svg',
                width: 14,
                height: 14,
                color: appColors.primaryBase,
              ),
              const SizedBox(width: 4),
              Text(
                chapter.voteCount.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
          const SizedBox(width: 24),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/message-box-circle.svg',
                width: 14,
                height: 14,
                color: appColors.primaryBase,
              ),
              const SizedBox(width: 4),
              Text(
                chapter.commentCount.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
        ]),
      )
    ]);
  }
}
