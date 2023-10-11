import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_story_model.freezed.dart'; //get the file name same as the class file name
part 'author_story_model.g.dart';

@freezed
class AuthorStory with _$AuthorStory {
  const factory AuthorStory({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @Default('') @JsonKey(name: 'full_name') String? fullName,
    @Default('') @JsonKey(name: 'sex') String? sex,
    @Default('') @JsonKey(name: 'avatar_url') String? avatarUrl,
    @Default('')
    @JsonKey(name: 'registration_tokens')
    String? registrationTokens,
    @Default('') @JsonKey(name: 'role_id') String? roleId,
  }) = _AuthorStory;

  factory AuthorStory.fromJson(Map<String, dynamic> json) =>
      _$AuthorStoryFromJson(json);
}
