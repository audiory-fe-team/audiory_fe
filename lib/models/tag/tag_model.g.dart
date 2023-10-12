// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Tag _$$_TagFromJson(Map<String, dynamic> json) => _$_Tag(
      id: json['id'] as String,
      createdDate: json['created_date'] as String? ?? '',
      isEnabled: json['is_enabled'] as bool?,
      name: json['name'] as String? ?? '',
      updatedDate: json['updated_date'] as String? ?? '',
      worksTotal: json['works_total'] as int? ?? 0,
    );

Map<String, dynamic> _$$_TagToJson(_$_Tag instance) => <String, dynamic>{
      'id': instance.id,
      'created_date': instance.createdDate,
      'is_enabled': instance.isEnabled,
      'name': instance.name,
      'updated_date': instance.updatedDate,
      'works_total': instance.worksTotal,
    };
