import 'package:audiory_v0/models/paragraph/para_audio_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_moderation_model.freezed.dart';
part 'content_moderation_model.g.dart';

@freezed
class ContentModeration with _$ContentModeration {
  const factory ContentModeration({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @Default('') @JsonKey(name: 'chapter_version_id') String? chapterVersionId,
    @Default('') @JsonKey(name: 'paragraph_id') String? paragraphId,
    @Default('TEXT') @JsonKey(name: 'type') String? type,
    @Default(false) @JsonKey(name: 'is_mature') bool? isMature,
    @Default(false) @JsonKey(name: 'is_reactionary') bool? isReactionary,
  }) = _ContentModeration;

  factory ContentModeration.fromJson(Map<String, dynamic> json) =>
      _$ContentModerationFromJson(json);
}
