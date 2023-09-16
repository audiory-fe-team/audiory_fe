// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Tag _$$_TagFromJson(Map<String, dynamic> json) => _$_Tag(
      id: json['id'] as String? ?? '',
      name: json['name'] as String?,
      createdDate: json['created_date'] as String?,
      updatedDate: json['updated_date'] as String?,
      isEnabled: json['is_enabled'] as bool?,
      worksTotal: json['works_total'] as int?,
    );

Map<String, dynamic> _$$_TagToJson(_$_Tag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
      'is_enabled': instance.isEnabled,
      'works_total': instance.worksTotal,
    };
