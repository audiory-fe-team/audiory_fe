import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_model.freezed.dart'; //get the file name same as the class file name
part 'tag_model.g.dart';

@freezed
class Tag with _$Tag {
  const factory Tag({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @Default('') @JsonKey(name: 'created_date') String? createdDate,
    @JsonKey(name: 'is_enabled') bool? isEnabled,
    @Default('') @JsonKey(name: 'name') String? name,
    @Default('') @JsonKey(name: 'updated_date') String? updatedDate,
    @Default(0) @JsonKey(name: 'works_total') int? worksTotal,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
