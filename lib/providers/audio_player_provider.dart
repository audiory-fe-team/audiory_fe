import 'package:just_audio/just_audio.dart';
import 'package:riverpod/riverpod.dart';

final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  final player = AudioPlayer();
  ref.onDispose(() {
    player.dispose();
  });
  return player;
});

final audioCurrentIndexProvider = Provider<int?>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  int? currentIndex;

  audioPlayer.currentIndexStream.listen((index) {
    currentIndex = index;
  });

  return currentIndex;
});
