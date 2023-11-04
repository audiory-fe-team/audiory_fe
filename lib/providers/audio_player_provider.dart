import 'package:audiory_v0/providers/audio_player_notifier.dart';
import 'package:just_audio/just_audio.dart';
// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

final audioPlayerProvider =
    NotifierProvider<AudioPlayerNotifier, AudioPlayer>(() {
  return AudioPlayerNotifier();
});
final audioPlayerStoryIdProvider = Provider<String?>((ref) {
  String? storyId;
  ref.onDispose(() {
    storyId = null;
  });
  return storyId;
});

class CurrentIndexNotifier extends StateNotifier<int?> {
  CurrentIndexNotifier() : super(null);

  void updateIndex(int? index) {
    state = index;
  }
}

final currentIndexProvider =
    StateNotifierProvider<CurrentIndexNotifier, int?>((ref) {
  return CurrentIndexNotifier();
});
