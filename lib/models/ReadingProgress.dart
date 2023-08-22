class ReadingProgress {
  String? chapterId;
  String id;
  String? libraryId;
  int? readingPosition;
  String? storyId;

  ReadingProgress({
    this.chapterId,
    required this.id,
    this.libraryId,
    this.readingPosition,
    this.storyId,
  });

  factory ReadingProgress.fromJson(Map<String, dynamic> json) {
    return ReadingProgress(
      chapterId: json['chapter_id'],
      id: json['id'],
      libraryId: json['library_id'],
      readingPosition: json['reading_position'],
      storyId: json['story_id'],
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
