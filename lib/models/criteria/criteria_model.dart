import 'package:audiory_v0/models/AuthUser.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'criteria_model.freezed.dart'; //get the file name same as the class file name
part 'criteria_model.g.dart';

@freezed
class Criteria with _$Criteria {
  //category duplicate with annatation category class
  const factory Criteria({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @Default('') @JsonKey(name: 'description') String? description,
    @Default('') @JsonKey(name: 'name') String? name,
    @Default(0) @JsonKey(name: 'value') int? value,
    @Default(false) @JsonKey(name: 'is_passed') bool? isPassed,
  }) = _Criteria;

  factory Criteria.fromJson(Map<String, dynamic> json) =>
      _$CriteriaFromJson(json);
}
