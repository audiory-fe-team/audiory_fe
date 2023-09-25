import 'dart:math';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audiory_v0/feat-read/models/position_audio.dart';
import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
            AudioControl(audioPlayer: player)
          ],
        ));
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
