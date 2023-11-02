// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError; //int
  @JsonKey(name: 'content')
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_id')
  String? get conversationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'receiver_id')
  String? get receiverId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id')
  String? get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_read')
  bool? get isRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender')
  AuthUser? get sender => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  String? get createdDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'conversation_id') String? conversationId,
      @JsonKey(name: 'receiver_id') String? receiverId,
      @JsonKey(name: 'sender_id') String? senderId,
      @JsonKey(name: 'is_read') bool? isRead,
      @JsonKey(name: 'sender') AuthUser? sender,
      @JsonKey(name: 'created_date') String? createdDate});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = freezed,
    Object? conversationId = freezed,
    Object? receiverId = freezed,
    Object? senderId = freezed,
    Object? isRead = freezed,
    Object? sender = freezed,
    Object? createdDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as AuthUser?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'conversation_id') String? conversationId,
      @JsonKey(name: 'receiver_id') String? receiverId,
      @JsonKey(name: 'sender_id') String? senderId,
      @JsonKey(name: 'is_read') bool? isRead,
      @JsonKey(name: 'sender') AuthUser? sender,
      @JsonKey(name: 'created_date') String? createdDate});
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = freezed,
    Object? conversationId = freezed,
    Object? receiverId = freezed,
    Object? senderId = freezed,
    Object? isRead = freezed,
    Object? sender = freezed,
    Object? createdDate = freezed,
  }) {
    return _then(_$MessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as AuthUser?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl(
      {@JsonKey(name: 'id') this.id = '',
      @JsonKey(name: 'content') this.content = '',
      @JsonKey(name: 'conversation_id') this.conversationId = '',
      @JsonKey(name: 'receiver_id') this.receiverId = '',
      @JsonKey(name: 'sender_id') this.senderId = '',
      @JsonKey(name: 'is_read') this.isRead = false,
      @JsonKey(name: 'sender') this.sender,
      @JsonKey(name: 'created_date') this.createdDate = ''});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
//int
  @override
  @JsonKey(name: 'content')
  final String? content;
  @override
  @JsonKey(name: 'conversation_id')
  final String? conversationId;
  @override
  @JsonKey(name: 'receiver_id')
  final String? receiverId;
  @override
  @JsonKey(name: 'sender_id')
  final String? senderId;
  @override
  @JsonKey(name: 'is_read')
  final bool? isRead;
  @override
  @JsonKey(name: 'sender')
  final AuthUser? sender;
  @override
  @JsonKey(name: 'created_date')
  final String? createdDate;

  @override
  String toString() {
    return 'Message(id: $id, content: $content, conversationId: $conversationId, receiverId: $receiverId, senderId: $senderId, isRead: $isRead, sender: $sender, createdDate: $createdDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, content, conversationId,
      receiverId, senderId, isRead, sender, createdDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
          {@JsonKey(name: 'id') final String id,
          @JsonKey(name: 'content') final String? content,
          @JsonKey(name: 'conversation_id') final String? conversationId,
          @JsonKey(name: 'receiver_id') final String? receiverId,
          @JsonKey(name: 'sender_id') final String? senderId,
          @JsonKey(name: 'is_read') final bool? isRead,
          @JsonKey(name: 'sender') final AuthUser? sender,
          @JsonKey(name: 'created_date') final String? createdDate}) =
      _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override //int
  @JsonKey(name: 'content')
  String? get content;
  @override
  @JsonKey(name: 'conversation_id')
  String? get conversationId;
  @override
  @JsonKey(name: 'receiver_id')
  String? get receiverId;
  @override
  @JsonKey(name: 'sender_id')
  String? get senderId;
  @override
  @JsonKey(name: 'is_read')
  bool? get isRead;
  @override
  @JsonKey(name: 'sender')
  AuthUser? get sender;
  @override
  @JsonKey(name: 'created_date')
  String? get createdDate;
  @override
  @JsonKey(ignore: true)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
