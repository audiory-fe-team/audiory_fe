import 'package:freezed_annotation/freezed_annotation.dart';
part 'reading_progress_model.freezed.dart';
part 'reading_progress_model.g.dart';

@freezed
class ReadingProgress with _$ReadingProgress {
  const factory ReadingProgress({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'library_id') String? libraryId,
    @JsonKey(name: 'story_id') String? storyId,
    @JsonKey(name: 'chapter_id') String? chapterId,
    @JsonKey(name: 'reading_position') int? readingPosition,
    @JsonKey(name: 'is_completed') bool? isCompleted,
    @JsonKey(name: 'num_chapter') int? numChapter,
    @JsonKey(name: 'chapter_position') int? chapterPosition,
  }) = _ReadingProgress;

  factory ReadingProgress.fromJson(Map<String, dynamic> json) =>
      _$ReadingProgressFromJson(json);
}
