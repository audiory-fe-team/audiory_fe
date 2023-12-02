import 'package:audiory_v0/models/Profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wall_comment_model.freezed.dart'; //get the file name same as the class file name
part 'wall_comment_model.g.dart';

@freezed
class WallComment with _$WallComment {
  //category duplicate with annatation category class
  const factory WallComment({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @Default('') @JsonKey(name: 'user_id') String? userId,
    @Default('') @JsonKey(name: 'text') String? text,
    @Default(false) @JsonKey(name: 'is_liked') bool? isLiked,
    @Default(null) @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'user') Profile? user,
    @Default('') @JsonKey(name: 'created_date') String? createdDate,
    @Default('') @JsonKey(name: 'updated_date') String? updatedDate,
    @Default([]) @JsonKey(name: 'children') List<WallComment>? children,
  }) = _WallComment;

  factory WallComment.fromJson(Map<String, dynamic> json) =>
      _$WallCommentFromJson(json);
}
