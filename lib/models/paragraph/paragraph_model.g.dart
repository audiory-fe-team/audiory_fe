// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paragraph_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Paragraph _$$_ParagraphFromJson(Map<String, dynamic> json) => _$_Paragraph(
      id: json['id'] as String,
      chapterId: json['chapter_id'] as String,
      order: json['order'] as int? ?? 0,
      content: json['content'] as String? ?? '',
      commentCount: json['comment_count'] as int? ?? 0,
      audioUrl: json['audio_url'] as String? ?? '',
    );

Map<String, dynamic> _$$_ParagraphToJson(_$_Paragraph instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chapter_id': instance.chapterId,
      'order': instance.order,
      'content': instance.content,
      'comment_count': instance.commentCount,
      'audio_url': instance.audioUrl,
    };
