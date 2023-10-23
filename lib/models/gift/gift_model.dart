import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift_model.freezed.dart'; //get the file name same as the class file name
part 'gift_model.g.dart';

@freezed
class Gift with _$Gift {
  //category duplicate with annatation category class
  const factory Gift({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id, //int
    @Default('') @JsonKey(name: 'name') String? name,
    @Default('') @JsonKey(name: 'description') String? description,
    @Default('') @JsonKey(name: 'image_url') String? imageUrl,
    @Default(0) @JsonKey(name: 'price') int? price,
    @JsonKey(name: 'created_date') String? createdDate,
    @JsonKey(name: 'updated_date') String? updatedDate,
  }) = _Gift;

  factory Gift.fromJson(Map<String, dynamic> json) => _$GiftFromJson(json);
}
