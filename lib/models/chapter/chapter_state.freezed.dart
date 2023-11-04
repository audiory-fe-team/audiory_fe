// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChapterState {
  Chapter get chapter => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChapterStateCopyWith<ChapterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterStateCopyWith<$Res> {
  factory $ChapterStateCopyWith(
          ChapterState value, $Res Function(ChapterState) then) =
      _$ChapterStateCopyWithImpl<$Res, ChapterState>;
  @useResult
  $Res call({Chapter chapter, bool isLoading});

  $ChapterCopyWith<$Res> get chapter;
}

/// @nodoc
class _$ChapterStateCopyWithImpl<$Res, $Val extends ChapterState>
    implements $ChapterStateCopyWith<$Res> {
  _$ChapterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chapter = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      chapter: null == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as Chapter,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChapterCopyWith<$Res> get chapter {
    return $ChapterCopyWith<$Res>(_value.chapter, (value) {
      return _then(_value.copyWith(chapter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChapterStateImplCopyWith<$Res>
    implements $ChapterStateCopyWith<$Res> {
  factory _$$ChapterStateImplCopyWith(
          _$ChapterStateImpl value, $Res Function(_$ChapterStateImpl) then) =
      __$$ChapterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Chapter chapter, bool isLoading});

  @override
  $ChapterCopyWith<$Res> get chapter;
}

/// @nodoc
class __$$ChapterStateImplCopyWithImpl<$Res>
    extends _$ChapterStateCopyWithImpl<$Res, _$ChapterStateImpl>
    implements _$$ChapterStateImplCopyWith<$Res> {
  __$$ChapterStateImplCopyWithImpl(
      _$ChapterStateImpl _value, $Res Function(_$ChapterStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chapter = null,
    Object? isLoading = null,
  }) {
    return _then(_$ChapterStateImpl(
      chapter: null == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as Chapter,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ChapterStateImpl implements _ChapterState {
  _$ChapterStateImpl({this.chapter = const Chapter(), this.isLoading = true});

  @override
  @JsonKey()
  final Chapter chapter;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'ChapterState(chapter: $chapter, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterStateImpl &&
            (identical(other.chapter, chapter) || other.chapter == chapter) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chapter, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterStateImplCopyWith<_$ChapterStateImpl> get copyWith =>
      __$$ChapterStateImplCopyWithImpl<_$ChapterStateImpl>(this, _$identity);
}

abstract class _ChapterState implements ChapterState {
  factory _ChapterState({final Chapter chapter, final bool isLoading}) =
      _$ChapterStateImpl;

  @override
  Chapter get chapter;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$ChapterStateImplCopyWith<_$ChapterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
