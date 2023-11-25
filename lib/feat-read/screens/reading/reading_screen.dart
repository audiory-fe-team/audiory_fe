// import 'package:audioplayers/audioplayers.dart';

import 'package:audiory_v0/feat-read/screens/reading/offline/new_offline_screen.dart';
import 'package:audiory_v0/feat-read/screens/reading/offline_reading_screen.dart';
import 'package:audiory_v0/feat-read/screens/reading/online_reading_screen.dart';
import 'package:audiory_v0/providers/connectivity_provider.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class ReadingScreen extends ConsumerWidget {
  final String chapterId;
  final String storyId;
  final bool? showComment;
  final int? initialOffset;

  ReadingScreen(
      {super.key,
      required this.chapterId,
      required this.storyId,
      this.initialOffset,
      this.showComment = false});

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.read(isOfflineProvider);

    if (isOffline == true) {
      return OfflineReadingScreen(
          chapterId: chapterId, storyId: storyId, initialOffset: initialOffset);
    }
    return OnlineReadingScreen(
        chapterId: chapterId,
        storyId: storyId,
        showComment: showComment,
        initialOffset: initialOffset);
  }
}
