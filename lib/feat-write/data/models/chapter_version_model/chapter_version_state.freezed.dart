// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_version_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChapterVersionState {
  ChapterVersion get chapterVersion => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChapterVersionStateCopyWith<ChapterVersionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterVersionStateCopyWith<$Res> {
  factory $ChapterVersionStateCopyWith(
          ChapterVersionState value, $Res Function(ChapterVersionState) then) =
      _$ChapterVersionStateCopyWithImpl<$Res, ChapterVersionState>;
  @useResult
  $Res call({ChapterVersion chapterVersion, bool isLoading});

  $ChapterVersionCopyWith<$Res> get chapterVersion;
}

/// @nodoc
class _$ChapterVersionStateCopyWithImpl<$Res, $Val extends ChapterVersionState>
    implements $ChapterVersionStateCopyWith<$Res> {
  _$ChapterVersionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chapterVersion = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      chapterVersion: null == chapterVersion
          ? _value.chapterVersion
          : chapterVersion // ignore: cast_nullable_to_non_nullable
              as ChapterVersion,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChapterVersionCopyWith<$Res> get chapterVersion {
    return $ChapterVersionCopyWith<$Res>(_value.chapterVersion, (value) {
      return _then(_value.copyWith(chapterVersion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChapterVersionStateCopyWith<$Res>
    implements $ChapterVersionStateCopyWith<$Res> {
  factory _$$_ChapterVersionStateCopyWith(_$_ChapterVersionState value,
          $Res Function(_$_ChapterVersionState) then) =
      __$$_ChapterVersionStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChapterVersion chapterVersion, bool isLoading});

  @override
  $ChapterVersionCopyWith<$Res> get chapterVersion;
}

/// @nodoc
class __$$_ChapterVersionStateCopyWithImpl<$Res>
    extends _$ChapterVersionStateCopyWithImpl<$Res, _$_ChapterVersionState>
    implements _$$_ChapterVersionStateCopyWith<$Res> {
  __$$_ChapterVersionStateCopyWithImpl(_$_ChapterVersionState _value,
      $Res Function(_$_ChapterVersionState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chapterVersion = null,
    Object? isLoading = null,
  }) {
    return _then(_$_ChapterVersionState(
      chapterVersion: null == chapterVersion
          ? _value.chapterVersion
          : chapterVersion // ignore: cast_nullable_to_non_nullable
              as ChapterVersion,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ChapterVersionState implements _ChapterVersionState {
  _$_ChapterVersionState(
      {this.chapterVersion = const ChapterVersion(), this.isLoading = true});

  @override
  @JsonKey()
  final ChapterVersion chapterVersion;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ChapterVersionState(chapterVersion: $chapterVersion, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChapterVersionState &&
            (identical(other.chapterVersion, chapterVersion) ||
                other.chapterVersion == chapterVersion) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chapterVersion, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChapterVersionStateCopyWith<_$_ChapterVersionState> get copyWith =>
      __$$_ChapterVersionStateCopyWithImpl<_$_ChapterVersionState>(
          this, _$identity);
}

abstract class _ChapterVersionState implements ChapterVersionState {
  factory _ChapterVersionState(
      {final ChapterVersion chapterVersion,
      final bool isLoading}) = _$_ChapterVersionState;

  @override
  ChapterVersion get chapterVersion;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_ChapterVersionStateCopyWith<_$_ChapterVersionState> get copyWith =>
      throw _privateConstructorUsedError;
}
