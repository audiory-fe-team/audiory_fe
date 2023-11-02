// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'author_story_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthorStory _$AuthorStoryFromJson(Map<String, dynamic> json) {
  return _AuthorStory.fromJson(json);
}

/// @nodoc
mixin _$AuthorStory {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String? get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'sex')
  String? get sex => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'registration_tokens')
  String? get registrationTokens => throw _privateConstructorUsedError;
  @JsonKey(name: 'role_id')
  String? get roleId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthorStoryCopyWith<AuthorStory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorStoryCopyWith<$Res> {
  factory $AuthorStoryCopyWith(
          AuthorStory value, $Res Function(AuthorStory) then) =
      _$AuthorStoryCopyWithImpl<$Res, AuthorStory>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'full_name') String? fullName,
      @JsonKey(name: 'sex') String? sex,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'registration_tokens') String? registrationTokens,
      @JsonKey(name: 'role_id') String? roleId});
}

/// @nodoc
class _$AuthorStoryCopyWithImpl<$Res, $Val extends AuthorStory>
    implements $AuthorStoryCopyWith<$Res> {
  _$AuthorStoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = freezed,
    Object? sex = freezed,
    Object? avatarUrl = freezed,
    Object? registrationTokens = freezed,
    Object? roleId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      sex: freezed == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationTokens: freezed == registrationTokens
          ? _value.registrationTokens
          : registrationTokens // ignore: cast_nullable_to_non_nullable
              as String?,
      roleId: freezed == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthorStoryImplCopyWith<$Res>
    implements $AuthorStoryCopyWith<$Res> {
  factory _$$AuthorStoryImplCopyWith(
          _$AuthorStoryImpl value, $Res Function(_$AuthorStoryImpl) then) =
      __$$AuthorStoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'full_name') String? fullName,
      @JsonKey(name: 'sex') String? sex,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'registration_tokens') String? registrationTokens,
      @JsonKey(name: 'role_id') String? roleId});
}

/// @nodoc
class __$$AuthorStoryImplCopyWithImpl<$Res>
    extends _$AuthorStoryCopyWithImpl<$Res, _$AuthorStoryImpl>
    implements _$$AuthorStoryImplCopyWith<$Res> {
  __$$AuthorStoryImplCopyWithImpl(
      _$AuthorStoryImpl _value, $Res Function(_$AuthorStoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = freezed,
    Object? sex = freezed,
    Object? avatarUrl = freezed,
    Object? registrationTokens = freezed,
    Object? roleId = freezed,
  }) {
    return _then(_$AuthorStoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      sex: freezed == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationTokens: freezed == registrationTokens
          ? _value.registrationTokens
          : registrationTokens // ignore: cast_nullable_to_non_nullable
              as String?,
      roleId: freezed == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthorStoryImpl implements _AuthorStory {
  const _$AuthorStoryImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'full_name') this.fullName = '',
      @JsonKey(name: 'sex') this.sex = '',
      @JsonKey(name: 'avatar_url') this.avatarUrl = '',
      @JsonKey(name: 'registration_tokens') this.registrationTokens = '',
      @JsonKey(name: 'role_id') this.roleId = ''});

  factory _$AuthorStoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthorStoryImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'full_name')
  final String? fullName;
  @override
  @JsonKey(name: 'sex')
  final String? sex;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'registration_tokens')
  final String? registrationTokens;
  @override
  @JsonKey(name: 'role_id')
  final String? roleId;

  @override
  String toString() {
    return 'AuthorStory(id: $id, fullName: $fullName, sex: $sex, avatarUrl: $avatarUrl, registrationTokens: $registrationTokens, roleId: $roleId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorStoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.registrationTokens, registrationTokens) ||
                other.registrationTokens == registrationTokens) &&
            (identical(other.roleId, roleId) || other.roleId == roleId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, fullName, sex, avatarUrl, registrationTokens, roleId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthorStoryImplCopyWith<_$AuthorStoryImpl> get copyWith =>
      __$$AuthorStoryImplCopyWithImpl<_$AuthorStoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthorStoryImplToJson(
      this,
    );
  }
}

abstract class _AuthorStory implements AuthorStory {
  const factory _AuthorStory(
      {@JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'full_name') final String? fullName,
      @JsonKey(name: 'sex') final String? sex,
      @JsonKey(name: 'avatar_url') final String? avatarUrl,
      @JsonKey(name: 'registration_tokens') final String? registrationTokens,
      @JsonKey(name: 'role_id') final String? roleId}) = _$AuthorStoryImpl;

  factory _AuthorStory.fromJson(Map<String, dynamic> json) =
      _$AuthorStoryImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'full_name')
  String? get fullName;
  @override
  @JsonKey(name: 'sex')
  String? get sex;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'registration_tokens')
  String? get registrationTokens;
  @override
  @JsonKey(name: 'role_id')
  String? get roleId;
  @override
  @JsonKey(ignore: true)
  _$$AuthorStoryImplCopyWith<_$AuthorStoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
