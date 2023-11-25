// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criteria_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CriteriaImpl _$$CriteriaImplFromJson(Map<String, dynamic> json) =>
    _$CriteriaImpl(
      description: json['description'] as String? ?? '',
      name: json['name'] as String? ?? '',
      value: json['value'] as int? ?? 0,
      isPassed: json['is_passed'] as bool? ?? false,
    );

Map<String, dynamic> _$$CriteriaImplToJson(_$CriteriaImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'name': instance.name,
      'value': instance.value,
      'is_passed': instance.isPassed,
    };
