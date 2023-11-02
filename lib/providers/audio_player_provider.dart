import 'package:just_audio/just_audio.dart';
// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

final audioPlayerProvider = StateProvider<AudioPlayer>((ref) {
  final player = AudioPlayer();
  ref.onDispose(() {
    player.dispose();
  });
  return player;
});
final audioPlayerStoryIdProvider = Provider<String?>((ref) {
  String? storyId;
  ref.onDispose(() {
    storyId = null;
  });
  return storyId;
});

final audioCurrentIndexProvider = Provider<int?>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  int? currentIndex;

  audioPlayer.currentIndexStream.listen((index) {
    currentIndex = index;
  });

  return currentIndex;
});
