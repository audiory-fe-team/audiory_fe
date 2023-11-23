// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_progress_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReadingProgress _$ReadingProgressFromJson(Map<String, dynamic> json) {
  return _ReadingProgress.fromJson(json);
}

/// @nodoc
mixin _$ReadingProgress {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'library_id')
  String? get libraryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'story_id')
  String? get storyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'chapter_id')
  String? get chapterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reading_position')
  int? get readingPosition => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_completed')
  bool? get isCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'num_chapter')
  int? get numChapter => throw _privateConstructorUsedError;
  @JsonKey(name: 'chapter_position')
  int? get chapterPosition => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReadingProgressCopyWith<ReadingProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadingProgressCopyWith<$Res> {
  factory $ReadingProgressCopyWith(
          ReadingProgress value, $Res Function(ReadingProgress) then) =
      _$ReadingProgressCopyWithImpl<$Res, ReadingProgress>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'library_id') String? libraryId,
      @JsonKey(name: 'story_id') String? storyId,
      @JsonKey(name: 'chapter_id') String? chapterId,
      @JsonKey(name: 'reading_position') int? readingPosition,
      @JsonKey(name: 'is_completed') bool? isCompleted,
      @JsonKey(name: 'num_chapter') int? numChapter,
      @JsonKey(name: 'chapter_position') int? chapterPosition});
}

/// @nodoc
class _$ReadingProgressCopyWithImpl<$Res, $Val extends ReadingProgress>
    implements $ReadingProgressCopyWith<$Res> {
  _$ReadingProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? libraryId = freezed,
    Object? storyId = freezed,
    Object? chapterId = freezed,
    Object? readingPosition = freezed,
    Object? isCompleted = freezed,
    Object? numChapter = freezed,
    Object? chapterPosition = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      libraryId: freezed == libraryId
          ? _value.libraryId
          : libraryId // ignore: cast_nullable_to_non_nullable
              as String?,
      storyId: freezed == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterId: freezed == chapterId
          ? _value.chapterId
          : chapterId // ignore: cast_nullable_to_non_nullable
              as String?,
      readingPosition: freezed == readingPosition
          ? _value.readingPosition
          : readingPosition // ignore: cast_nullable_to_non_nullable
              as int?,
      isCompleted: freezed == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      numChapter: freezed == numChapter
          ? _value.numChapter
          : numChapter // ignore: cast_nullable_to_non_nullable
              as int?,
      chapterPosition: freezed == chapterPosition
          ? _value.chapterPosition
          : chapterPosition // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReadingProgressImplCopyWith<$Res>
    implements $ReadingProgressCopyWith<$Res> {
  factory _$$ReadingProgressImplCopyWith(_$ReadingProgressImpl value,
          $Res Function(_$ReadingProgressImpl) then) =
      __$$ReadingProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'library_id') String? libraryId,
      @JsonKey(name: 'story_id') String? storyId,
      @JsonKey(name: 'chapter_id') String? chapterId,
      @JsonKey(name: 'reading_position') int? readingPosition,
      @JsonKey(name: 'is_completed') bool? isCompleted,
      @JsonKey(name: 'num_chapter') int? numChapter,
      @JsonKey(name: 'chapter_position') int? chapterPosition});
}

/// @nodoc
class __$$ReadingProgressImplCopyWithImpl<$Res>
    extends _$ReadingProgressCopyWithImpl<$Res, _$ReadingProgressImpl>
    implements _$$ReadingProgressImplCopyWith<$Res> {
  __$$ReadingProgressImplCopyWithImpl(
      _$ReadingProgressImpl _value, $Res Function(_$ReadingProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? libraryId = freezed,
    Object? storyId = freezed,
    Object? chapterId = freezed,
    Object? readingPosition = freezed,
    Object? isCompleted = freezed,
    Object? numChapter = freezed,
    Object? chapterPosition = freezed,
  }) {
    return _then(_$ReadingProgressImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      libraryId: freezed == libraryId
          ? _value.libraryId
          : libraryId // ignore: cast_nullable_to_non_nullable
              as String?,
      storyId: freezed == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterId: freezed == chapterId
          ? _value.chapterId
          : chapterId // ignore: cast_nullable_to_non_nullable
              as String?,
      readingPosition: freezed == readingPosition
          ? _value.readingPosition
          : readingPosition // ignore: cast_nullable_to_non_nullable
              as int?,
      isCompleted: freezed == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      numChapter: freezed == numChapter
          ? _value.numChapter
          : numChapter // ignore: cast_nullable_to_non_nullable
              as int?,
      chapterPosition: freezed == chapterPosition
          ? _value.chapterPosition
          : chapterPosition // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReadingProgressImpl implements _ReadingProgress {
  const _$ReadingProgressImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'library_id') this.libraryId,
      @JsonKey(name: 'story_id') this.storyId,
      @JsonKey(name: 'chapter_id') this.chapterId,
      @JsonKey(name: 'reading_position') this.readingPosition,
      @JsonKey(name: 'is_completed') this.isCompleted,
      @JsonKey(name: 'num_chapter') this.numChapter,
      @JsonKey(name: 'chapter_position') this.chapterPosition});

  factory _$ReadingProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReadingProgressImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'library_id')
  final String? libraryId;
  @override
  @JsonKey(name: 'story_id')
  final String? storyId;
  @override
  @JsonKey(name: 'chapter_id')
  final String? chapterId;
  @override
  @JsonKey(name: 'reading_position')
  final int? readingPosition;
  @override
  @JsonKey(name: 'is_completed')
  final bool? isCompleted;
  @override
  @JsonKey(name: 'num_chapter')
  final int? numChapter;
  @override
  @JsonKey(name: 'chapter_position')
  final int? chapterPosition;

  @override
  String toString() {
    return 'ReadingProgress(id: $id, libraryId: $libraryId, storyId: $storyId, chapterId: $chapterId, readingPosition: $readingPosition, isCompleted: $isCompleted, numChapter: $numChapter, chapterPosition: $chapterPosition)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadingProgressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.libraryId, libraryId) ||
                other.libraryId == libraryId) &&
            (identical(other.storyId, storyId) || other.storyId == storyId) &&
            (identical(other.chapterId, chapterId) ||
                other.chapterId == chapterId) &&
            (identical(other.readingPosition, readingPosition) ||
                other.readingPosition == readingPosition) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.numChapter, numChapter) ||
                other.numChapter == numChapter) &&
            (identical(other.chapterPosition, chapterPosition) ||
                other.chapterPosition == chapterPosition));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, libraryId, storyId,
      chapterId, readingPosition, isCompleted, numChapter, chapterPosition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadingProgressImplCopyWith<_$ReadingProgressImpl> get copyWith =>
      __$$ReadingProgressImplCopyWithImpl<_$ReadingProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReadingProgressImplToJson(
      this,
    );
  }
}

abstract class _ReadingProgress implements ReadingProgress {
  const factory _ReadingProgress(
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'library_id') final String? libraryId,
          @JsonKey(name: 'story_id') final String? storyId,
          @JsonKey(name: 'chapter_id') final String? chapterId,
          @JsonKey(name: 'reading_position') final int? readingPosition,
          @JsonKey(name: 'is_completed') final bool? isCompleted,
          @JsonKey(name: 'num_chapter') final int? numChapter,
          @JsonKey(name: 'chapter_position') final int? chapterPosition}) =
      _$ReadingProgressImpl;

  factory _ReadingProgress.fromJson(Map<String, dynamic> json) =
      _$ReadingProgressImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'library_id')
  String? get libraryId;
  @override
  @JsonKey(name: 'story_id')
  String? get storyId;
  @override
  @JsonKey(name: 'chapter_id')
  String? get chapterId;
  @override
  @JsonKey(name: 'reading_position')
  int? get readingPosition;
  @override
  @JsonKey(name: 'is_completed')
  bool? get isCompleted;
  @override
  @JsonKey(name: 'num_chapter')
  int? get numChapter;
  @override
  @JsonKey(name: 'chapter_position')
  int? get chapterPosition;
  @override
  @JsonKey(ignore: true)
  _$$ReadingProgressImplCopyWith<_$ReadingProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
