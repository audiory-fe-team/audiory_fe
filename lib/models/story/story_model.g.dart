// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryImpl _$$StoryImplFromJson(Map<String, dynamic> json) => _$StoryImpl(
      id: json['id'] as String,
      authorId: json['author_id'] as String?,
      author: json['author'] == null
          ? null
          : AuthorStory.fromJson(json['author'] as Map<String, dynamic>),
      categoryId: json['category_id'] as String?,
      category: json['category'] == null
          ? null
          : AppCategory.fromJson(json['category'] as Map<String, dynamic>),
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      coverUrl: json['cover_url'] as String?,
      isDraft: json['is_draft'] as bool?,
      isMature: json['is_mature'] as bool?,
      isCompleted: json['is_completed'] as bool?,
      isCopyright: json['is_copyright'] as bool?,
      isPaywalled: json['is_paywalled'] as bool?,
      chapterPrice: json['chapter_price'] as int?,
      coinCost: json['coin_cost'] as int?,
      authorEarningPercentage: json['author_earning_percentage'] as int?,
      paywallEffectiveDate: json['paywall_effective_date'] as String?,
      numFreeChapters: json['num_free_chapters'] as int?,
      publishedCount: json['published_count'] as int?,
      draftCount: json['draft_count'] as int?,
      reportCount: json['report_count'] as int?,
      voteCount: json['vote_count'] as int?,
      readCount: json['read_count'] as int?,
<<<<<<< HEAD
      totalVote: json['total_vote'] as int?,
      totalRead: json['total_read'] as int?,
      totalComment: json['total_comment'] as int?,
=======
      commentCount: json['comment_count'] as int?,
>>>>>>> b9116ea07066983f61623ee605cffaf3bff64bac
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

Map<String, dynamic> _$$StoryImplToJson(_$StoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author_id': instance.authorId,
      'author': instance.author?.toJson(),
      'category_id': instance.categoryId,
      'category': instance.category?.toJson(),
      'title': instance.title,
      'description': instance.description,
      'cover_url': instance.coverUrl,
      'is_draft': instance.isDraft,
      'is_mature': instance.isMature,
      'is_completed': instance.isCompleted,
      'is_copyright': instance.isCopyright,
      'is_paywalled': instance.isPaywalled,
      'chapter_price': instance.chapterPrice,
      'coin_cost': instance.coinCost,
      'author_earning_percentage': instance.authorEarningPercentage,
      'paywall_effective_date': instance.paywallEffectiveDate,
      'num_free_chapters': instance.numFreeChapters,
      'published_count': instance.publishedCount,
      'draft_count': instance.draftCount,
      'report_count': instance.reportCount,
      'vote_count': instance.voteCount,
      'read_count': instance.readCount,
<<<<<<< HEAD
      'total_vote': instance.totalVote,
      'total_read': instance.totalRead,
      'total_comment': instance.totalComment,
=======
      'comment_count': instance.commentCount,
>>>>>>> b9116ea07066983f61623ee605cffaf3bff64bac
      'explicit_percentage': instance.explicitPercentage,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
      'is_enabled': instance.isEnabled,
      'chapters': instance.chapters?.map((e) => e.toJson()).toList(),
      'tags': instance.tags?.map((e) => e.toJson()).toList(),
    };
