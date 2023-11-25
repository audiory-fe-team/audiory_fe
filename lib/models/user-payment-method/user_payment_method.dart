import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_payment_method.freezed.dart'; //get the file name same as the class file name
part 'user_payment_method.g.dart';

@freezed
class UserPaymenthMethod with _$UserPaymenthMethod {
  const factory UserPaymenthMethod({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @Default('') @JsonKey(name: 'created_date') String? createdDate,
    @Default('') @JsonKey(name: 'account') String? account,
    @Default('') @JsonKey(name: 'account_name') String? accountName,
    @Default('') @JsonKey(name: 'updated_date') String? updatedDate,
  }) = _UserPaymenthMethod;

  factory UserPaymenthMethod.fromJson(Map<String, dynamic> json) =>
      _$UserPaymenthMethodFromJson(json);
}
