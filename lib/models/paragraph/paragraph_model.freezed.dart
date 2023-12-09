// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paragraph_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Paragraph _$ParagraphFromJson(Map<String, dynamic> json) {
  return _Paragraph.fromJson(json);
}

/// @nodoc
mixin _$Paragraph {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'chapter_id')
  String? get chapterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'chapter_version_id')
  String? get chapterVersionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'order')
  int? get order => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'rich_text')
  String? get richText => throw _privateConstructorUsedError;
  @JsonKey(name: 'comment_count')
  int? get commentCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'audios')
  List<ParaAudio>? get audios => throw _privateConstructorUsedError;
  @JsonKey(name: 'content_moderation')
  ContentModeration? get contentModeration =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParagraphCopyWith<Paragraph> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParagraphCopyWith<$Res> {
  factory $ParagraphCopyWith(Paragraph value, $Res Function(Paragraph) then) =
      _$ParagraphCopyWithImpl<$Res, Paragraph>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'chapter_id') String? chapterId,
      @JsonKey(name: 'chapter_version_id') String? chapterVersionId,
      @JsonKey(name: 'order') int? order,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'rich_text') String? richText,
      @JsonKey(name: 'comment_count') int? commentCount,
      @JsonKey(name: 'audios') List<ParaAudio>? audios,
      @JsonKey(name: 'content_moderation')
      ContentModeration? contentModeration});

  $ContentModerationCopyWith<$Res>? get contentModeration;
}

/// @nodoc
class _$ParagraphCopyWithImpl<$Res, $Val extends Paragraph>
    implements $ParagraphCopyWith<$Res> {
  _$ParagraphCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chapterId = freezed,
    Object? chapterVersionId = freezed,
    Object? order = freezed,
    Object? content = freezed,
    Object? richText = freezed,
    Object? commentCount = freezed,
    Object? audios = freezed,
    Object? contentModeration = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chapterId: freezed == chapterId
          ? _value.chapterId
          : chapterId // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterVersionId: freezed == chapterVersionId
          ? _value.chapterVersionId
          : chapterVersionId // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      richText: freezed == richText
          ? _value.richText
          : richText // ignore: cast_nullable_to_non_nullable
              as String?,
      commentCount: freezed == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int?,
      audios: freezed == audios
          ? _value.audios
          : audios // ignore: cast_nullable_to_non_nullable
              as List<ParaAudio>?,
      contentModeration: freezed == contentModeration
          ? _value.contentModeration
          : contentModeration // ignore: cast_nullable_to_non_nullable
              as ContentModeration?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ContentModerationCopyWith<$Res>? get contentModeration {
    if (_value.contentModeration == null) {
      return null;
    }

    return $ContentModerationCopyWith<$Res>(_value.contentModeration!, (value) {
      return _then(_value.copyWith(contentModeration: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ParagraphImplCopyWith<$Res>
    implements $ParagraphCopyWith<$Res> {
  factory _$$ParagraphImplCopyWith(
          _$ParagraphImpl value, $Res Function(_$ParagraphImpl) then) =
      __$$ParagraphImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'chapter_id') String? chapterId,
      @JsonKey(name: 'chapter_version_id') String? chapterVersionId,
      @JsonKey(name: 'order') int? order,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'rich_text') String? richText,
      @JsonKey(name: 'comment_count') int? commentCount,
      @JsonKey(name: 'audios') List<ParaAudio>? audios,
      @JsonKey(name: 'content_moderation')
      ContentModeration? contentModeration});

  @override
  $ContentModerationCopyWith<$Res>? get contentModeration;
}

/// @nodoc
class __$$ParagraphImplCopyWithImpl<$Res>
    extends _$ParagraphCopyWithImpl<$Res, _$ParagraphImpl>
    implements _$$ParagraphImplCopyWith<$Res> {
  __$$ParagraphImplCopyWithImpl(
      _$ParagraphImpl _value, $Res Function(_$ParagraphImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chapterId = freezed,
    Object? chapterVersionId = freezed,
    Object? order = freezed,
    Object? content = freezed,
    Object? richText = freezed,
    Object? commentCount = freezed,
    Object? audios = freezed,
    Object? contentModeration = freezed,
  }) {
    return _then(_$ParagraphImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chapterId: freezed == chapterId
          ? _value.chapterId
          : chapterId // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterVersionId: freezed == chapterVersionId
          ? _value.chapterVersionId
          : chapterVersionId // ignore: cast_nullable_to_non_nullable
              as String?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      richText: freezed == richText
          ? _value.richText
          : richText // ignore: cast_nullable_to_non_nullable
              as String?,
      commentCount: freezed == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int?,
      audios: freezed == audios
          ? _value._audios
          : audios // ignore: cast_nullable_to_non_nullable
              as List<ParaAudio>?,
      contentModeration: freezed == contentModeration
          ? _value.contentModeration
          : contentModeration // ignore: cast_nullable_to_non_nullable
              as ContentModeration?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParagraphImpl implements _Paragraph {
  const _$ParagraphImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'chapter_id') this.chapterId = '',
      @JsonKey(name: 'chapter_version_id') this.chapterVersionId = '',
      @JsonKey(name: 'order') this.order = 0,
      @JsonKey(name: 'content') this.content = '',
      @JsonKey(name: 'rich_text') this.richText,
      @JsonKey(name: 'comment_count') this.commentCount = 0,
      @JsonKey(name: 'audios') final List<ParaAudio>? audios = const [],
      @JsonKey(name: 'content_moderation') this.contentModeration})
      : _audios = audios;

  factory _$ParagraphImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParagraphImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'chapter_id')
  final String? chapterId;
  @override
  @JsonKey(name: 'chapter_version_id')
  final String? chapterVersionId;
  @override
  @JsonKey(name: 'order')
  final int? order;
  @override
  @JsonKey(name: 'content')
  final String? content;
  @override
  @JsonKey(name: 'rich_text')
  final String? richText;
  @override
  @JsonKey(name: 'comment_count')
  final int? commentCount;
  final List<ParaAudio>? _audios;
  @override
  @JsonKey(name: 'audios')
  List<ParaAudio>? get audios {
    final value = _audios;
    if (value == null) return null;
    if (_audios is EqualUnmodifiableListView) return _audios;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'content_moderation')
  final ContentModeration? contentModeration;

  @override
  String toString() {
    return 'Paragraph(id: $id, chapterId: $chapterId, chapterVersionId: $chapterVersionId, order: $order, content: $content, richText: $richText, commentCount: $commentCount, audios: $audios, contentModeration: $contentModeration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParagraphImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chapterId, chapterId) ||
                other.chapterId == chapterId) &&
            (identical(other.chapterVersionId, chapterVersionId) ||
                other.chapterVersionId == chapterVersionId) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.richText, richText) ||
                other.richText == richText) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            const DeepCollectionEquality().equals(other._audios, _audios) &&
            (identical(other.contentModeration, contentModeration) ||
                other.contentModeration == contentModeration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      chapterId,
      chapterVersionId,
      order,
      content,
      richText,
      commentCount,
      const DeepCollectionEquality().hash(_audios),
      contentModeration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParagraphImplCopyWith<_$ParagraphImpl> get copyWith =>
      __$$ParagraphImplCopyWithImpl<_$ParagraphImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParagraphImplToJson(
      this,
    );
  }
}

abstract class _Paragraph implements Paragraph {
  const factory _Paragraph(
      {@JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'chapter_id') final String? chapterId,
      @JsonKey(name: 'chapter_version_id') final String? chapterVersionId,
      @JsonKey(name: 'order') final int? order,
      @JsonKey(name: 'content') final String? content,
      @JsonKey(name: 'rich_text') final String? richText,
      @JsonKey(name: 'comment_count') final int? commentCount,
      @JsonKey(name: 'audios') final List<ParaAudio>? audios,
      @JsonKey(name: 'content_moderation')
      final ContentModeration? contentModeration}) = _$ParagraphImpl;

  factory _Paragraph.fromJson(Map<String, dynamic> json) =
      _$ParagraphImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'chapter_id')
  String? get chapterId;
  @override
  @JsonKey(name: 'chapter_version_id')
  String? get chapterVersionId;
  @override
  @JsonKey(name: 'order')
  int? get order;
  @override
  @JsonKey(name: 'content')
  String? get content;
  @override
  @JsonKey(name: 'rich_text')
  String? get richText;
  @override
  @JsonKey(name: 'comment_count')
  int? get commentCount;
  @override
  @JsonKey(name: 'audios')
  List<ParaAudio>? get audios;
  @override
  @JsonKey(name: 'content_moderation')
  ContentModeration? get contentModeration;
  @override
  @JsonKey(ignore: true)
  _$$ParagraphImplCopyWith<_$ParagraphImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
