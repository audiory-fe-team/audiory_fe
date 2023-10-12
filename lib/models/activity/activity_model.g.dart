// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Activity _$$_ActivityFromJson(Map<String, dynamic> json) => _$_Activity(
      id: json['id'] as String,
      actionEntity: json['action_entity'] as String,
      entityId: json['entity_id'] as String,
      user: json['user'] == null
          ? null
          : Profile.fromJson(json['user'] as Map<String, dynamic>),
      userId: json['user_id'] as String,
      actionType: json['action_type'] as String?,
      createdDate: json['created_date'] as String?,
    );

Map<String, dynamic> _$$_ActivityToJson(_$_Activity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action_entity': instance.actionEntity,
      'entity_id': instance.entityId,
      'user': instance.user?.toJson(),
      'user_id': instance.userId,
      'action_type': instance.actionType,
      'created_date': instance.createdDate,
    };
