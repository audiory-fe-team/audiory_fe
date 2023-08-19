class ReadingProgress {
  String chapterId;
  String id;
  String libraryId;
  int readingPosition;
  String storyId;

  ReadingProgress({
    required this.chapterId,
    required this.id,
    required this.libraryId,
    required this.readingPosition,
    required this.storyId,
  });

  factory ReadingProgress.fromJson(Map<String, dynamic> json) {
    return ReadingProgress(
      chapterId: json['chapter_id'] as String,
      id: json['id'] as String,
      libraryId: json['library_id'] as String,
      readingPosition: json['reading_position'] as int,
      storyId: json['story_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chapter_id': chapterId,
      'id': id,
      'library_id': libraryId,
      'reading_position': readingPosition,
      'story_id': storyId,
    };
  }
}
