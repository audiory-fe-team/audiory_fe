// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_payment_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserPaymenthMethod _$UserPaymenthMethodFromJson(Map<String, dynamic> json) {
  return _UserPaymenthMethod.fromJson(json);
}

/// @nodoc
mixin _$UserPaymenthMethod {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  String? get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'account')
  String? get account => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_name')
  String? get accountName => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_date')
  String? get updatedDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserPaymenthMethodCopyWith<UserPaymenthMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPaymenthMethodCopyWith<$Res> {
  factory $UserPaymenthMethodCopyWith(
          UserPaymenthMethod value, $Res Function(UserPaymenthMethod) then) =
      _$UserPaymenthMethodCopyWithImpl<$Res, UserPaymenthMethod>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'account') String? account,
      @JsonKey(name: 'account_name') String? accountName,
      @JsonKey(name: 'updated_date') String? updatedDate});
}

/// @nodoc
class _$UserPaymenthMethodCopyWithImpl<$Res, $Val extends UserPaymenthMethod>
    implements $UserPaymenthMethodCopyWith<$Res> {
  _$UserPaymenthMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdDate = freezed,
    Object? account = freezed,
    Object? accountName = freezed,
    Object? updatedDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String?,
      accountName: freezed == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPaymenthMethodImplCopyWith<$Res>
    implements $UserPaymenthMethodCopyWith<$Res> {
  factory _$$UserPaymenthMethodImplCopyWith(_$UserPaymenthMethodImpl value,
          $Res Function(_$UserPaymenthMethodImpl) then) =
      __$$UserPaymenthMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'account') String? account,
      @JsonKey(name: 'account_name') String? accountName,
      @JsonKey(name: 'updated_date') String? updatedDate});
}

/// @nodoc
class __$$UserPaymenthMethodImplCopyWithImpl<$Res>
    extends _$UserPaymenthMethodCopyWithImpl<$Res, _$UserPaymenthMethodImpl>
    implements _$$UserPaymenthMethodImplCopyWith<$Res> {
  __$$UserPaymenthMethodImplCopyWithImpl(_$UserPaymenthMethodImpl _value,
      $Res Function(_$UserPaymenthMethodImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdDate = freezed,
    Object? account = freezed,
    Object? accountName = freezed,
    Object? updatedDate = freezed,
  }) {
    return _then(_$UserPaymenthMethodImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String?,
      accountName: freezed == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
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
class _$UserPaymenthMethodImpl implements _UserPaymenthMethod {
  const _$UserPaymenthMethodImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'created_date') this.createdDate = '',
      @JsonKey(name: 'account') this.account = '',
      @JsonKey(name: 'account_name') this.accountName = '',
      @JsonKey(name: 'updated_date') this.updatedDate = ''});

  factory _$UserPaymenthMethodImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPaymenthMethodImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @override
  @JsonKey(name: 'account')
  final String? account;
  @override
  @JsonKey(name: 'account_name')
  final String? accountName;
  @override
  @JsonKey(name: 'updated_date')
  final String? updatedDate;

  @override
  String toString() {
    return 'UserPaymenthMethod(id: $id, createdDate: $createdDate, account: $account, accountName: $accountName, updatedDate: $updatedDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPaymenthMethodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, createdDate, account, accountName, updatedDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPaymenthMethodImplCopyWith<_$UserPaymenthMethodImpl> get copyWith =>
      __$$UserPaymenthMethodImplCopyWithImpl<_$UserPaymenthMethodImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPaymenthMethodImplToJson(
      this,
    );
  }
}

abstract class _UserPaymenthMethod implements UserPaymenthMethod {
  const factory _UserPaymenthMethod(
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'created_date') final String? createdDate,
          @JsonKey(name: 'account') final String? account,
          @JsonKey(name: 'account_name') final String? accountName,
          @JsonKey(name: 'updated_date') final String? updatedDate}) =
      _$UserPaymenthMethodImpl;

  factory _UserPaymenthMethod.fromJson(Map<String, dynamic> json) =
      _$UserPaymenthMethodImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'created_date')
  String? get createdDate;
  @override
  @JsonKey(name: 'account')
  String? get account;
  @override
  @JsonKey(name: 'account_name')
  String? get accountName;
  @override
  @JsonKey(name: 'updated_date')
  String? get updatedDate;
  @override
  @JsonKey(ignore: true)
  _$$UserPaymenthMethodImplCopyWith<_$UserPaymenthMethodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
