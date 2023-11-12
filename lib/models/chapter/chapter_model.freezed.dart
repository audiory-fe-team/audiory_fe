// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Chapter _$ChapterFromJson(Map<String, dynamic> json) {
  return _Chapter.fromJson(json);
}

/// @nodoc
mixin _$Chapter {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'story_id')
  String? get storyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_version_id')
  String? get currentVersionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'position')
  int? get position => throw _privateConstructorUsedError; // chapter position
  @JsonKey(name: 'product_id')
  String? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_draft')
  bool? get isDraft => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_paywalled')
  bool? get isPaywalled => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_paid')
  bool? get isPaid => throw _privateConstructorUsedError;
  @JsonKey(name: 'price')
  int? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'read_count')
  int? get readCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_voted')
  bool? get isVoted => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  int? get voteCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'comment_count')
  int? get commentCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  String? get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_date')
  String? get updatedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_enabled')
  bool? get isEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'chapter_version')
  String? get chapterVersion => throw _privateConstructorUsedError;
  @JsonKey(name: 'paragraphs')
  List<Paragraph>? get paragraphs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChapterCopyWith<Chapter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterCopyWith<$Res> {
  factory $ChapterCopyWith(Chapter value, $Res Function(Chapter) then) =
      _$ChapterCopyWithImpl<$Res, Chapter>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'story_id') String? storyId,
      @JsonKey(name: 'current_version_id') String? currentVersionId,
      @JsonKey(name: 'position') int? position,
      @JsonKey(name: 'product_id') String? productId,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'is_draft') bool? isDraft,
      @JsonKey(name: 'is_paywalled') bool? isPaywalled,
      @JsonKey(name: 'is_paid') bool? isPaid,
      @JsonKey(name: 'price') int? price,
      @JsonKey(name: 'read_count') int? readCount,
      @JsonKey(name: 'is_voted') bool? isVoted,
      @JsonKey(name: 'vote_count') int? voteCount,
      @JsonKey(name: 'comment_count') int? commentCount,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate,
      @JsonKey(name: 'is_enabled') bool? isEnabled,
      @JsonKey(name: 'chapter_version') String? chapterVersion,
      @JsonKey(name: 'paragraphs') List<Paragraph>? paragraphs});
}

/// @nodoc
class _$ChapterCopyWithImpl<$Res, $Val extends Chapter>
    implements $ChapterCopyWith<$Res> {
  _$ChapterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storyId = freezed,
    Object? currentVersionId = freezed,
    Object? position = freezed,
    Object? productId = freezed,
    Object? title = freezed,
    Object? isDraft = freezed,
    Object? isPaywalled = freezed,
    Object? isPaid = freezed,
    Object? price = freezed,
    Object? readCount = freezed,
    Object? isVoted = freezed,
    Object? voteCount = freezed,
    Object? commentCount = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? isEnabled = freezed,
    Object? chapterVersion = freezed,
    Object? paragraphs = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      storyId: freezed == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentVersionId: freezed == currentVersionId
          ? _value.currentVersionId
          : currentVersionId // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      isDraft: freezed == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPaywalled: freezed == isPaywalled
          ? _value.isPaywalled
          : isPaywalled // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPaid: freezed == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      readCount: freezed == readCount
          ? _value.readCount
          : readCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isVoted: freezed == isVoted
          ? _value.isVoted
          : isVoted // ignore: cast_nullable_to_non_nullable
              as bool?,
      voteCount: freezed == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int?,
      commentCount: freezed == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int?,
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
      chapterVersion: freezed == chapterVersion
          ? _value.chapterVersion
          : chapterVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      paragraphs: freezed == paragraphs
          ? _value.paragraphs
          : paragraphs // ignore: cast_nullable_to_non_nullable
              as List<Paragraph>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChapterImplCopyWith<$Res> implements $ChapterCopyWith<$Res> {
  factory _$$ChapterImplCopyWith(
          _$ChapterImpl value, $Res Function(_$ChapterImpl) then) =
      __$$ChapterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'story_id') String? storyId,
      @JsonKey(name: 'current_version_id') String? currentVersionId,
      @JsonKey(name: 'position') int? position,
      @JsonKey(name: 'product_id') String? productId,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'is_draft') bool? isDraft,
      @JsonKey(name: 'is_paywalled') bool? isPaywalled,
      @JsonKey(name: 'is_paid') bool? isPaid,
      @JsonKey(name: 'price') int? price,
      @JsonKey(name: 'read_count') int? readCount,
      @JsonKey(name: 'is_voted') bool? isVoted,
      @JsonKey(name: 'vote_count') int? voteCount,
      @JsonKey(name: 'comment_count') int? commentCount,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate,
      @JsonKey(name: 'is_enabled') bool? isEnabled,
      @JsonKey(name: 'chapter_version') String? chapterVersion,
      @JsonKey(name: 'paragraphs') List<Paragraph>? paragraphs});
}

/// @nodoc
class __$$ChapterImplCopyWithImpl<$Res>
    extends _$ChapterCopyWithImpl<$Res, _$ChapterImpl>
    implements _$$ChapterImplCopyWith<$Res> {
  __$$ChapterImplCopyWithImpl(
      _$ChapterImpl _value, $Res Function(_$ChapterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storyId = freezed,
    Object? currentVersionId = freezed,
    Object? position = freezed,
    Object? productId = freezed,
    Object? title = freezed,
    Object? isDraft = freezed,
    Object? isPaywalled = freezed,
    Object? isPaid = freezed,
    Object? price = freezed,
    Object? readCount = freezed,
    Object? isVoted = freezed,
    Object? voteCount = freezed,
    Object? commentCount = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? isEnabled = freezed,
    Object? chapterVersion = freezed,
    Object? paragraphs = freezed,
  }) {
    return _then(_$ChapterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      storyId: freezed == storyId
          ? _value.storyId
          : storyId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentVersionId: freezed == currentVersionId
          ? _value.currentVersionId
          : currentVersionId // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      isDraft: freezed == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPaywalled: freezed == isPaywalled
          ? _value.isPaywalled
          : isPaywalled // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPaid: freezed == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      readCount: freezed == readCount
          ? _value.readCount
          : readCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isVoted: freezed == isVoted
          ? _value.isVoted
          : isVoted // ignore: cast_nullable_to_non_nullable
              as bool?,
      voteCount: freezed == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int?,
      commentCount: freezed == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int?,
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
      chapterVersion: freezed == chapterVersion
          ? _value.chapterVersion
          : chapterVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      paragraphs: freezed == paragraphs
          ? _value._paragraphs
          : paragraphs // ignore: cast_nullable_to_non_nullable
              as List<Paragraph>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChapterImpl with DiagnosticableTreeMixin implements _Chapter {
  const _$ChapterImpl(
      {@JsonKey(name: 'id') this.id = '',
      @JsonKey(name: 'story_id') this.storyId,
      @JsonKey(name: 'current_version_id') this.currentVersionId,
      @JsonKey(name: 'position') this.position,
      @JsonKey(name: 'product_id') this.productId,
      @JsonKey(name: 'title') this.title = '',
      @JsonKey(name: 'is_draft') this.isDraft,
      @JsonKey(name: 'is_paywalled') this.isPaywalled,
      @JsonKey(name: 'is_paid') this.isPaid,
      @JsonKey(name: 'price') this.price,
      @JsonKey(name: 'read_count') this.readCount,
      @JsonKey(name: 'is_voted') this.isVoted,
      @JsonKey(name: 'vote_count') this.voteCount,
      @JsonKey(name: 'comment_count') this.commentCount,
      @JsonKey(name: 'created_date') this.createdDate,
      @JsonKey(name: 'updated_date') this.updatedDate,
      @JsonKey(name: 'is_enabled') this.isEnabled,
      @JsonKey(name: 'chapter_version') this.chapterVersion,
      @JsonKey(name: 'paragraphs') final List<Paragraph>? paragraphs})
      : _paragraphs = paragraphs;

  factory _$ChapterImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'story_id')
  final String? storyId;
  @override
  @JsonKey(name: 'current_version_id')
  final String? currentVersionId;
  @override
  @JsonKey(name: 'position')
  final int? position;
// chapter position
  @override
  @JsonKey(name: 'product_id')
  final String? productId;
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'is_draft')
  final bool? isDraft;
  @override
  @JsonKey(name: 'is_paywalled')
  final bool? isPaywalled;
  @override
  @JsonKey(name: 'is_paid')
  final bool? isPaid;
  @override
  @JsonKey(name: 'price')
  final int? price;
  @override
  @JsonKey(name: 'read_count')
  final int? readCount;
  @override
  @JsonKey(name: 'is_voted')
  final bool? isVoted;
  @override
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  @override
  @JsonKey(name: 'comment_count')
  final int? commentCount;
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
  @JsonKey(name: 'chapter_version')
  final String? chapterVersion;
  final List<Paragraph>? _paragraphs;
  @override
  @JsonKey(name: 'paragraphs')
  List<Paragraph>? get paragraphs {
    final value = _paragraphs;
    if (value == null) return null;
    if (_paragraphs is EqualUnmodifiableListView) return _paragraphs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Chapter(id: $id, storyId: $storyId, currentVersionId: $currentVersionId, position: $position, productId: $productId, title: $title, isDraft: $isDraft, isPaywalled: $isPaywalled, isPaid: $isPaid, price: $price, readCount: $readCount, isVoted: $isVoted, voteCount: $voteCount, commentCount: $commentCount, createdDate: $createdDate, updatedDate: $updatedDate, isEnabled: $isEnabled, chapterVersion: $chapterVersion, paragraphs: $paragraphs)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Chapter'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('storyId', storyId))
      ..add(DiagnosticsProperty('currentVersionId', currentVersionId))
      ..add(DiagnosticsProperty('position', position))
      ..add(DiagnosticsProperty('productId', productId))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('isDraft', isDraft))
      ..add(DiagnosticsProperty('isPaywalled', isPaywalled))
      ..add(DiagnosticsProperty('isPaid', isPaid))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('readCount', readCount))
      ..add(DiagnosticsProperty('isVoted', isVoted))
      ..add(DiagnosticsProperty('voteCount', voteCount))
      ..add(DiagnosticsProperty('commentCount', commentCount))
      ..add(DiagnosticsProperty('createdDate', createdDate))
      ..add(DiagnosticsProperty('updatedDate', updatedDate))
      ..add(DiagnosticsProperty('isEnabled', isEnabled))
      ..add(DiagnosticsProperty('chapterVersion', chapterVersion))
      ..add(DiagnosticsProperty('paragraphs', paragraphs));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storyId, storyId) || other.storyId == storyId) &&
            (identical(other.currentVersionId, currentVersionId) ||
                other.currentVersionId == currentVersionId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isDraft, isDraft) || other.isDraft == isDraft) &&
            (identical(other.isPaywalled, isPaywalled) ||
                other.isPaywalled == isPaywalled) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.readCount, readCount) ||
                other.readCount == readCount) &&
            (identical(other.isVoted, isVoted) || other.isVoted == isVoted) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.chapterVersion, chapterVersion) ||
                other.chapterVersion == chapterVersion) &&
            const DeepCollectionEquality()
                .equals(other._paragraphs, _paragraphs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        storyId,
        currentVersionId,
        position,
        productId,
        title,
        isDraft,
        isPaywalled,
        isPaid,
        price,
        readCount,
        isVoted,
        voteCount,
        commentCount,
        createdDate,
        updatedDate,
        isEnabled,
        chapterVersion,
        const DeepCollectionEquality().hash(_paragraphs)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
      __$$ChapterImplCopyWithImpl<_$ChapterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterImplToJson(
      this,
    );
  }
}

abstract class _Chapter implements Chapter {
  const factory _Chapter(
          {@JsonKey(name: 'id') final String id,
          @JsonKey(name: 'story_id') final String? storyId,
          @JsonKey(name: 'current_version_id') final String? currentVersionId,
          @JsonKey(name: 'position') final int? position,
          @JsonKey(name: 'product_id') final String? productId,
          @JsonKey(name: 'title') final String? title,
          @JsonKey(name: 'is_draft') final bool? isDraft,
          @JsonKey(name: 'is_paywalled') final bool? isPaywalled,
          @JsonKey(name: 'is_paid') final bool? isPaid,
          @JsonKey(name: 'price') final int? price,
          @JsonKey(name: 'read_count') final int? readCount,
          @JsonKey(name: 'is_voted') final bool? isVoted,
          @JsonKey(name: 'vote_count') final int? voteCount,
          @JsonKey(name: 'comment_count') final int? commentCount,
          @JsonKey(name: 'created_date') final String? createdDate,
          @JsonKey(name: 'updated_date') final String? updatedDate,
          @JsonKey(name: 'is_enabled') final bool? isEnabled,
          @JsonKey(name: 'chapter_version') final String? chapterVersion,
          @JsonKey(name: 'paragraphs') final List<Paragraph>? paragraphs}) =
      _$ChapterImpl;

  factory _Chapter.fromJson(Map<String, dynamic> json) = _$ChapterImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'story_id')
  String? get storyId;
  @override
  @JsonKey(name: 'current_version_id')
  String? get currentVersionId;
  @override
  @JsonKey(name: 'position')
  int? get position;
  @override // chapter position
  @JsonKey(name: 'product_id')
  String? get productId;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'is_draft')
  bool? get isDraft;
  @override
  @JsonKey(name: 'is_paywalled')
  bool? get isPaywalled;
  @override
  @JsonKey(name: 'is_paid')
  bool? get isPaid;
  @override
  @JsonKey(name: 'price')
  int? get price;
  @override
  @JsonKey(name: 'read_count')
  int? get readCount;
  @override
  @JsonKey(name: 'is_voted')
  bool? get isVoted;
  @override
  @JsonKey(name: 'vote_count')
  int? get voteCount;
  @override
  @JsonKey(name: 'comment_count')
  int? get commentCount;
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
  @JsonKey(name: 'chapter_version')
  String? get chapterVersion;
  @override
  @JsonKey(name: 'paragraphs')
  List<Paragraph>? get paragraphs;
  @override
  @JsonKey(ignore: true)
  _$$ChapterImplCopyWith<_$ChapterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
