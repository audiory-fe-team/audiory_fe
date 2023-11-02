// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReadingList _$ReadingListFromJson(Map<String, dynamic> json) {
  return _ReadingList.fromJson(json);
}

/// @nodoc
mixin _$ReadingList {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_url')
  String? get coverUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  String? get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_date')
  String? get updatedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_private')
  bool? get isPrivate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_enabled')
  bool? get isEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'stories')
  List<Story>? get stories => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReadingListCopyWith<ReadingList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadingListCopyWith<$Res> {
  factory $ReadingListCopyWith(
          ReadingList value, $Res Function(ReadingList) then) =
      _$ReadingListCopyWithImpl<$Res, ReadingList>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'cover_url') String? coverUrl,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate,
      @JsonKey(name: 'is_private') bool? isPrivate,
      @JsonKey(name: 'is_enabled') bool? isEnabled,
      @JsonKey(name: 'stories') List<Story>? stories});
}

/// @nodoc
class _$ReadingListCopyWithImpl<$Res, $Val extends ReadingList>
    implements $ReadingListCopyWith<$Res> {
  _$ReadingListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? userId = freezed,
    Object? coverUrl = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? isPrivate = freezed,
    Object? isEnabled = freezed,
    Object? stories = freezed,
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
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      coverUrl: freezed == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: freezed == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool?,
      isEnabled: freezed == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      stories: freezed == stories
          ? _value.stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<Story>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReadingListImplCopyWith<$Res>
    implements $ReadingListCopyWith<$Res> {
  factory _$$ReadingListImplCopyWith(
          _$ReadingListImpl value, $Res Function(_$ReadingListImpl) then) =
      __$$ReadingListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'cover_url') String? coverUrl,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate,
      @JsonKey(name: 'is_private') bool? isPrivate,
      @JsonKey(name: 'is_enabled') bool? isEnabled,
      @JsonKey(name: 'stories') List<Story>? stories});
}

/// @nodoc
class __$$ReadingListImplCopyWithImpl<$Res>
    extends _$ReadingListCopyWithImpl<$Res, _$ReadingListImpl>
    implements _$$ReadingListImplCopyWith<$Res> {
  __$$ReadingListImplCopyWithImpl(
      _$ReadingListImpl _value, $Res Function(_$ReadingListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? userId = freezed,
    Object? coverUrl = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? isPrivate = freezed,
    Object? isEnabled = freezed,
    Object? stories = freezed,
  }) {
    return _then(_$ReadingListImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      coverUrl: freezed == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: freezed == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool?,
      isEnabled: freezed == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      stories: freezed == stories
          ? _value._stories
          : stories // ignore: cast_nullable_to_non_nullable
              as List<Story>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReadingListImpl implements _ReadingList {
  const _$ReadingListImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'name') this.name = '',
      @JsonKey(name: 'user_id') this.userId = '',
      @JsonKey(name: 'cover_url') this.coverUrl = FALLBACK_IMG_URL,
      @JsonKey(name: 'created_date') this.createdDate = '',
      @JsonKey(name: 'updated_date') this.updatedDate = '',
      @JsonKey(name: 'is_private') this.isPrivate,
      @JsonKey(name: 'is_enabled') this.isEnabled,
      @JsonKey(name: 'stories') final List<Story>? stories = const []})
      : _stories = stories;

  factory _$ReadingListImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReadingListImplFromJson(json);

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
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'cover_url')
  final String? coverUrl;
  @override
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @override
  @JsonKey(name: 'updated_date')
  final String? updatedDate;
  @override
  @JsonKey(name: 'is_private')
  final bool? isPrivate;
  @override
  @JsonKey(name: 'is_enabled')
  final bool? isEnabled;
  final List<Story>? _stories;
  @override
  @JsonKey(name: 'stories')
  List<Story>? get stories {
    final value = _stories;
    if (value == null) return null;
    if (_stories is EqualUnmodifiableListView) return _stories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ReadingList(id: $id, name: $name, userId: $userId, coverUrl: $coverUrl, createdDate: $createdDate, updatedDate: $updatedDate, isPrivate: $isPrivate, isEnabled: $isEnabled, stories: $stories)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadingListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            const DeepCollectionEquality().equals(other._stories, _stories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      userId,
      coverUrl,
      createdDate,
      updatedDate,
      isPrivate,
      isEnabled,
      const DeepCollectionEquality().hash(_stories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadingListImplCopyWith<_$ReadingListImpl> get copyWith =>
      __$$ReadingListImplCopyWithImpl<_$ReadingListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReadingListImplToJson(
      this,
    );
  }
}

abstract class _ReadingList implements ReadingList {
  const factory _ReadingList(
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'user_id') final String? userId,
          @JsonKey(name: 'cover_url') final String? coverUrl,
          @JsonKey(name: 'created_date') final String? createdDate,
          @JsonKey(name: 'updated_date') final String? updatedDate,
          @JsonKey(name: 'is_private') final bool? isPrivate,
          @JsonKey(name: 'is_enabled') final bool? isEnabled,
          @JsonKey(name: 'stories') final List<Story>? stories}) =
      _$ReadingListImpl;

  factory _ReadingList.fromJson(Map<String, dynamic> json) =
      _$ReadingListImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'cover_url')
  String? get coverUrl;
  @override
  @JsonKey(name: 'created_date')
  String? get createdDate;
  @override
  @JsonKey(name: 'updated_date')
  String? get updatedDate;
  @override
  @JsonKey(name: 'is_private')
  bool? get isPrivate;
  @override
  @JsonKey(name: 'is_enabled')
  bool? get isEnabled;
  @override
  @JsonKey(name: 'stories')
  List<Story>? get stories;
  @override
  @JsonKey(ignore: true)
  _$$ReadingListImplCopyWith<_$ReadingListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
