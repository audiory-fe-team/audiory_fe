import 'dart:math';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audiory_v0/constants/theme_options.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PositionAudio {
  final Duration position;
  final Duration bufferedPosition;
  final Duration? duration;
  const PositionAudio(this.position, this.bufferedPosition, this.duration);
}

class ChapterAudioPlayer extends HookWidget {
  final AudioPlayer player;
  final Function? onFirstPlay;
  final int selectedThemeOption;
  const ChapterAudioPlayer(
      {super.key,
      this.onFirstPlay,
      required this.player,
      required this.selectedThemeOption});

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final isFirstPlay = useState(true);
    final bgColor = useState(appColors?.skyLightest);
    final textColor = useState(appColors?.inkLighter);
    print(player.hashCode);
    syncPreference() async {
      bgColor.value = THEME_OPTIONS[selectedThemeOption]['audioBackground'];
      textColor.value = THEME_OPTIONS[selectedThemeOption]['audioText'];
    }

    useEffect(() {
      syncPreference();
    }, [selectedThemeOption]);
    // final sequenceStateStream = useStream(player.sequenceStateStream);
    // final totalDuration = sequenceStateStream.data?.sequence.fold(Duration.zero,
    //     (previous, element) => previous + (element.duration ?? Duration.zero));

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: bgColor.value, borderRadius: BorderRadius.circular(8)),
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
            StreamBuilder(
              stream: Rx.combineLatest3<Duration, Duration, Duration?,
                      PositionAudio>(
                  player.positionStream,
                  player.bufferedPositionStream,
                  player.durationStream,
                  (position, bufferedPosition, duration) =>
                      PositionAudio(position, bufferedPosition, duration)),
              builder: (context, snapshot) {
                final position = snapshot.data;
                return Skeleton.shade(
                    child: ProgressBar(
                  barHeight: 4,
                  baseBarColor: textColor.value,
                  bufferedBarColor: appColors?.primaryLightest,
                  progressBarColor: appColors?.primaryBase,
                  thumbColor: appColors?.primaryBase,
                  thumbRadius: 5,
                  timeLabelTextStyle: Theme.of(context).textTheme.labelLarge,
                  progress: position?.position ?? Duration.zero,
                  buffered: position?.bufferedPosition ?? Duration.zero,
                  total: position?.duration ?? Duration.zero,
                  onSeek: player.seek,
                ));
              },
            ),
            Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                  onPressed: () {
                    player.seekToPrevious();
                  },
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    size: 24,
                  )),
              IconButton(
                  onPressed: () {
                    player.seek(Duration(
                        seconds: max(player.position.inSeconds - 10, 0)));
                  },
                  icon: const Icon(
                    Icons.replay_10,
                    size: 24,
                  )),
              Skeleton.shade(
                  child: StreamBuilder<PlayerState>(
                      stream: player.playerStateStream,
                      builder: ((context, snapshot) {
                        final playerState = snapshot.data;
                        final processingState = playerState?.processingState;
                        final playing = playerState?.playing;
                        if (!(playing ?? false)) {
                          return FilledButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      appColors?.primaryBase),
                                  shape: const MaterialStatePropertyAll(
                                      CircleBorder()),
                                  elevation: const MaterialStatePropertyAll(1)),
                              onPressed: () {
                                if (isFirstPlay.value) {
                                  if (onFirstPlay != null) onFirstPlay!();
                                  isFirstPlay.value = false;
                                }
                                player.play();
                              },
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                size: 24,
                                color: Colors.white,
                              ));
                        } else if (processingState !=
                            ProcessingState.completed) {
                          return FilledButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      appColors?.primaryBase),
                                  shape: const MaterialStatePropertyAll(
                                      CircleBorder()),
                                  elevation: const MaterialStatePropertyAll(1)),
                              onPressed: player.pause,
                              child: const Icon(
                                Icons.pause_rounded,
                                size: 24,
                                color: Colors.white,
                              ));
                        }

                        return FilledButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    appColors?.primaryBase),
                                shape: const MaterialStatePropertyAll(
                                    CircleBorder()),
                                elevation: const MaterialStatePropertyAll(1)),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              size: 24,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              player.seek(Duration.zero);
                              player.play();
                            });
                      }))),
              IconButton(
                  onPressed: () {
                    player.seek(Duration(
                        seconds: min(player.position.inSeconds + 10,
                            player.duration?.inSeconds ?? 0)));
                  },
                  icon: const Icon(
                    Icons.forward_10,
                    size: 24,
                  )),
              IconButton(
                  onPressed: () {
                    player.seekToNext();
                  },
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    size: 24,
                  )),
            ])
          ],
        ));
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
