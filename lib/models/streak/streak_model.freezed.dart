// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Streak _$StreakFromJson(Map<String, dynamic> json) {
  return _Streak.fromJson(json);
}

/// @nodoc
mixin _$Streak {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_received')
  bool get hasReceived => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount')
  int? get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StreakCopyWith<Streak> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreakCopyWith<$Res> {
  factory $StreakCopyWith(Streak value, $Res Function(Streak) then) =
      _$StreakCopyWithImpl<$Res, Streak>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'has_received') bool hasReceived,
      @JsonKey(name: 'amount') int? amount});
}

/// @nodoc
class _$StreakCopyWithImpl<$Res, $Val extends Streak>
    implements $StreakCopyWith<$Res> {
  _$StreakCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? hasReceived = null,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      hasReceived: null == hasReceived
          ? _value.hasReceived
          : hasReceived // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreakImplCopyWith<$Res> implements $StreakCopyWith<$Res> {
  factory _$$StreakImplCopyWith(
          _$StreakImpl value, $Res Function(_$StreakImpl) then) =
      __$$StreakImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'has_received') bool hasReceived,
      @JsonKey(name: 'amount') int? amount});
}

/// @nodoc
class __$$StreakImplCopyWithImpl<$Res>
    extends _$StreakCopyWithImpl<$Res, _$StreakImpl>
    implements _$$StreakImplCopyWith<$Res> {
  __$$StreakImplCopyWithImpl(
      _$StreakImpl _value, $Res Function(_$StreakImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? hasReceived = null,
    Object? amount = freezed,
  }) {
    return _then(_$StreakImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      hasReceived: null == hasReceived
          ? _value.hasReceived
          : hasReceived // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StreakImpl implements _Streak {
  const _$StreakImpl(
      {@JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'has_received') this.hasReceived = false,
      @JsonKey(name: 'amount') this.amount = 0});

  factory _$StreakImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreakImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'has_received')
  final bool hasReceived;
  @override
  @JsonKey(name: 'amount')
  final int? amount;

  @override
  String toString() {
    return 'Streak(name: $name, hasReceived: $hasReceived, amount: $amount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreakImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.hasReceived, hasReceived) ||
                other.hasReceived == hasReceived) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, hasReceived, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StreakImplCopyWith<_$StreakImpl> get copyWith =>
      __$$StreakImplCopyWithImpl<_$StreakImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreakImplToJson(
      this,
    );
  }
}

abstract class _Streak implements Streak {
  const factory _Streak(
      {@JsonKey(name: 'name') required final String name,
      @JsonKey(name: 'has_received') final bool hasReceived,
      @JsonKey(name: 'amount') final int? amount}) = _$StreakImpl;

  factory _Streak.fromJson(Map<String, dynamic> json) = _$StreakImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'has_received')
  bool get hasReceived;
  @override
  @JsonKey(name: 'amount')
  int? get amount;
  @override
  @JsonKey(ignore: true)
  _$$StreakImplCopyWith<_$StreakImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
