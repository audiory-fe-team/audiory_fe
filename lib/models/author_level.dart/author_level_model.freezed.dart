// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'author_level_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthorLevel _$AuthorLevelFromJson(Map<String, dynamic> json) {
  return _AuthorLevel.fromJson(json);
}

/// @nodoc
mixin _$AuthorLevel {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError; //int
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_enabled')
  bool? get isEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  String? get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_date')
  String? get updatedDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthorLevelCopyWith<AuthorLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorLevelCopyWith<$Res> {
  factory $AuthorLevelCopyWith(
          AuthorLevel value, $Res Function(AuthorLevel) then) =
      _$AuthorLevelCopyWithImpl<$Res, AuthorLevel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'is_enabled') bool? isEnabled,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate});
}

/// @nodoc
class _$AuthorLevelCopyWithImpl<$Res, $Val extends AuthorLevel>
    implements $AuthorLevelCopyWith<$Res> {
  _$AuthorLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? isEnabled = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isEnabled: freezed == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthorLevelImplCopyWith<$Res>
    implements $AuthorLevelCopyWith<$Res> {
  factory _$$AuthorLevelImplCopyWith(
          _$AuthorLevelImpl value, $Res Function(_$AuthorLevelImpl) then) =
      __$$AuthorLevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'is_enabled') bool? isEnabled,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate});
}

/// @nodoc
class __$$AuthorLevelImplCopyWithImpl<$Res>
    extends _$AuthorLevelCopyWithImpl<$Res, _$AuthorLevelImpl>
    implements _$$AuthorLevelImplCopyWith<$Res> {
  __$$AuthorLevelImplCopyWithImpl(
      _$AuthorLevelImpl _value, $Res Function(_$AuthorLevelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? isEnabled = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
  }) {
    return _then(_$AuthorLevelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isEnabled: freezed == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthorLevelImpl implements _AuthorLevel {
  const _$AuthorLevelImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') this.name = '',
      @JsonKey(name: 'is_enabled') this.isEnabled = true,
      @JsonKey(name: 'created_date') this.createdDate,
      @JsonKey(name: 'updated_date') this.updatedDate});

  factory _$AuthorLevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthorLevelImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final int id;
//int
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'is_enabled')
  final bool? isEnabled;
  @override
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @override
  @JsonKey(name: 'updated_date')
  final String? updatedDate;

  @override
  String toString() {
    return 'AuthorLevel(id: $id, name: $name, isEnabled: $isEnabled, createdDate: $createdDate, updatedDate: $updatedDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorLevelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, isEnabled, createdDate, updatedDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthorLevelImplCopyWith<_$AuthorLevelImpl> get copyWith =>
      __$$AuthorLevelImplCopyWithImpl<_$AuthorLevelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthorLevelImplToJson(
      this,
    );
  }
}

abstract class _AuthorLevel implements AuthorLevel {
  const factory _AuthorLevel(
          {@JsonKey(name: 'id') required final int id,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'is_enabled') final bool? isEnabled,
          @JsonKey(name: 'created_date') final String? createdDate,
          @JsonKey(name: 'updated_date') final String? updatedDate}) =
      _$AuthorLevelImpl;

  factory _AuthorLevel.fromJson(Map<String, dynamic> json) =
      _$AuthorLevelImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  int get id;
  @override //int
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'is_enabled')
  bool? get isEnabled;
  @override
  @JsonKey(name: 'created_date')
  String? get createdDate;
  @override
  @JsonKey(name: 'updated_date')
  String? get updatedDate;
  @override
  @JsonKey(ignore: true)
  _$$AuthorLevelImplCopyWith<_$AuthorLevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
