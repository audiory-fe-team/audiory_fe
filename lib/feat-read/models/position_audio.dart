class PositionAudio {
  final Duration position;
  final Duration bufferedPosition;
  final Duration? duration;
  const PositionAudio(this.position, this.bufferedPosition, this.duration);
}
