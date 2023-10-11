import 'package:audiory_v0/models/coin/coin_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.freezed.dart'; //get the file name same as the class file name
part 'wallet_model.g.dart';

@freezed
class Wallet with _$Wallet {
  //category duplicate with annatation category class
  const factory Wallet({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id,
    @Default('') @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'coin_id') dynamic coinId,
    @JsonKey(name: 'coin') Coin? coin,
    @JsonKey(name: 'balance') dynamic balance,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}
