import 'package:audiory_v0/models/story/story_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'frozen_diamond_model.freezed.dart'; //get the file name same as the class file name
part 'frozen_diamond_model.g.dart';

@freezed
class FrozenDiamond with _$FrozenDiamond {
  //category duplicate with annatation category class
  const factory FrozenDiamond({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @Default('') @JsonKey(name: 'story_id') String? storyId,
    @Default(0) @JsonKey(name: 'amount') dynamic? amount,
    @JsonKey(name: 'unfrozen_date') String? unfrozenDate,
    @JsonKey(name: 'story') Story? story,
  }) = _FrozenDiamond;

  factory FrozenDiamond.fromJson(Map<String, dynamic> json) =>
      _$FrozenDiamondFromJson(json);
}
