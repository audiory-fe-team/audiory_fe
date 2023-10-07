// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chapter _$$_ChapterFromJson(Map<String, dynamic> json) => _$_Chapter(
      id: json['id'] as String? ?? '',
      storyId: json['story_id'] as String?,
      currentVersionId: json['current_version_id'] as String?,
      position: json['position'] as int?,
      productId: json['product_id'] as String?,
      title: json['title'] as String? ?? '',
      isDraft: json['is_draft'] as bool?,
      isPaywalled: json['is_paywalled'] as bool?,
      authorEarning: json['author_earning'] as int?,
      readCount: json['read_count'] as int?,
      voteCount: json['vote_count'] as int?,
      commentCount: json['comment_count'] as int?,
      createdDate: json['created_date'] as String?,
      updatedDate: json['updated_date'] as String?,
      isEnabled: json['is_enabled'] as bool?,
      chapterVersion: json['chapter_version'] as String?,
      paragraphs: (json['paragraphs'] as List<dynamic>?)
          ?.map((e) => Paragraph.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ChapterToJson(_$_Chapter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'story_id': instance.storyId,
      'current_version_id': instance.currentVersionId,
      'position': instance.position,
      'product_id': instance.productId,
      'title': instance.title,
      'is_draft': instance.isDraft,
      'is_paywalled': instance.isPaywalled,
      'author_earning': instance.authorEarning,
      'read_count': instance.readCount,
      'vote_count': instance.voteCount,
      'comment_count': instance.commentCount,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
      'is_enabled': instance.isEnabled,
      'chapter_version': instance.chapterVersion,
      'paragraphs': instance.paragraphs?.map((e) => e.toJson()).toList(),
    };
