import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_model.freezed.dart'; //get the file name same as the class file name
part 'streak_model.g.dart';

@freezed
class Streak with _$Streak {
  const factory Streak({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'name') required String name,
    @Default(false) @JsonKey(name: 'has_received') bool hasReceived,
    @Default(0) @JsonKey(name: 'amount') int? amount,
  }) = _Streak;

  factory Streak.fromJson(Map<String, dynamic> json) => _$StreakFromJson(json);
}
