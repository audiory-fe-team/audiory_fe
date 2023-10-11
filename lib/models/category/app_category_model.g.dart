// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppCategory _$$_AppCategoryFromJson(Map<String, dynamic> json) =>
    _$_AppCategory(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      createdDate: json['created_date'] as String? ?? '',
      updatedDate: json['updated_date'] as String? ?? '',
      isEnabled: json['is_enabled'] as bool?,
    );

Map<String, dynamic> _$$_AppCategoryToJson(_$_AppCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
      'is_enabled': instance.isEnabled,
    };
