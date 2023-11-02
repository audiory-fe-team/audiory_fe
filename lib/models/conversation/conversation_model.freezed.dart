// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError; //int
  @JsonKey(name: 'last_active')
  String? get lastActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_url')
  String? get coverUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'receiver_id')
  String? get receiverId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'messages')
  List<Message>? get messages => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message')
  Message? get lastMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) then) =
      _$ConversationCopyWithImpl<$Res, Conversation>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'last_active') String? lastActive,
      @JsonKey(name: 'cover_url') String? coverUrl,
      @JsonKey(name: 'receiver_id') String? receiverId,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'messages') List<Message>? messages,
      @JsonKey(name: 'last_message') Message? lastMessage});

  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res, $Val extends Conversation>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastActive = freezed,
    Object? coverUrl = freezed,
    Object? receiverId = freezed,
    Object? name = freezed,
    Object? messages = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lastActive: freezed == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as String?,
      coverUrl: freezed == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $MessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConversationImplCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$ConversationImplCopyWith(
          _$ConversationImpl value, $Res Function(_$ConversationImpl) then) =
      __$$ConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'last_active') String? lastActive,
      @JsonKey(name: 'cover_url') String? coverUrl,
      @JsonKey(name: 'receiver_id') String? receiverId,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'messages') List<Message>? messages,
      @JsonKey(name: 'last_message') Message? lastMessage});

  @override
  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ConversationImplCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res, _$ConversationImpl>
    implements _$$ConversationImplCopyWith<$Res> {
  __$$ConversationImplCopyWithImpl(
      _$ConversationImpl _value, $Res Function(_$ConversationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastActive = freezed,
    Object? coverUrl = freezed,
    Object? receiverId = freezed,
    Object? name = freezed,
    Object? messages = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(_$ConversationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lastActive: freezed == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as String?,
      coverUrl: freezed == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: freezed == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationImpl implements _Conversation {
  const _$ConversationImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'last_active') this.lastActive = '',
      @JsonKey(name: 'cover_url') this.coverUrl = '',
      @JsonKey(name: 'receiver_id') this.receiverId = '',
      @JsonKey(name: 'name') this.name = '',
      @JsonKey(name: 'messages') final List<Message>? messages = const [],
      @JsonKey(name: 'last_message') this.lastMessage = null})
      : _messages = messages;

  factory _$ConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
//int
  @override
  @JsonKey(name: 'last_active')
  final String? lastActive;
  @override
  @JsonKey(name: 'cover_url')
  final String? coverUrl;
  @override
  @JsonKey(name: 'receiver_id')
  final String? receiverId;
  @override
  @JsonKey(name: 'name')
  final String? name;
  final List<Message>? _messages;
  @override
  @JsonKey(name: 'messages')
  List<Message>? get messages {
    final value = _messages;
    if (value == null) return null;
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'last_message')
  final Message? lastMessage;

  @override
  String toString() {
    return 'Conversation(id: $id, lastActive: $lastActive, coverUrl: $coverUrl, receiverId: $receiverId, name: $name, messages: $messages, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      lastActive,
      coverUrl,
      receiverId,
      name,
      const DeepCollectionEquality().hash(_messages),
      lastMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      __$$ConversationImplCopyWithImpl<_$ConversationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationImplToJson(
      this,
    );
  }
}

abstract class _Conversation implements Conversation {
  const factory _Conversation(
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'last_active') final String? lastActive,
          @JsonKey(name: 'cover_url') final String? coverUrl,
          @JsonKey(name: 'receiver_id') final String? receiverId,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'messages') final List<Message>? messages,
          @JsonKey(name: 'last_message') final Message? lastMessage}) =
      _$ConversationImpl;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$ConversationImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override //int
  @JsonKey(name: 'last_active')
  String? get lastActive;
  @override
  @JsonKey(name: 'cover_url')
  String? get coverUrl;
  @override
  @JsonKey(name: 'receiver_id')
  String? get receiverId;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'messages')
  List<Message>? get messages;
  @override
  @JsonKey(name: 'last_message')
  Message? get lastMessage;
  @override
  @JsonKey(ignore: true)
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
