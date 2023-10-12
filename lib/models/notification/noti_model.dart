import 'package:audiory_v0/models/activity/activity_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'noti_model.freezed.dart'; //get the file name same as the class file name
part 'noti_model.g.dart';

@freezed
class Noti with _$Noti {
  const factory Noti({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'activity') required Activity activity,
    @JsonKey(name: 'activity_id') String? activityId,
    @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'is_read') bool? isRead,
  }) = _Noti;

  factory Noti.fromJson(Map<String, dynamic> json) => _$NotiFromJson(json);
}
