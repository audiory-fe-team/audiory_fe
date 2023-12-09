import 'package:audiory_v0/models/content-moderation/content_moderation_model.dart';
import 'package:audiory_v0/models/paragraph/para_audio_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paragraph_model.freezed.dart';
part 'paragraph_model.g.dart';

@freezed
class Paragraph with _$Paragraph {
  const factory Paragraph({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @Default('') @JsonKey(name: 'chapter_id') String? chapterId,
    @Default('') @JsonKey(name: 'chapter_version_id') String? chapterVersionId,
    @Default(0) @JsonKey(name: 'order') int? order,
    @Default('') @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'rich_text') String? richText,
    @Default(0) @JsonKey(name: 'comment_count') int? commentCount,
    @Default([]) @JsonKey(name: 'audios') List<ParaAudio>? audios,
    @JsonKey(name: 'content_moderation') ContentModeration? contentModeration,
  }) = _Paragraph;

  factory Paragraph.fromJson(Map<String, dynamic> json) =>
      _$ParagraphFromJson(json);
}
