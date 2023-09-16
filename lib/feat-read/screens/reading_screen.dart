// import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/layout/bottom_bar.dart';
import 'package:audiory_v0/feat-read/layout/reading_top_bar.dart';
import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/models/Paragraph.dart';
import 'package:audiory_v0/repositories/chapter_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fquery/fquery.dart';
import 'package:hidable/hidable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReadingScreen extends HookWidget {
  final String? chapterId;

  ReadingScreen({super.key, this.chapterId});

  List<Widget> chapterContent(
      {List<Paragraph>? paragraphs,
      int fontSize = 16,
      required AppColors appColors,
      required TextTheme textTheme}) {
    return (paragraphs ?? [])
        .map((para) => Column(children: [
              Text(para.content,
                  style: textTheme.bodyLarge!
                      .copyWith(fontSize: fontSize.toDouble())),
              const SizedBox(height: 24)
            ]))
        .toList();
  }

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final bgColor = useState(Colors.white);
    final fontSize = useState(16);
    final showCommentByParagraph = useState(true);

    final scrollController = useScrollController();

    final chapterQuery = useQuery(['chapter', chapterId],
        () => ChapterRepository().fetchChapterDetail(chapterId),
        enabled: chapterId != null);
    final storyQuery = useQuery(
        ['story', chapterQuery.data?.story_id],
        () => StoryRepostitory()
            .fetchStoryById(chapterQuery.data?.story_id ?? ''),
        enabled: chapterQuery.data?.story_id != null);

    void changeStyle(
        [Color? newBgColor, int? newFontSize, bool? isShowCommentByParagraph]) {
      bgColor.value = newBgColor ?? bgColor.value;
      fontSize.value = newFontSize ?? fontSize.value;
      showCommentByParagraph.value =
          isShowCommentByParagraph ?? showCommentByParagraph.value;
    }

    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    useEffect(() {
      final playlist = ConcatenatingAudioSource(
          children: (chapterQuery.data?.paragraphs ?? [])
              .asMap()
              .entries
              .map((entry) {
        int idx = entry.key;
        Paragraph p = entry.value;
        return AudioSource.uri(
            Uri.parse('${dotenv.get("AUDIO_BASE_URL")}${p.audio_url}'),
            tag: MediaItem(
                id: p.id,
                title: storyQuery.data?.title ?? '',
                artist: 'Chương ${1} - Đoạn ${idx + 1}'));
      }).toList());
      try {
        // player.setLoopMode(LoopMode.off);
        player.setAudioSource(playlist);
      } catch (error) {
        print(error.toString());
      }
    }, [player, chapterQuery.data]);

    useEffect(() {
      print(player.sequence?.map((e) => e.duration).toList().toString());
    }, [player]);

    useEffect(() {
      return () => player.dispose();
    }, []);

    return Scaffold(
      backgroundColor: bgColor.value,
      appBar: ReadingTopBar(
        storyName: storyQuery.data?.title,
        storyId: chapterQuery.data?.story_id,
      ),
      body: Skeletonizer(
        enabled: chapterQuery.isFetching,
        child: RefreshIndicator(
            onRefresh: () async {
              chapterQuery.refetch();
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  controller: scrollController,
                  children: [
                    const SizedBox(height: 24),
                    ReadingScreenHeader(
                      num: (storyQuery.data?.chapters ?? [])
                          .indexWhere((element) => element.id == chapterId),
                      chapter: chapterQuery.isFetching
                          ? skeletonChapter
                          : chapterQuery.data ?? skeletonChapter,
                    ),
                    const SizedBox(height: 24),
                    ChapterAudioPlayer(
                      chapter: chapterQuery.data,
                      player: player,
                    ),
                    const SizedBox(height: 24),
                    ...chapterContent(
                        paragraphs: (chapterQuery.isFetching
                                ? skeletonChapter
                                : chapterQuery.data)
                            ?.paragraphs,
                        fontSize: fontSize.value,
                        appColors: appColors,
                        textTheme: textTheme),
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
                    Skeleton.keep(
                        child: SizedBox(
                      height: 38,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ChapterNavigateButton(
                            onPressed: () => {},
                            disabled: true,
                          ),
                          const SizedBox(width: 12),
                          ChapterNavigateButton(
                            next: true,
                            onPressed: () => {},
                          ),
                        ],
                      ),
                    )),
                  ],
                ))),
      ),
      bottomNavigationBar: Hidable(
          controller: scrollController,
          child: ReadingBottomBar(
            changeStyle: changeStyle,
          )),
      floatingActionButton: HookBuilder(builder: (_) {
        final playingStream = useStream(player.playingStream);
        final positionAudioStream = useStream(
            Rx.combineLatest3<Duration, Duration, Duration?, PositionAudio>(
                player.positionStream,
                player.bufferedPositionStream,
                player.durationStream,
                (position, bufferedPosition, duration) =>
                    PositionAudio(position, bufferedPosition, duration)));
        final playing = playingStream.data ?? false;
        final position = positionAudioStream.data;
        if (playing == false && position?.position == Duration.zero)
          return const SizedBox();
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: appColors.skyLighter,
              borderRadius: BorderRadius.circular(6),
            ),
            height: 50,
            child: Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        width: 20,
                        height: 35,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage(storyQuery.data?.coverUrl ?? ''),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(storyQuery.data?.title ?? '',
                              style: textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          StreamBuilder(
                              stream: player.sequenceStateStream,
                              builder: (_, snapshot) {
                                final playerState = snapshot.data;
                                final currentParaIndex =
                                    playerState?.currentIndex ?? 0;
                                return Text(
                                    'Chương 1 - Đoạn ${currentParaIndex + 1}',
                                    style: textTheme.labelLarge?.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ));
                              }),
                        ],
                      )
                    ]),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Builder(builder: (context) {
                          if (!(playing)) {
                            return GestureDetector(
                              onTap: () {
                                player.play();
                              },
                              child: Icon(Icons.play_arrow_rounded,
                                  size: 30, color: appColors.inkLight),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                player.pause();
                              },
                              child: Icon(Icons.pause_rounded,
                                  size: 30, color: appColors.inkLight),
                            );
                          }
                        })
                      ],
                    )
                  ],
                ),
                Positioned(
                    bottom: 1,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                        height: 2,
                        child: ProgressBar(
                          barHeight: 2,
                          baseBarColor: Colors.white,
                          bufferedBarColor: appColors.primaryLightest,
                          progressBarColor: appColors.primaryBase,
                          thumbColor: appColors.primaryBase,
                          thumbRadius: 0,
                          timeLabelTextStyle:
                              Theme.of(context).textTheme.labelLarge,
                          progress: position?.position ?? Duration.zero,
                          buffered: position?.bufferedPosition ?? Duration.zero,
                          total: position?.duration ?? Duration.zero,
                          onSeek: player.seek,
                        ))),
              ],
            ));
      }),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}

class PositionAudio {
  final Duration position;
  final Duration bufferedPosition;
  final Duration? duration;
  const PositionAudio(this.position, this.bufferedPosition, this.duration);
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
        if (!disabled) onPressed();
      },
      style: FilledButton.styleFrom(
          backgroundColor:
              disabled ? appColors.skyLighter : appColors.primaryBase,
          minimumSize: Size.zero, // Set this
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
      Text('Chương ' + num.toString() + ":",
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
                chapter.read_count.toString(),
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
                chapter.vote_count.toString(),
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
                chapter.comment_count.toString(),
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
