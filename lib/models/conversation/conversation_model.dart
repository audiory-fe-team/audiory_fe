import 'package:freezed_annotation/freezed_annotation.dart';
import '../message/message_model.dart';

part 'conversation_model.freezed.dart'; //get the file name same as the class file name
part 'conversation_model.g.dart';

@freezed
class Conversation with _$Conversation {
  //category duplicate with annatation category class
  const factory Conversation({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'id') required String id, //int
    @Default('') @JsonKey(name: 'last_active') String? lastActive,
    @Default('') @JsonKey(name: 'cover_url') String? coverUrl,
    @Default('') @JsonKey(name: 'receiver_id') String? receiverId,
    @Default('') @JsonKey(name: 'name') String? name,
    @Default([]) @JsonKey(name: 'messages') List<Message>? messages,
    @Default(null) @JsonKey(name: 'last_message') Message? lastMessage,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
