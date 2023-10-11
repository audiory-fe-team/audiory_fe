import 'package:audiory_v0/constants/fallback_image.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_list_model.freezed.dart'; //get the file name same as the class file name
part 'reading_list_model.g.dart';

@freezed
class ReadingList with _$ReadingList {
  //category duplicate with annatation category class
  const factory ReadingList({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @Default('') @JsonKey(name: 'name') String? name,
    @Default('') @JsonKey(name: 'user_id') String? userId,
    @Default(FALLBACK_IMG_URL) @JsonKey(name: 'cover_url') String? coverUrl,
    @Default('') @JsonKey(name: 'created_date') String? createdDate,
    @Default('') @JsonKey(name: 'updated_date') String? updatedDate,
    @JsonKey(name: 'is_private') bool? isPrivate,
    @JsonKey(name: 'is_enabled') bool? isEnabled,
    @Default([]) @JsonKey(name: 'stories') List<Story>? stories,
  }) = _ReadingList;

  factory ReadingList.fromJson(Map<String, dynamic> json) =>
      _$ReadingListFromJson(json);
}
