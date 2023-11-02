// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noti_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotiImpl _$$NotiImplFromJson(Map<String, dynamic> json) => _$NotiImpl(
      id: json['id'] as String,
      activity: Activity.fromJson(json['activity'] as Map<String, dynamic>),
      activityId: json['activity_id'] as String?,
      content: json['content'] as String?,
      isRead: json['is_read'] as bool?,
    );

Map<String, dynamic> _$$NotiImplToJson(_$NotiImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activity': instance.activity.toJson(),
      'activity_id': instance.activityId,
      'content': instance.content,
      'is_read': instance.isRead,
    };
