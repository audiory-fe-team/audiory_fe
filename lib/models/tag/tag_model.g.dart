// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagImpl _$$TagImplFromJson(Map<String, dynamic> json) => _$TagImpl(
      id: json['id'] as String,
      createdDate: json['created_date'] as String? ?? '',
      isEnabled: json['is_enabled'] as bool?,
      name: json['name'] as String? ?? '',
      updatedDate: json['updated_date'] as String? ?? '',
      worksTotal: json['works_total'] as int? ?? 0,
    );

Map<String, dynamic> _$$TagImplToJson(_$TagImpl instance) => <String, dynamic>{
      'id': instance.id,
      'created_date': instance.createdDate,
      'is_enabled': instance.isEnabled,
      'name': instance.name,
      'updated_date': instance.updatedDate,
      'works_total': instance.worksTotal,
    };
