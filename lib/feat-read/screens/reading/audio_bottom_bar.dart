import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/feat-read/screens/reading/chapter_audio_player.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioBottomBar extends HookWidget {
  final String? storyId;
  final AudioPlayer player;
  const AudioBottomBar(
      {super.key, required this.player, required this.storyId});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final storyQuery = useQuery(
        ['story', storyId], () => StoryRepostitory().fetchStoryById(storyId!),
        enabled: storyId != null);

    return HookBuilder(builder: (_) {
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
      if (playingStream.data != true &&
          (position?.position == Duration.zero || position?.position == null)) {
        return const SizedBox();
      }
      return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(horizontal: 6),
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
                      width: 30,
                      height: 42,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              storyQuery.data?.coverUrl ?? FALLBACK_IMG_URL),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                    const SizedBox(width: 6),
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
                      GestureDetector(
                        onTap: () {
                          player.seekToPrevious();
                        },
                        child: Icon(Icons.skip_previous_rounded,
                            size: 30, color: appColors.inkLight),
                      ),
                      const SizedBox(width: 4),
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
                      }),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          player.seekToNext();
                        },
                        child: Icon(Icons.skip_next_rounded,
                            size: 30, color: appColors.inkLight),
                      )
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
    });
  }
}
