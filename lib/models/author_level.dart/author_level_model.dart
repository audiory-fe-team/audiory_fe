import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_level_model.freezed.dart'; //get the file name same as the class file name
part 'author_level_model.g.dart';

@freezed
class AuthorLevel with _$AuthorLevel {
  //category duplicate with annatation category class
  const factory AuthorLevel({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required int id, //int
    @Default('') @JsonKey(name: 'name') String? name,
    @Default(true) @JsonKey(name: 'is_enabled') bool? isEnabled,
    @JsonKey(name: 'created_date') String? createdDate,
    @JsonKey(name: 'updated_date') String? updatedDate,
  }) = _AuthorLevel;

  factory AuthorLevel.fromJson(Map<String, dynamic> json) =>
      _$AuthorLevelFromJson(json);
}
