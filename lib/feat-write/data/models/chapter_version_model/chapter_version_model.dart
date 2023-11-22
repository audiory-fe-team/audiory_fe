import "package:flutter/foundation.dart";
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_version_model.freezed.dart'; //get the file name same as the class name
part 'chapter_version_model.g.dart';

@freezed
class ChapterVersion with _$ChapterVersion {
  const factory ChapterVersion({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    @Default('') @JsonKey(name: 'id') String id,
    @Default('') @JsonKey(name: 'chapter_id') String? chapterId,
    @Default('') @JsonKey(name: 'version_name') String? versionName,
    @Default('') @JsonKey(name: 'banner_url') String? bannerUrl,
    @Default('') @JsonKey(name: 'title') String? title,
    @Default('') @JsonKey(name: 'rich_text') String? richText, //for json
    @Default('') @JsonKey(name: 'content') String? content, //for raw content
    @JsonKey(name: 'timestamp') String? timestamp,
  }) = _ChapterVersion;

  factory ChapterVersion.fromJson(Map<String, dynamic> json) =>
      _$ChapterVersionFromJson(json);
}
