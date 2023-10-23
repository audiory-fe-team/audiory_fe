// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Gift _$$_GiftFromJson(Map<String, dynamic> json) => _$_Gift(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      price: json['price'] as int? ?? 0,
      createdDate: json['created_date'] as String?,
      updatedDate: json['updated_date'] as String?,
    );

Map<String, dynamic> _$$_GiftToJson(_$_Gift instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'price': instance.price,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
    };
