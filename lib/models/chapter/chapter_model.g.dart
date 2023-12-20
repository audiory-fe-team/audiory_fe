// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChapterImpl _$$ChapterImplFromJson(Map<String, dynamic> json) =>
    _$ChapterImpl(
      id: json['id'] as String? ?? '',
      storyId: json['story_id'] as String?,
      currentVersionId: json['current_version_id'] as String?,
      publishedVersionId: json['published_version_id'] as String?,
      position: json['position'] as int?,
      title: json['title'] as String? ?? '',
      isDraft: json['is_draft'] as bool? ?? true,
      isPaywalled: json['is_paywalled'] as bool? ?? false,
      isPaid: json['is_paid'] as bool? ?? false,
      price: json['price'] as int? ?? 0,
      readCount: json['read_count'] as int?,
      isVoted: json['is_voted'] as bool?,
      voteCount: json['vote_count'] as int?,
      commentCount: json['comment_count'] as int?,
      createdDate: json['created_date'] as String?,
      updatedDate: json['updated_date'] as String?,
      isEnabled: json['is_enabled'] as bool?,
      currentChapterVerion: json['current_chapter_version'] == null
          ? null
          : ChapterVersion.fromJson(
              json['current_chapter_version'] as Map<String, dynamic>),
      publishedChapterVerion: json['published_chapter_version'] == null
          ? null
          : ChapterVersion.fromJson(
              json['published_chapter_version'] as Map<String, dynamic>),
      paragraphs: (json['paragraphs'] as List<dynamic>?)
          ?.map((e) => Paragraph.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChapterImplToJson(_$ChapterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'story_id': instance.storyId,
      'current_version_id': instance.currentVersionId,
      'published_version_id': instance.publishedVersionId,
      'position': instance.position,
      'title': instance.title,
      'is_draft': instance.isDraft,
      'is_paywalled': instance.isPaywalled,
      'is_paid': instance.isPaid,
      'price': instance.price,
      'read_count': instance.readCount,
      'is_voted': instance.isVoted,
      'vote_count': instance.voteCount,
      'comment_count': instance.commentCount,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
      'is_enabled': instance.isEnabled,
      'current_chapter_version': instance.currentChapterVerion?.toJson(),
      'published_chapter_version': instance.publishedChapterVerion?.toJson(),
      'paragraphs': instance.paragraphs?.map((e) => e.toJson()).toList(),
    };
