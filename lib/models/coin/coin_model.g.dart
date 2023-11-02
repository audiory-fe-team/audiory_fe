// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoinImpl _$$CoinImplFromJson(Map<String, dynamic> json) => _$CoinImpl(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      value: json['value'],
      imageUrl: json['image_url'] as String? ?? '',
      createdDate: json['created_date'] as String? ?? '',
      updatedDate: json['updated_date'] as String? ?? '',
    );

Map<String, dynamic> _$$CoinImplToJson(_$CoinImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'image_url': instance.imageUrl,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
    };
