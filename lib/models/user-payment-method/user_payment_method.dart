import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_payment_method.freezed.dart'; //get the file name same as the class file name
part 'user_payment_method.g.dart';

@freezed
class UserPaymentMethod with _$UserPaymentMethod {
  const factory UserPaymentMethod({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @Default(0) @JsonKey(name: 'payment_method_id') int? paymentMethodId,
    @Default('') @JsonKey(name: 'created_date') String? createdDate,
    @Default('') @JsonKey(name: 'account') String? account,
    @Default('') @JsonKey(name: 'account_name') String? accountName,
    @Default('') @JsonKey(name: 'updated_date') String? updatedDate,
  }) = _UserPaymentMethod;

  factory UserPaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$UserPaymentMethodFromJson(json);
}
