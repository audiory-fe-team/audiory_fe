import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin_model.freezed.dart'; //get the file name same as the class file name
part 'coin_model.g.dart';

@freezed
class Coin with _$Coin {
  //category duplicate with annatation category class
  const factory Coin({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required int id, //int
    @Default('') @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'value') dynamic value,
    @Default('') @JsonKey(name: 'image_url') String? imageUrl,
    @Default('') @JsonKey(name: 'created_date') String? createdDate,
    @Default('') @JsonKey(name: 'updated_date') String? updatedDate,
  }) = _Coin;

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);
}
