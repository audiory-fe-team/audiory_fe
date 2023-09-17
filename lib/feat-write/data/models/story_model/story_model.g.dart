// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Story _$$_StoryFromJson(Map<String, dynamic> json) => _$_Story(
      id: json['id'] as String? ?? '',
      authorId: json['author_id'] as String?,
      categoryId: json['category_id'] as String?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      coverUrl: json['cover_url'] as String?,
      isDraft: json['is_draft'] as bool?,
      isMature: json['is_mature'] as bool?,
      isCompleted: json['is_completed'] as bool?,
      isCopyright: json['is_copyright'] as bool?,
      isPaywalled: json['is_paywalled'] as bool?,
      coinCost: json['coin_cost'] as int?,
      authorEarningPercentage: json['author_earning_percentage'] as int?,
      paywallEffectiveDate: json['paywall_effective_date'] as String?,
      numFreeChapters: json['num_free_chapters'] as int?,
      publishedCount: json['published_count'] as int?,
      draftCount: json['draft_count'] as int?,
      reportCount: json['report_count'] as int?,
      voteCount: json['vote_count'] as int?,
      readCount: json['read_count'] as int?,
      explicitPercentage: json['explicit_percentage'] as int?,
      createdDate: json['created_date'] as String?,
      updatedDate: json['updated_date'] as String?,
      isEnabled: json['is_enabled'] as bool?,
      chapters: (json['chapters'] as List<dynamic>?)
              ?.map((e) => Chapter.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_StoryToJson(_$_Story instance) => <String, dynamic>{
      'id': instance.id,
      'author_id': instance.authorId,
      'category_id': instance.categoryId,
      'title': instance.title,
      'description': instance.description,
      'cover_url': instance.coverUrl,
      'is_draft': instance.isDraft,
      'is_mature': instance.isMature,
      'is_completed': instance.isCompleted,
      'is_copyright': instance.isCopyright,
      'is_paywalled': instance.isPaywalled,
      'coin_cost': instance.coinCost,
      'author_earning_percentage': instance.authorEarningPercentage,
      'paywall_effective_date': instance.paywallEffectiveDate,
      'num_free_chapters': instance.numFreeChapters,
      'published_count': instance.publishedCount,
      'draft_count': instance.draftCount,
      'report_count': instance.reportCount,
      'vote_count': instance.voteCount,
      'read_count': instance.readCount,
      'explicit_percentage': instance.explicitPercentage,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
      'is_enabled': instance.isEnabled,
      'chapters': instance.chapters,
      'tags': instance.tags,
    };
