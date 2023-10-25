// import 'package:audioplayers/audioplayers.dart';

import 'package:audiory_v0/feat-read/screens/reading/new.dart';
import 'package:audiory_v0/feat-read/screens/reading/offline_reading_screen.dart';
import 'package:audiory_v0/feat-read/screens/reading/online_reading_screen.dart';
import 'package:audiory_v0/providers/connectivity_provider.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class ReadingScreen extends ConsumerWidget {
  final String chapterId;
  final bool? showComment;

  ReadingScreen({super.key, required this.chapterId, this.showComment = false});

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.read(isOfflineProvider);

    if (isOffline == true) {
      return OfflineReadingScreen(
          chapterId: chapterId, showComment: showComment);
    }
    return NewOnlineReadingScreen(
        chapterId: chapterId, showComment: showComment);
  }
}
