// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String? ?? '',
      content: json['content'] as String? ?? '',
      conversationId: json['conversation_id'] as String? ?? '',
      receiverId: json['receiver_id'] as String? ?? '',
      senderId: json['sender_id'] as String? ?? '',
      isRead: json['is_read'] as bool? ?? false,
      sender: json['sender'] == null
          ? null
          : AuthUser.fromJson(json['sender'] as Map<String, dynamic>),
      createdDate: json['created_date'] as String? ?? '',
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'conversation_id': instance.conversationId,
      'receiver_id': instance.receiverId,
      'sender_id': instance.senderId,
      'is_read': instance.isRead,
      'sender': instance.sender?.toJson(),
      'created_date': instance.createdDate,
    };
