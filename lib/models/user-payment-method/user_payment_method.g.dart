// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserPaymentMethodImpl _$$UserPaymentMethodImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPaymentMethodImpl(
      id: json['id'] as String,
      paymentMethodId: json['payment_method_id'] as int? ?? 0,
      createdDate: json['created_date'] as String? ?? '',
      account: json['account'] as String? ?? '',
      accountName: json['account_name'] as String? ?? '',
      updatedDate: json['updated_date'] as String? ?? '',
    );

Map<String, dynamic> _$$UserPaymentMethodImplToJson(
        _$UserPaymentMethodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payment_method_id': instance.paymentMethodId,
      'created_date': instance.createdDate,
      'account': instance.account,
      'account_name': instance.accountName,
      'updated_date': instance.updatedDate,
    };
