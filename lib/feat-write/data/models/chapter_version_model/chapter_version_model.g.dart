// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChapterVersionImpl _$$ChapterVersionImplFromJson(Map<String, dynamic> json) =>
    _$ChapterVersionImpl(
      id: json['id'] as String? ?? '',
      chapterId: json['chapter_id'] as String? ?? '',
      versionName: json['version_name'] as String?,
      bannerUrl: json['banner_url'] as String?,
      title: json['title'] as String? ?? '',
      richText: json['rich_text'] as String?,
      content: json['content'] as String?,
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$$ChapterVersionImplToJson(
        _$ChapterVersionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chapter_id': instance.chapterId,
      'version_name': instance.versionName,
      'banner_url': instance.bannerUrl,
      'title': instance.title,
      'rich_text': instance.richText,
      'content': instance.content,
      'timestamp': instance.timestamp,
    };
