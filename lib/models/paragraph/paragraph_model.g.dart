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
      commentCount: json['comment_count'] as int? ?? 0,
      audioUrl: json['audio_url'] as String? ?? '',
    );

Map<String, dynamic> _$$ParagraphImplToJson(_$ParagraphImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chapter_id': instance.chapterId,
      'chapter_version_id': instance.chapterVersionId,
      'order': instance.order,
      'content': instance.content,
      'comment_count': instance.commentCount,
      'audio_url': instance.audioUrl,
    };
