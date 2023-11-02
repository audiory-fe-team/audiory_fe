// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppCategoryImpl _$$AppCategoryImplFromJson(Map<String, dynamic> json) =>
    _$AppCategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      createdDate: json['created_date'] as String? ?? '',
      updatedDate: json['updated_date'] as String? ?? '',
      isEnabled: json['is_enabled'] as bool?,
    );

Map<String, dynamic> _$$AppCategoryImplToJson(_$AppCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
      'is_enabled': instance.isEnabled,
    };
