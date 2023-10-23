import 'package:audiory_v0/models/Profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_model.freezed.dart'; //get the file name same as the class file name
part 'activity_model.g.dart';

@freezed
class Activity with _$Activity {
  const factory Activity({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'action_entity') required String actionEntity,
    @JsonKey(name: 'entity_id') required String entityId,
    @JsonKey(name: 'user') Profile? user,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'action_type') required String? actionType,
    @JsonKey(name: 'created_date') String? createdDate,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}
