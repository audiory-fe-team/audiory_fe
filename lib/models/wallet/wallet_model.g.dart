// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Wallet _$$_WalletFromJson(Map<String, dynamic> json) => _$_Wallet(
      id: json['id'] as String,
      userId: json['user_id'] as String? ?? '',
      coinId: json['coin_id'],
      coin: json['coin'] == null
          ? null
          : Coin.fromJson(json['coin'] as Map<String, dynamic>),
      balance: json['balance'],
    );

Map<String, dynamic> _$$_WalletToJson(_$_Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'coin_id': instance.coinId,
      'coin': instance.coin?.toJson(),
      'balance': instance.balance,
    };
