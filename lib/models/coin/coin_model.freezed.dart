// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Coin _$CoinFromJson(Map<String, dynamic> json) {
  return _Coin.fromJson(json);
}

/// @nodoc
mixin _$Coin {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError; //int
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'value')
  dynamic get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  String? get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_date')
  String? get updatedDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoinCopyWith<Coin> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoinCopyWith<$Res> {
  factory $CoinCopyWith(Coin value, $Res Function(Coin) then) =
      _$CoinCopyWithImpl<$Res, Coin>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'value') dynamic value,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate});
}

/// @nodoc
class _$CoinCopyWithImpl<$Res, $Val extends Coin>
    implements $CoinCopyWith<$Res> {
  _$CoinCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? value = freezed,
    Object? imageUrl = freezed,
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
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$_CoinCopyWith<$Res> implements $CoinCopyWith<$Res> {
  factory _$$_CoinCopyWith(_$_Coin value, $Res Function(_$_Coin) then) =
      __$$_CoinCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'value') dynamic value,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate});
}

/// @nodoc
class __$$_CoinCopyWithImpl<$Res> extends _$CoinCopyWithImpl<$Res, _$_Coin>
    implements _$$_CoinCopyWith<$Res> {
  __$$_CoinCopyWithImpl(_$_Coin _value, $Res Function(_$_Coin) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? value = freezed,
    Object? imageUrl = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
  }) {
    return _then(_$_Coin(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$_Coin implements _Coin {
  const _$_Coin(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') this.name = '',
      @JsonKey(name: 'value') this.value,
      @JsonKey(name: 'image_url') this.imageUrl = '',
      @JsonKey(name: 'created_date') this.createdDate = '',
      @JsonKey(name: 'updated_date') this.updatedDate = ''});

  factory _$_Coin.fromJson(Map<String, dynamic> json) => _$$_CoinFromJson(json);

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
  @JsonKey(name: 'value')
  final dynamic value;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @override
  @JsonKey(name: 'updated_date')
  final String? updatedDate;

  @override
  String toString() {
    return 'Coin(id: $id, name: $name, value: $value, imageUrl: $imageUrl, createdDate: $createdDate, updatedDate: $updatedDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Coin &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(value),
      imageUrl,
      createdDate,
      updatedDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CoinCopyWith<_$_Coin> get copyWith =>
      __$$_CoinCopyWithImpl<_$_Coin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CoinToJson(
      this,
    );
  }
}

abstract class _Coin implements Coin {
  const factory _Coin(
      {@JsonKey(name: 'id') required final int id,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'value') final dynamic value,
      @JsonKey(name: 'image_url') final String? imageUrl,
      @JsonKey(name: 'created_date') final String? createdDate,
      @JsonKey(name: 'updated_date') final String? updatedDate}) = _$_Coin;

  factory _Coin.fromJson(Map<String, dynamic> json) = _$_Coin.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  int get id;
  @override //int
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'value')
  dynamic get value;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'created_date')
  String? get createdDate;
  @override
  @JsonKey(name: 'updated_date')
  String? get updatedDate;
  @override
  @JsonKey(ignore: true)
  _$$_CoinCopyWith<_$_Coin> get copyWith => throw _privateConstructorUsedError;
}
