// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      id: json['id'] as String,
      lastActive: json['last_active'] as String? ?? '',
      coverUrl: json['cover_url'] as String? ?? '',
      receiverId: json['receiver_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastMessage: json['last_message'] == null
          ? null
          : Message.fromJson(json['last_message'] as Map<String, dynamic>),
      isLatestMessageRead: json['is_latest_message_read'] as bool? ?? false,
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'last_active': instance.lastActive,
      'cover_url': instance.coverUrl,
      'receiver_id': instance.receiverId,
      'name': instance.name,
      'messages': instance.messages?.map((e) => e.toJson()).toList(),
      'last_message': instance.lastMessage?.toJson(),
      'is_latest_message_read': instance.isLatestMessageRead,
    };
