// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppCategory _$AppCategoryFromJson(Map<String, dynamic> json) {
  return _AppCategory.fromJson(json);
}

/// @nodoc
mixin _$AppCategory {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  String? get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_date')
  String? get updatedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_enabled')
  bool? get isEnabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppCategoryCopyWith<AppCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppCategoryCopyWith<$Res> {
  factory $AppCategoryCopyWith(
          AppCategory value, $Res Function(AppCategory) then) =
      _$AppCategoryCopyWithImpl<$Res, AppCategory>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate,
      @JsonKey(name: 'is_enabled') bool? isEnabled});
}

/// @nodoc
class _$AppCategoryCopyWithImpl<$Res, $Val extends AppCategory>
    implements $AppCategoryCopyWith<$Res> {
  _$AppCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? imageUrl = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? isEnabled = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isEnabled: freezed == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppCategoryCopyWith<$Res>
    implements $AppCategoryCopyWith<$Res> {
  factory _$$_AppCategoryCopyWith(
          _$_AppCategory value, $Res Function(_$_AppCategory) then) =
      __$$_AppCategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate,
      @JsonKey(name: 'is_enabled') bool? isEnabled});
}

/// @nodoc
class __$$_AppCategoryCopyWithImpl<$Res>
    extends _$AppCategoryCopyWithImpl<$Res, _$_AppCategory>
    implements _$$_AppCategoryCopyWith<$Res> {
  __$$_AppCategoryCopyWithImpl(
      _$_AppCategory _value, $Res Function(_$_AppCategory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? imageUrl = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? isEnabled = freezed,
  }) {
    return _then(_$_AppCategory(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isEnabled: freezed == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppCategory implements _AppCategory {
  const _$_AppCategory(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') this.name = '',
      @JsonKey(name: 'image_url') this.imageUrl = '',
      @JsonKey(name: 'created_date') this.createdDate = '',
      @JsonKey(name: 'updated_date') this.updatedDate = '',
      @JsonKey(name: 'is_enabled') this.isEnabled});

  factory _$_AppCategory.fromJson(Map<String, dynamic> json) =>
      _$$_AppCategoryFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'name')
  final String? name;
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
  @JsonKey(name: 'is_enabled')
  final bool? isEnabled;

  @override
  String toString() {
    return 'AppCategory(id: $id, name: $name, imageUrl: $imageUrl, createdDate: $createdDate, updatedDate: $updatedDate, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppCategory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, imageUrl, createdDate, updatedDate, isEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppCategoryCopyWith<_$_AppCategory> get copyWith =>
      __$$_AppCategoryCopyWithImpl<_$_AppCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppCategoryToJson(
      this,
    );
  }
}

abstract class _AppCategory implements AppCategory {
  const factory _AppCategory(
      {@JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'image_url') final String? imageUrl,
      @JsonKey(name: 'created_date') final String? createdDate,
      @JsonKey(name: 'updated_date') final String? updatedDate,
      @JsonKey(name: 'is_enabled') final bool? isEnabled}) = _$_AppCategory;

  factory _AppCategory.fromJson(Map<String, dynamic> json) =
      _$_AppCategory.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
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
  @JsonKey(name: 'is_enabled')
  bool? get isEnabled;
  @override
  @JsonKey(ignore: true)
  _$$_AppCategoryCopyWith<_$_AppCategory> get copyWith =>
      throw _privateConstructorUsedError;
}
