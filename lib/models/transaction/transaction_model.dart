import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart'; //get the file name same as the class file name
part 'transaction_model.g.dart';

@freezed
class Transaction with _$Transaction {
  //category duplicate with annatation category class
  const factory Transaction({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @Default('') @JsonKey(name: 'user_id') String? userId,
    @Default('') @JsonKey(name: 'product_type') String? productType,
    @Default('') @JsonKey(name: 'product_id') String? productId,
    @Default('') @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'coin_id') int? coinId,
    @JsonKey(name: 'total_price') dynamic totalPrice, //can be int or double
    @JsonKey(name: 'total_price_after_commission')
    dynamic totalPriceAfterCommission,
    @JsonKey(name: 'transaction_type') String? transactionType,
    @Default('') @JsonKey(name: 'transaction_status') String? transactionStatus,
    @Default('') @JsonKey(name: 'created_date') String? createdDate,
    @Default('') @JsonKey(name: 'updated_date') String? updatedDate,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
