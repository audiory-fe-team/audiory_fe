// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'noti_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Noti _$NotiFromJson(Map<String, dynamic> json) {
  return _Noti.fromJson(json);
}

/// @nodoc
mixin _$Noti {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'activity')
  Activity get activity => throw _privateConstructorUsedError;
  @JsonKey(name: 'activity_id')
  String? get activityId => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_read')
  bool? get isRead => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotiCopyWith<Noti> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotiCopyWith<$Res> {
  factory $NotiCopyWith(Noti value, $Res Function(Noti) then) =
      _$NotiCopyWithImpl<$Res, Noti>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'activity') Activity activity,
      @JsonKey(name: 'activity_id') String? activityId,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'is_read') bool? isRead});

  $ActivityCopyWith<$Res> get activity;
}

/// @nodoc
class _$NotiCopyWithImpl<$Res, $Val extends Noti>
    implements $NotiCopyWith<$Res> {
  _$NotiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? activity = null,
    Object? activityId = freezed,
    Object? content = freezed,
    Object? isRead = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      activity: null == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as Activity,
      activityId: freezed == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ActivityCopyWith<$Res> get activity {
    return $ActivityCopyWith<$Res>(_value.activity, (value) {
      return _then(_value.copyWith(activity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotiImplCopyWith<$Res> implements $NotiCopyWith<$Res> {
  factory _$$NotiImplCopyWith(
          _$NotiImpl value, $Res Function(_$NotiImpl) then) =
      __$$NotiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'activity') Activity activity,
      @JsonKey(name: 'activity_id') String? activityId,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'is_read') bool? isRead});

  @override
  $ActivityCopyWith<$Res> get activity;
}

/// @nodoc
class __$$NotiImplCopyWithImpl<$Res>
    extends _$NotiCopyWithImpl<$Res, _$NotiImpl>
    implements _$$NotiImplCopyWith<$Res> {
  __$$NotiImplCopyWithImpl(_$NotiImpl _value, $Res Function(_$NotiImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? activity = null,
    Object? activityId = freezed,
    Object? content = freezed,
    Object? isRead = freezed,
  }) {
    return _then(_$NotiImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      activity: null == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as Activity,
      activityId: freezed == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotiImpl implements _Noti {
  const _$NotiImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'activity') required this.activity,
      @JsonKey(name: 'activity_id') this.activityId,
      @JsonKey(name: 'content') this.content,
      @JsonKey(name: 'is_read') this.isRead});

  factory _$NotiImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotiImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'activity')
  final Activity activity;
  @override
  @JsonKey(name: 'activity_id')
  final String? activityId;
  @override
  @JsonKey(name: 'content')
  final String? content;
  @override
  @JsonKey(name: 'is_read')
  final bool? isRead;

  @override
  String toString() {
    return 'Noti(id: $id, activity: $activity, activityId: $activityId, content: $content, isRead: $isRead)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotiImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.activityId, activityId) ||
                other.activityId == activityId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, activity, activityId, content, isRead);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotiImplCopyWith<_$NotiImpl> get copyWith =>
      __$$NotiImplCopyWithImpl<_$NotiImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotiImplToJson(
      this,
    );
  }
}

abstract class _Noti implements Noti {
  const factory _Noti(
      {@JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'activity') required final Activity activity,
      @JsonKey(name: 'activity_id') final String? activityId,
      @JsonKey(name: 'content') final String? content,
      @JsonKey(name: 'is_read') final bool? isRead}) = _$NotiImpl;

  factory _Noti.fromJson(Map<String, dynamic> json) = _$NotiImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'activity')
  Activity get activity;
  @override
  @JsonKey(name: 'activity_id')
  String? get activityId;
  @override
  @JsonKey(name: 'content')
  String? get content;
  @override
  @JsonKey(name: 'is_read')
  bool? get isRead;
  @override
  @JsonKey(ignore: true)
  _$$NotiImplCopyWith<_$NotiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
