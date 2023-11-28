import 'package:audiory_v0/models/enums/Report.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_model.freezed.dart'; //get the file name same as the class file name
part 'report_model.g.dart';

@freezed
class Report with _$Report {
  //category duplicate with annatation category class
  const factory Report({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @Default('') @JsonKey(name: 'user_id') String? userId,
    @Default('') @JsonKey(name: 'reported_id') String? reportedId,
    @Default('COMMENT') @JsonKey(name: 'report_type') String? reportedType,
    @Default('') @JsonKey(name: 'title') String? title,
    @Default('') @JsonKey(name: 'description') String? description,
    @Default('') @JsonKey(name: 'image_url') String? imageUrl,
    @Default('') @JsonKey(name: 'created_date') String? createdDate,
    @Default('') @JsonKey(name: 'updated_date') String? updatedDate,
    @Default('') @JsonKey(name: 'approved_date') String? approvedDate,
    @Default('') @JsonKey(name: 'approved_by') String? approvedBy,
    @Default('') @JsonKey(name: 'rejected_date') String? rejectedDate,
    @Default('') @JsonKey(name: 'rejected_by') String? rejectedBy,
    @Default('') @JsonKey(name: 'report_status') String? reportStatus,
    @Default('') @JsonKey(name: 'response_message') String? responseMessage,
    @Default(true) @JsonKey(name: 'is_enabled') bool? isEnabled,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}
