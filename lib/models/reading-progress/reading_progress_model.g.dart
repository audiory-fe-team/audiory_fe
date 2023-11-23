// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReadingProgressImpl _$$ReadingProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$ReadingProgressImpl(
      id: json['id'] as String,
      libraryId: json['library_id'] as String?,
      storyId: json['story_id'] as String?,
      chapterId: json['chapter_id'] as String?,
      readingPosition: json['reading_position'] as int?,
      isCompleted: json['is_completed'] as bool?,
      numChapter: json['num_chapter'] as int?,
      chapterPosition: json['chapter_position'] as int?,
    );

Map<String, dynamic> _$$ReadingProgressImplToJson(
        _$ReadingProgressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'library_id': instance.libraryId,
      'story_id': instance.storyId,
      'chapter_id': instance.chapterId,
      'reading_position': instance.readingPosition,
      'is_completed': instance.isCompleted,
      'num_chapter': instance.numChapter,
      'chapter_position': instance.chapterPosition,
    };
