//using freezed to create a model minimalize code for a class
//have to add freezed_annotation if want to use freezed
import 'package:audiory_v0/models/paragraph/paragraph_model.dart';
import "package:flutter/foundation.dart";
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_model.freezed.dart'; //get the file name same as the class file name
part 'chapter_model.g.dart';
//run line before to generate
//flutter pub run build_runner build --delete-conflicting-outputs

//generate model classes by cmd
//flutter pub run build_runner build

//when update the field, remove freezed.dart and g.dart part before use cmd

@freezed
class Chapter with _$Chapter {
  const factory Chapter({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase
    @Default('') @JsonKey(name: 'id') String id,
    @JsonKey(name: 'story_id') String? storyId,
    @JsonKey(name: 'current_version_id') String? currentVersionId,
    @JsonKey(name: 'position') int? position, // chapter position
    @JsonKey(name: 'product_id') String? productId,
    @Default('') @JsonKey(name: 'title') String title,
    @JsonKey(name: 'is_draft') bool? isDraft,
    @JsonKey(name: 'is_paywalled') bool? isPaywalled,
    @JsonKey(name: 'is_paid') bool? isPaid,
    @JsonKey(name: 'price') int? price,
    @JsonKey(name: 'read_count') int? readCount,
    @JsonKey(name: 'is_voted') bool? isVoted,
    @JsonKey(name: 'vote_count') int? voteCount,
    @JsonKey(name: 'comment_count') int? commentCount,
    @JsonKey(name: 'created_date') String? createdDate,
    @JsonKey(name: 'updated_date') String? updatedDate,
    @JsonKey(name: 'is_enabled') bool? isEnabled,
    @JsonKey(name: 'chapter_version') String? chapterVersion,
    @JsonKey(name: 'paragraphs') List<Paragraph>? paragraphs,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
}
