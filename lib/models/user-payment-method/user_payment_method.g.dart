// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserPaymenthMethodImpl _$$UserPaymenthMethodImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPaymenthMethodImpl(
      id: json['id'] as String,
      createdDate: json['created_date'] as String? ?? '',
      account: json['account'] as String? ?? '',
      accountName: json['account_name'] as String? ?? '',
      updatedDate: json['updated_date'] as String? ?? '',
    );

Map<String, dynamic> _$$UserPaymenthMethodImplToJson(
        _$UserPaymenthMethodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_date': instance.createdDate,
      'account': instance.account,
      'account_name': instance.accountName,
      'updated_date': instance.updatedDate,
    };
