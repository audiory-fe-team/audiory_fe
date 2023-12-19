// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paragraph_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParagraphImpl _$$ParagraphImplFromJson(Map<String, dynamic> json) =>
    _$ParagraphImpl(
      id: json['id'] as String,
      chapterId: json['chapter_id'] as String? ?? '',
      chapterVersionId: json['chapter_version_id'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      content: json['content'] as String? ?? '',
      richText: json['rich_text'] as String?,
      commentCount: json['comment_count'] as int? ?? 0,
      audios: (json['audios'] as List<dynamic>?)
              ?.map((e) => ParaAudio.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      contentModeration: (json['content_moderation'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : ContentModeration.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ParagraphImplToJson(_$ParagraphImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chapter_id': instance.chapterId,
      'chapter_version_id': instance.chapterVersionId,
      'order': instance.order,
      'content': instance.content,
      'rich_text': instance.richText,
      'comment_count': instance.commentCount,
      'audios': instance.audios?.map((e) => e.toJson()).toList(),
      'content_moderation':
          instance.contentModeration.map((e) => e?.toJson()).toList(),
    };
