// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletImpl _$$WalletImplFromJson(Map<String, dynamic> json) => _$WalletImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String? ?? '',
      coinId: json['coin_id'],
      coin: json['coin'] == null
          ? null
          : Coin.fromJson(json['coin'] as Map<String, dynamic>),
      balance: json['balance'],
    );

Map<String, dynamic> _$$WalletImplToJson(_$WalletImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'coin_id': instance.coinId,
      'coin': instance.coin?.toJson(),
      'balance': instance.balance,
    };
