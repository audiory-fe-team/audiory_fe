import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audiory_v0/feat-read/screens/reading/chapter_audio_player.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/providers/audio_player_provider.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AudioBottomBar extends HookConsumerWidget {
  const AudioBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final player = ref.watch(audioPlayerProvider);

    if (player.sequence == null || player.sequence!.isEmpty) {
      return const SizedBox();
    }

    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          // Then show a snackbar.
          player.dispose();

          // AppSnackBar.buildTopSnackBar(
          //     context, 'Dừng phát audio', null, SnackBarType.error);
        },
        child: Container(
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
                    Expanded(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const SizedBox(width: 6),
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              player.sequenceState?.currentSource?.tag.title
                                      .toString() ??
                                  '',
                              overflow: TextOverflow.ellipsis,
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
                                    'Chương ${player.sequenceState?.currentSource?.tag.extras['position']} - Đoạn ${currentParaIndex + 1}',
                                    style: textTheme.labelLarge?.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ));
                              }),
                        ],
                      ))
                    ])),
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
                        StreamBuilder(
                            stream: player.playingStream,
                            builder: (context, snapshot) {
                              final playing = snapshot.data ?? false;
                              if (!(playing)) {
                                return GestureDetector(
                                  onTap: () {
                                    print("play");

                                    player.play();
                                  },
                                  child: Icon(Icons.play_arrow_rounded,
                                      size: 30, color: appColors.inkLight),
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    print("pause");
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
                    child: SizedBox(
                        height: 2,
                        child: StreamBuilder(
                          stream: Rx.combineLatest3<Duration, Duration,
                                  Duration?, PositionAudio>(
                              player.positionStream,
                              player.bufferedPositionStream,
                              player.durationStream,
                              (position, bufferedPosition, duration) =>
                                  PositionAudio(
                                      position, bufferedPosition, duration)),
                          builder: (context, snapshot) {
                            final position = snapshot.data;
                            return ProgressBar(
                              barHeight: 2,
                              baseBarColor: Colors.white,
                              bufferedBarColor: appColors.primaryLightest,
                              progressBarColor: appColors.primaryBase,
                              thumbColor: appColors.primaryBase,
                              thumbRadius: 0,
                              timeLabelTextStyle:
                                  Theme.of(context).textTheme.labelLarge,
                              progress: position?.position ?? Duration.zero,
                              buffered:
                                  position?.bufferedPosition ?? Duration.zero,
                              total: position?.duration ?? Duration.zero,
                              onSeek: player.seek,
                            );
                          },
                        ))),
              ],
            )));
  }
}
