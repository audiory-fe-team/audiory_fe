// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_version_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChapterVersion _$ChapterVersionFromJson(Map<String, dynamic> json) {
  return _ChapterVersion.fromJson(json);
}

/// @nodoc
mixin _$ChapterVersion {
//add the code in analysis_options.yaml to ignore the JsonKey warning
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'chapter_id')
  String get chapterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'version_name')
  String? get versionName => throw _privateConstructorUsedError;
  @JsonKey(name: 'banner_url')
  String? get bannerUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'rich_text')
  String? get richText => throw _privateConstructorUsedError; //for json
  @JsonKey(name: 'content')
  String? get content => throw _privateConstructorUsedError; //for raw content
  @JsonKey(name: 'timestamp')
  String? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChapterVersionCopyWith<ChapterVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterVersionCopyWith<$Res> {
  factory $ChapterVersionCopyWith(
          ChapterVersion value, $Res Function(ChapterVersion) then) =
      _$ChapterVersionCopyWithImpl<$Res, ChapterVersion>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'chapter_id') String chapterId,
      @JsonKey(name: 'version_name') String? versionName,
      @JsonKey(name: 'banner_url') String? bannerUrl,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'rich_text') String? richText,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'timestamp') String? timestamp});
}

/// @nodoc
class _$ChapterVersionCopyWithImpl<$Res, $Val extends ChapterVersion>
    implements $ChapterVersionCopyWith<$Res> {
  _$ChapterVersionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chapterId = null,
    Object? versionName = freezed,
    Object? bannerUrl = freezed,
    Object? title = null,
    Object? richText = freezed,
    Object? content = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chapterId: null == chapterId
          ? _value.chapterId
          : chapterId // ignore: cast_nullable_to_non_nullable
              as String,
      versionName: freezed == versionName
          ? _value.versionName
          : versionName // ignore: cast_nullable_to_non_nullable
              as String?,
      bannerUrl: freezed == bannerUrl
          ? _value.bannerUrl
          : bannerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      richText: freezed == richText
          ? _value.richText
          : richText // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChapterVersionCopyWith<$Res>
    implements $ChapterVersionCopyWith<$Res> {
  factory _$$_ChapterVersionCopyWith(
          _$_ChapterVersion value, $Res Function(_$_ChapterVersion) then) =
      __$$_ChapterVersionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'chapter_id') String chapterId,
      @JsonKey(name: 'version_name') String? versionName,
      @JsonKey(name: 'banner_url') String? bannerUrl,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'rich_text') String? richText,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'timestamp') String? timestamp});
}

/// @nodoc
class __$$_ChapterVersionCopyWithImpl<$Res>
    extends _$ChapterVersionCopyWithImpl<$Res, _$_ChapterVersion>
    implements _$$_ChapterVersionCopyWith<$Res> {
  __$$_ChapterVersionCopyWithImpl(
      _$_ChapterVersion _value, $Res Function(_$_ChapterVersion) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chapterId = null,
    Object? versionName = freezed,
    Object? bannerUrl = freezed,
    Object? title = null,
    Object? richText = freezed,
    Object? content = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$_ChapterVersion(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chapterId: null == chapterId
          ? _value.chapterId
          : chapterId // ignore: cast_nullable_to_non_nullable
              as String,
      versionName: freezed == versionName
          ? _value.versionName
          : versionName // ignore: cast_nullable_to_non_nullable
              as String?,
      bannerUrl: freezed == bannerUrl
          ? _value.bannerUrl
          : bannerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      richText: freezed == richText
          ? _value.richText
          : richText // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChapterVersion
    with DiagnosticableTreeMixin
    implements _ChapterVersion {
  const _$_ChapterVersion(
      {@JsonKey(name: 'id') this.id = '',
      @JsonKey(name: 'chapter_id') this.chapterId = '',
      @JsonKey(name: 'version_name') this.versionName,
      @JsonKey(name: 'banner_url') this.bannerUrl,
      @JsonKey(name: 'title') this.title = '',
      @JsonKey(name: 'rich_text') this.richText,
      @JsonKey(name: 'content') this.content,
      @JsonKey(name: 'timestamp') this.timestamp});

  factory _$_ChapterVersion.fromJson(Map<String, dynamic> json) =>
      _$$_ChapterVersionFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'chapter_id')
  final String chapterId;
  @override
  @JsonKey(name: 'version_name')
  final String? versionName;
  @override
  @JsonKey(name: 'banner_url')
  final String? bannerUrl;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'rich_text')
  final String? richText;
//for json
  @override
  @JsonKey(name: 'content')
  final String? content;
//for raw content
  @override
  @JsonKey(name: 'timestamp')
  final String? timestamp;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChapterVersion(id: $id, chapterId: $chapterId, versionName: $versionName, bannerUrl: $bannerUrl, title: $title, richText: $richText, content: $content, timestamp: $timestamp)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChapterVersion'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('chapterId', chapterId))
      ..add(DiagnosticsProperty('versionName', versionName))
      ..add(DiagnosticsProperty('bannerUrl', bannerUrl))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('richText', richText))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('timestamp', timestamp));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChapterVersion &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chapterId, chapterId) ||
                other.chapterId == chapterId) &&
            (identical(other.versionName, versionName) ||
                other.versionName == versionName) &&
            (identical(other.bannerUrl, bannerUrl) ||
                other.bannerUrl == bannerUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.richText, richText) ||
                other.richText == richText) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, chapterId, versionName,
      bannerUrl, title, richText, content, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChapterVersionCopyWith<_$_ChapterVersion> get copyWith =>
      __$$_ChapterVersionCopyWithImpl<_$_ChapterVersion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChapterVersionToJson(
      this,
    );
  }
}

abstract class _ChapterVersion implements ChapterVersion {
  const factory _ChapterVersion(
      {@JsonKey(name: 'id') final String id,
      @JsonKey(name: 'chapter_id') final String chapterId,
      @JsonKey(name: 'version_name') final String? versionName,
      @JsonKey(name: 'banner_url') final String? bannerUrl,
      @JsonKey(name: 'title') final String title,
      @JsonKey(name: 'rich_text') final String? richText,
      @JsonKey(name: 'content') final String? content,
      @JsonKey(name: 'timestamp') final String? timestamp}) = _$_ChapterVersion;

  factory _ChapterVersion.fromJson(Map<String, dynamic> json) =
      _$_ChapterVersion.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'chapter_id')
  String get chapterId;
  @override
  @JsonKey(name: 'version_name')
  String? get versionName;
  @override
  @JsonKey(name: 'banner_url')
  String? get bannerUrl;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'rich_text')
  String? get richText;
  @override //for json
  @JsonKey(name: 'content')
  String? get content;
  @override //for raw content
  @JsonKey(name: 'timestamp')
  String? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$_ChapterVersionCopyWith<_$_ChapterVersion> get copyWith =>
      throw _privateConstructorUsedError;
}
