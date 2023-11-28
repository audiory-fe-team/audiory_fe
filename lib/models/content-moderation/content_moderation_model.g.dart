// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_moderation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentModerationImpl _$$ContentModerationImplFromJson(
        Map<String, dynamic> json) =>
    _$ContentModerationImpl(
      id: json['id'] as String,
      chapterVersionId: json['chapter_version_id'] as String? ?? '',
      paragraphId: json['paragraph_id'] as String? ?? '',
      type: json['type'] as String? ?? 'TEXT',
      isMature: json['is_mature'] as bool? ?? false,
      isReactionary: json['is_reactionary'] as bool? ?? false,
    );

Map<String, dynamic> _$$ContentModerationImplToJson(
        _$ContentModerationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chapter_version_id': instance.chapterVersionId,
      'paragraph_id': instance.paragraphId,
      'type': instance.type,
      'is_mature': instance.isMature,
      'is_reactionary': instance.isReactionary,
    };
