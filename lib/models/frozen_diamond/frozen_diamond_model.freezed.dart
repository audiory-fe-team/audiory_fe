// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frozen_diamond_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FrozenDiamond _$FrozenDiamondFromJson(Map<String, dynamic> json) {
  return _FrozenDiamond.fromJson(json);
}

/// @nodoc
mixin _$FrozenDiamond {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'story_id')
  String? get storyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount')
  dynamic? get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'unfrozen_date')
  String? get unfrozenDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'story')
  Story? get story => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FrozenDiamondCopyWith<FrozenDiamond> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrozenDiamondCopyWith<$Res> {
  factory $FrozenDiamondCopyWith(
          FrozenDiamond value, $Res Function(FrozenDiamond) then) =
      _$FrozenDiamondCopyWithImpl<$Res, FrozenDiamond>;
  @useResult
  $Res call(
      {@JsonKey(name: 'story_id') String? storyId,
      @JsonKey(name: 'amount') dynamic? amount,
      @JsonKey(name: 'unfrozen_date') String? unfrozenDate,
      @JsonKey(name: 'story') Story? story});

  $StoryCopyWith<$Res>? get story;
}

/// @nodoc
class _$FrozenDiamondCopyWithImpl<$Res, $Val extends FrozenDiamond>
    implements $FrozenDiamondCopyWith<$Res> {
  _$FrozenDiamondCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyId = freezed,
    Object? amount = freezed,
    Object? unfrozenDate = freezed,
    Object? story = freezed,
  }) {
    return _then(_value.copyWith(
      storyId: freezed == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      unfrozenDate: freezed == unfrozenDate
          ? _value.unfrozenDate
          : unfrozenDate // ignore: cast_nullable_to_non_nullable
              as String?,
      story: freezed == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as Story?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StoryCopyWith<$Res>? get story {
    if (_value.story == null) {
      return null;
    }

    return $StoryCopyWith<$Res>(_value.story!, (value) {
      return _then(_value.copyWith(story: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FrozenDiamondImplCopyWith<$Res>
    implements $FrozenDiamondCopyWith<$Res> {
  factory _$$FrozenDiamondImplCopyWith(
          _$FrozenDiamondImpl value, $Res Function(_$FrozenDiamondImpl) then) =
      __$$FrozenDiamondImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'story_id') String? storyId,
      @JsonKey(name: 'amount') dynamic? amount,
      @JsonKey(name: 'unfrozen_date') String? unfrozenDate,
      @JsonKey(name: 'story') Story? story});

  @override
  $StoryCopyWith<$Res>? get story;
}

/// @nodoc
class __$$FrozenDiamondImplCopyWithImpl<$Res>
    extends _$FrozenDiamondCopyWithImpl<$Res, _$FrozenDiamondImpl>
    implements _$$FrozenDiamondImplCopyWith<$Res> {
  __$$FrozenDiamondImplCopyWithImpl(
      _$FrozenDiamondImpl _value, $Res Function(_$FrozenDiamondImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyId = freezed,
    Object? amount = freezed,
    Object? unfrozenDate = freezed,
    Object? story = freezed,
  }) {
    return _then(_$FrozenDiamondImpl(
      storyId: freezed == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as dynamic?,
      unfrozenDate: freezed == unfrozenDate
          ? _value.unfrozenDate
          : unfrozenDate // ignore: cast_nullable_to_non_nullable
              as String?,
      story: freezed == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as Story?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FrozenDiamondImpl implements _FrozenDiamond {
  const _$FrozenDiamondImpl(
      {@JsonKey(name: 'story_id') this.storyId = '',
      @JsonKey(name: 'amount') this.amount = 0,
      @JsonKey(name: 'unfrozen_date') this.unfrozenDate,
      @JsonKey(name: 'story') this.story});

  factory _$FrozenDiamondImpl.fromJson(Map<String, dynamic> json) =>
      _$$FrozenDiamondImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'story_id')
  final String? storyId;
  @override
  @JsonKey(name: 'amount')
  final dynamic? amount;
  @override
  @JsonKey(name: 'unfrozen_date')
  final String? unfrozenDate;
  @override
  @JsonKey(name: 'story')
  final Story? story;

  @override
  String toString() {
    return 'FrozenDiamond(storyId: $storyId, amount: $amount, unfrozenDate: $unfrozenDate, story: $story)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrozenDiamondImpl &&
            (identical(other.storyId, storyId) || other.storyId == storyId) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            (identical(other.unfrozenDate, unfrozenDate) ||
                other.unfrozenDate == unfrozenDate) &&
            (identical(other.story, story) || other.story == story));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, storyId,
      const DeepCollectionEquality().hash(amount), unfrozenDate, story);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FrozenDiamondImplCopyWith<_$FrozenDiamondImpl> get copyWith =>
      __$$FrozenDiamondImplCopyWithImpl<_$FrozenDiamondImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FrozenDiamondImplToJson(
      this,
    );
  }
}

abstract class _FrozenDiamond implements FrozenDiamond {
  const factory _FrozenDiamond(
      {@JsonKey(name: 'story_id') final String? storyId,
      @JsonKey(name: 'amount') final dynamic? amount,
      @JsonKey(name: 'unfrozen_date') final String? unfrozenDate,
      @JsonKey(name: 'story') final Story? story}) = _$FrozenDiamondImpl;

  factory _FrozenDiamond.fromJson(Map<String, dynamic> json) =
      _$FrozenDiamondImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'story_id')
  String? get storyId;
  @override
  @JsonKey(name: 'amount')
  dynamic? get amount;
  @override
  @JsonKey(name: 'unfrozen_date')
  String? get unfrozenDate;
  @override
  @JsonKey(name: 'story')
  Story? get story;
  @override
  @JsonKey(ignore: true)
  _$$FrozenDiamondImplCopyWith<_$FrozenDiamondImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
