import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_category_model.freezed.dart'; //get the file name same as the class file name
part 'app_category_model.g.dart';

@freezed
class AppCategory with _$AppCategory {
  //category duplicate with annatation category class
  const factory AppCategory({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @Default('') @JsonKey(name: 'name') String? name,
    @Default('') @JsonKey(name: 'image_url') String? imageUrl,
    @Default('') @JsonKey(name: 'created_date') String? createdDate,
    @Default('') @JsonKey(name: 'updated_date') String? updatedDate,
    @JsonKey(name: 'is_enabled') bool? isEnabled,
  }) = _AppCategory;

  factory AppCategory.fromJson(Map<String, dynamic> json) =>
      _$AppCategoryFromJson(json);
}
