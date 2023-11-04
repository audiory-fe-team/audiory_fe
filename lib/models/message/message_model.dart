import 'package:audiory_v0/models/AuthUser.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart'; //get the file name same as the class file name
part 'message_model.g.dart';

@freezed
class Message with _$Message {
  //category duplicate with annatation category class
  const factory Message({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @Default('') @JsonKey(name: 'id') String id, //int
    @Default('') @JsonKey(name: 'content') String? content,
    @Default('') @JsonKey(name: 'conversation_id') String? conversationId,
    @Default('') @JsonKey(name: 'receiver_id') String? receiverId,
    @Default('') @JsonKey(name: 'sender_id') String? senderId,
    @Default(false) @JsonKey(name: 'is_read') bool? isRead,
    @JsonKey(name: 'sender') AuthUser? sender,
    @Default('') @JsonKey(name: 'created_date') String? createdDate,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
