// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Transaction _$$_TransactionFromJson(Map<String, dynamic> json) =>
    _$_Transaction(
      id: json['id'] as String,
      userId: json['user_id'] as String? ?? '',
      productType: json['product_type'] as String? ?? '',
      productId: json['product_id'] as String? ?? '',
      productName: json['product_name'] as String? ?? '',
      coinId: json['coin_id'] as int?,
      totalPrice: json['total_price'],
      totalPriceAfterCommission: json['total_price_after_commission'],
      transactionType: json['transaction_type'] as String?,
      transactionStatus: json['transaction_status'] as String? ?? '',
      createdDate: json['created_date'] as String? ?? '',
      updatedDate: json['updated_date'] as String? ?? '',
    );

Map<String, dynamic> _$$_TransactionToJson(_$_Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'product_type': instance.productType,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'coin_id': instance.coinId,
      'total_price': instance.totalPrice,
      'total_price_after_commission': instance.totalPriceAfterCommission,
      'transaction_type': instance.transactionType,
      'transaction_status': instance.transactionStatus,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
    };
