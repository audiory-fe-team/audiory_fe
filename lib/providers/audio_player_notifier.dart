import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerNotifier extends Notifier<AudioPlayer> {
  @override
  AudioPlayer build() {
    return AudioPlayer();
  }

  setPlayer(AudioPlayer player) {
    state = player;
  }
}
