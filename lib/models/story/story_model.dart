import 'package:audiory_v0/models/author-story/author_story_model.dart';
import 'package:audiory_v0/models/chapter/chapter_model.dart';
import 'package:audiory_v0/models/tag/tag_model.dart';
import "package:flutter/foundation.dart";
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_model.freezed.dart'; //get the file name same as the class file name
part 'story_model.g.dart';

@freezed
class Story with _$Story {
  const factory Story({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'author_id') String? authorId,
    @JsonKey(name: 'author') AuthorStory? author,
    @JsonKey(name: 'category_id') String? categoryId, // Story position
    @Default('') @JsonKey(name: 'title') String title,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'cover_url') String? coverUrl,
    @JsonKey(name: 'is_draft') bool? isDraft,
    @JsonKey(name: 'is_mature') bool? isMature,
    @JsonKey(name: 'is_completed') bool? isCompleted,
    @JsonKey(name: 'is_copyright') bool? isCopyright,
    @JsonKey(name: 'is_paywalled') bool? isPaywalled,
    @JsonKey(name: 'coin_cost') int? coinCost,
    @JsonKey(name: 'author_earning_percentage') int? authorEarningPercentage,
    @JsonKey(name: 'paywall_effective_date') String? paywallEffectiveDate,
    @JsonKey(name: 'num_free_chapters') int? numFreeChapters,
    @JsonKey(name: 'published_count') int? publishedCount,
    @JsonKey(name: 'draft_count') int? draftCount,
    @JsonKey(name: 'report_count') int? reportCount,
    @JsonKey(name: 'vote_count') int? voteCount,
    @JsonKey(name: 'read_count') int? readCount,
    @JsonKey(name: 'explicit_percentage') int? explicitPercentage,
    @JsonKey(name: 'created_date') String? createdDate,
    @JsonKey(name: 'updated_date') String? updatedDate,
    @JsonKey(name: 'is_enabled') bool? isEnabled,
    @Default([]) @JsonKey(name: 'chapters') List<Chapter>? chapters,
    @Default([]) @JsonKey(name: 'tags') List<Tag>? tags,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}
