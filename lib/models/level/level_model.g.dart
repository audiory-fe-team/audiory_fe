// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LevelImpl _$$LevelImplFromJson(Map<String, dynamic> json) => _$LevelImpl(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      isEnabled: json['is_enabled'] as bool? ?? true,
      createdDate: json['created_date'] as String?,
      updatedDate: json['updated_date'] as String?,
    );

Map<String, dynamic> _$$LevelImplToJson(_$LevelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_enabled': instance.isEnabled,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
    };
