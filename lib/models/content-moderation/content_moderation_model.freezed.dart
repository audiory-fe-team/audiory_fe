// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_moderation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ContentModeration _$ContentModerationFromJson(Map<String, dynamic> json) {
  return _ContentModeration.fromJson(json);
}

/// @nodoc
mixin _$ContentModeration {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'chapter_version_id')
  String? get chapterVersionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'paragraph_id')
  String? get paragraphId => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_mature')
  bool? get isMature => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_reactionary')
  bool? get isReactionary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContentModerationCopyWith<ContentModeration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentModerationCopyWith<$Res> {
  factory $ContentModerationCopyWith(
          ContentModeration value, $Res Function(ContentModeration) then) =
      _$ContentModerationCopyWithImpl<$Res, ContentModeration>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'chapter_version_id') String? chapterVersionId,
      @JsonKey(name: 'paragraph_id') String? paragraphId,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'is_mature') bool? isMature,
      @JsonKey(name: 'is_reactionary') bool? isReactionary});
}

/// @nodoc
class _$ContentModerationCopyWithImpl<$Res, $Val extends ContentModeration>
    implements $ContentModerationCopyWith<$Res> {
  _$ContentModerationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chapterVersionId = freezed,
    Object? paragraphId = freezed,
    Object? type = freezed,
    Object? isMature = freezed,
    Object? isReactionary = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chapterVersionId: freezed == chapterVersionId
          ? _value.chapterVersionId
          : chapterVersionId // ignore: cast_nullable_to_non_nullable
              as String?,
      paragraphId: freezed == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      isMature: freezed == isMature
          ? _value.isMature
          : isMature // ignore: cast_nullable_to_non_nullable
              as bool?,
      isReactionary: freezed == isReactionary
          ? _value.isReactionary
          : isReactionary // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentModerationImplCopyWith<$Res>
    implements $ContentModerationCopyWith<$Res> {
  factory _$$ContentModerationImplCopyWith(_$ContentModerationImpl value,
          $Res Function(_$ContentModerationImpl) then) =
      __$$ContentModerationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'chapter_version_id') String? chapterVersionId,
      @JsonKey(name: 'paragraph_id') String? paragraphId,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'is_mature') bool? isMature,
      @JsonKey(name: 'is_reactionary') bool? isReactionary});
}

/// @nodoc
class __$$ContentModerationImplCopyWithImpl<$Res>
    extends _$ContentModerationCopyWithImpl<$Res, _$ContentModerationImpl>
    implements _$$ContentModerationImplCopyWith<$Res> {
  __$$ContentModerationImplCopyWithImpl(_$ContentModerationImpl _value,
      $Res Function(_$ContentModerationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chapterVersionId = freezed,
    Object? paragraphId = freezed,
    Object? type = freezed,
    Object? isMature = freezed,
    Object? isReactionary = freezed,
  }) {
    return _then(_$ContentModerationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chapterVersionId: freezed == chapterVersionId
          ? _value.chapterVersionId
          : chapterVersionId // ignore: cast_nullable_to_non_nullable
              as String?,
      paragraphId: freezed == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      isMature: freezed == isMature
          ? _value.isMature
          : isMature // ignore: cast_nullable_to_non_nullable
              as bool?,
      isReactionary: freezed == isReactionary
          ? _value.isReactionary
          : isReactionary // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentModerationImpl implements _ContentModeration {
  const _$ContentModerationImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'chapter_version_id') this.chapterVersionId = '',
      @JsonKey(name: 'paragraph_id') this.paragraphId = '',
      @JsonKey(name: 'type') this.type = 'TEXT',
      @JsonKey(name: 'is_mature') this.isMature = false,
      @JsonKey(name: 'is_reactionary') this.isReactionary = false});

  factory _$ContentModerationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentModerationImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'chapter_version_id')
  final String? chapterVersionId;
  @override
  @JsonKey(name: 'paragraph_id')
  final String? paragraphId;
  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'is_mature')
  final bool? isMature;
  @override
  @JsonKey(name: 'is_reactionary')
  final bool? isReactionary;

  @override
  String toString() {
    return 'ContentModeration(id: $id, chapterVersionId: $chapterVersionId, paragraphId: $paragraphId, type: $type, isMature: $isMature, isReactionary: $isReactionary)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentModerationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chapterVersionId, chapterVersionId) ||
                other.chapterVersionId == chapterVersionId) &&
            (identical(other.paragraphId, paragraphId) ||
                other.paragraphId == paragraphId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isMature, isMature) ||
                other.isMature == isMature) &&
            (identical(other.isReactionary, isReactionary) ||
                other.isReactionary == isReactionary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, chapterVersionId,
      paragraphId, type, isMature, isReactionary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentModerationImplCopyWith<_$ContentModerationImpl> get copyWith =>
      __$$ContentModerationImplCopyWithImpl<_$ContentModerationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentModerationImplToJson(
      this,
    );
  }
}

abstract class _ContentModeration implements ContentModeration {
  const factory _ContentModeration(
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'chapter_version_id') final String? chapterVersionId,
          @JsonKey(name: 'paragraph_id') final String? paragraphId,
          @JsonKey(name: 'type') final String? type,
          @JsonKey(name: 'is_mature') final bool? isMature,
          @JsonKey(name: 'is_reactionary') final bool? isReactionary}) =
      _$ContentModerationImpl;

  factory _ContentModeration.fromJson(Map<String, dynamic> json) =
      _$ContentModerationImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'chapter_version_id')
  String? get chapterVersionId;
  @override
  @JsonKey(name: 'paragraph_id')
  String? get paragraphId;
  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'is_mature')
  bool? get isMature;
  @override
  @JsonKey(name: 'is_reactionary')
  bool? get isReactionary;
  @override
  @JsonKey(ignore: true)
  _$$ContentModerationImplCopyWith<_$ContentModerationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
