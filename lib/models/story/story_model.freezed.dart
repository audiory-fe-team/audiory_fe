// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Story _$StoryFromJson(Map<String, dynamic> json) {
  return _Story.fromJson(json);
}

/// @nodoc
mixin _$Story {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_id')
  String? get authorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'author')
  AuthorStory? get author => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId =>
      throw _privateConstructorUsedError; // Story position
  @JsonKey(name: 'category')
  AppCategory? get category =>
      throw _privateConstructorUsedError; // Story position
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_url')
  String? get coverUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_draft')
  bool? get isDraft => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_mature')
  bool? get isMature => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_completed')
  bool? get isCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_copyright')
  bool? get isCopyright => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_paywalled')
  bool? get isPaywalled => throw _privateConstructorUsedError;
  @JsonKey(name: 'chapter_price')
  int? get chapterPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'coin_cost')
  int? get coinCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'author_earning_percentage')
  int? get authorEarningPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'paywall_effective_date')
  String? get paywallEffectiveDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'num_free_chapters')
  int? get numFreeChapters => throw _privateConstructorUsedError;
  @JsonKey(name: 'published_count')
  int? get publishedCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'draft_count')
  int? get draftCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'report_count')
  int? get reportCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  int? get voteCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'read_count')
  int? get readCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_vote')
  int? get totalVote => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_read')
  int? get totalRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_comment')
  int? get totalComment => throw _privateConstructorUsedError;
  @JsonKey(name: 'explicit_percentage')
  int? get explicitPercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  String? get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_date')
  String? get updatedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_enabled')
  bool? get isEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'chapters')
  List<Chapter>? get chapters => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<Tag>? get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryCopyWith<Story> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryCopyWith<$Res> {
  factory $StoryCopyWith(Story value, $Res Function(Story) then) =
      _$StoryCopyWithImpl<$Res, Story>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'author_id') String? authorId,
      @JsonKey(name: 'author') AuthorStory? author,
      @JsonKey(name: 'category_id') String? categoryId,
      @JsonKey(name: 'category') AppCategory? category,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'cover_url') String? coverUrl,
      @JsonKey(name: 'is_draft') bool? isDraft,
      @JsonKey(name: 'is_mature') bool? isMature,
      @JsonKey(name: 'is_completed') bool? isCompleted,
      @JsonKey(name: 'is_copyright') bool? isCopyright,
      @JsonKey(name: 'is_paywalled') bool? isPaywalled,
      @JsonKey(name: 'chapter_price') int? chapterPrice,
      @JsonKey(name: 'coin_cost') int? coinCost,
      @JsonKey(name: 'author_earning_percentage') int? authorEarningPercentage,
      @JsonKey(name: 'paywall_effective_date') String? paywallEffectiveDate,
      @JsonKey(name: 'num_free_chapters') int? numFreeChapters,
      @JsonKey(name: 'published_count') int? publishedCount,
      @JsonKey(name: 'draft_count') int? draftCount,
      @JsonKey(name: 'report_count') int? reportCount,
      @JsonKey(name: 'vote_count') int? voteCount,
      @JsonKey(name: 'read_count') int? readCount,
      @JsonKey(name: 'total_vote') int? totalVote,
      @JsonKey(name: 'total_read') int? totalRead,
      @JsonKey(name: 'total_comment') int? totalComment,
      @JsonKey(name: 'explicit_percentage') int? explicitPercentage,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate,
      @JsonKey(name: 'is_enabled') bool? isEnabled,
      @JsonKey(name: 'chapters') List<Chapter>? chapters,
      @JsonKey(name: 'tags') List<Tag>? tags});

  $AuthorStoryCopyWith<$Res>? get author;
  $AppCategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$StoryCopyWithImpl<$Res, $Val extends Story>
    implements $StoryCopyWith<$Res> {
  _$StoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = freezed,
    Object? author = freezed,
    Object? categoryId = freezed,
    Object? category = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? coverUrl = freezed,
    Object? isDraft = freezed,
    Object? isMature = freezed,
    Object? isCompleted = freezed,
    Object? isCopyright = freezed,
    Object? isPaywalled = freezed,
    Object? chapterPrice = freezed,
    Object? coinCost = freezed,
    Object? authorEarningPercentage = freezed,
    Object? paywallEffectiveDate = freezed,
    Object? numFreeChapters = freezed,
    Object? publishedCount = freezed,
    Object? draftCount = freezed,
    Object? reportCount = freezed,
    Object? voteCount = freezed,
    Object? readCount = freezed,
    Object? totalVote = freezed,
    Object? totalRead = freezed,
    Object? totalComment = freezed,
    Object? explicitPercentage = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? isEnabled = freezed,
    Object? chapters = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as AuthorStory?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as AppCategory?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      coverUrl: freezed == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isDraft: freezed == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool?,
      isMature: freezed == isMature
          ? _value.isMature
          : isMature // ignore: cast_nullable_to_non_nullable
              as bool?,
      isCompleted: freezed == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      isCopyright: freezed == isCopyright
          ? _value.isCopyright
          : isCopyright // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPaywalled: freezed == isPaywalled
          ? _value.isPaywalled
          : isPaywalled // ignore: cast_nullable_to_non_nullable
              as bool?,
      chapterPrice: freezed == chapterPrice
          ? _value.chapterPrice
          : chapterPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      coinCost: freezed == coinCost
          ? _value.coinCost
          : coinCost // ignore: cast_nullable_to_non_nullable
              as int?,
      authorEarningPercentage: freezed == authorEarningPercentage
          ? _value.authorEarningPercentage
          : authorEarningPercentage // ignore: cast_nullable_to_non_nullable
              as int?,
      paywallEffectiveDate: freezed == paywallEffectiveDate
          ? _value.paywallEffectiveDate
          : paywallEffectiveDate // ignore: cast_nullable_to_non_nullable
              as String?,
      numFreeChapters: freezed == numFreeChapters
          ? _value.numFreeChapters
          : numFreeChapters // ignore: cast_nullable_to_non_nullable
              as int?,
      publishedCount: freezed == publishedCount
          ? _value.publishedCount
          : publishedCount // ignore: cast_nullable_to_non_nullable
              as int?,
      draftCount: freezed == draftCount
          ? _value.draftCount
          : draftCount // ignore: cast_nullable_to_non_nullable
              as int?,
      reportCount: freezed == reportCount
          ? _value.reportCount
          : reportCount // ignore: cast_nullable_to_non_nullable
              as int?,
      voteCount: freezed == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int?,
      readCount: freezed == readCount
          ? _value.readCount
          : readCount // ignore: cast_nullable_to_non_nullable
              as int?,
      totalVote: freezed == totalVote
          ? _value.totalVote
          : totalVote // ignore: cast_nullable_to_non_nullable
              as int?,
      totalRead: freezed == totalRead
          ? _value.totalRead
          : totalRead // ignore: cast_nullable_to_non_nullable
              as int?,
      totalComment: freezed == totalComment
          ? _value.totalComment
          : totalComment // ignore: cast_nullable_to_non_nullable
              as int?,
      explicitPercentage: freezed == explicitPercentage
          ? _value.explicitPercentage
          : explicitPercentage // ignore: cast_nullable_to_non_nullable
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
      chapters: freezed == chapters
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<Chapter>?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthorStoryCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $AuthorStoryCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppCategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $AppCategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoryImplCopyWith<$Res> implements $StoryCopyWith<$Res> {
  factory _$$StoryImplCopyWith(
          _$StoryImpl value, $Res Function(_$StoryImpl) then) =
      __$$StoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'author_id') String? authorId,
      @JsonKey(name: 'author') AuthorStory? author,
      @JsonKey(name: 'category_id') String? categoryId,
      @JsonKey(name: 'category') AppCategory? category,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'cover_url') String? coverUrl,
      @JsonKey(name: 'is_draft') bool? isDraft,
      @JsonKey(name: 'is_mature') bool? isMature,
      @JsonKey(name: 'is_completed') bool? isCompleted,
      @JsonKey(name: 'is_copyright') bool? isCopyright,
      @JsonKey(name: 'is_paywalled') bool? isPaywalled,
      @JsonKey(name: 'chapter_price') int? chapterPrice,
      @JsonKey(name: 'coin_cost') int? coinCost,
      @JsonKey(name: 'author_earning_percentage') int? authorEarningPercentage,
      @JsonKey(name: 'paywall_effective_date') String? paywallEffectiveDate,
      @JsonKey(name: 'num_free_chapters') int? numFreeChapters,
      @JsonKey(name: 'published_count') int? publishedCount,
      @JsonKey(name: 'draft_count') int? draftCount,
      @JsonKey(name: 'report_count') int? reportCount,
      @JsonKey(name: 'vote_count') int? voteCount,
      @JsonKey(name: 'read_count') int? readCount,
      @JsonKey(name: 'total_vote') int? totalVote,
      @JsonKey(name: 'total_read') int? totalRead,
      @JsonKey(name: 'total_comment') int? totalComment,
      @JsonKey(name: 'explicit_percentage') int? explicitPercentage,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate,
      @JsonKey(name: 'is_enabled') bool? isEnabled,
      @JsonKey(name: 'chapters') List<Chapter>? chapters,
      @JsonKey(name: 'tags') List<Tag>? tags});

  @override
  $AuthorStoryCopyWith<$Res>? get author;
  @override
  $AppCategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$StoryImplCopyWithImpl<$Res>
    extends _$StoryCopyWithImpl<$Res, _$StoryImpl>
    implements _$$StoryImplCopyWith<$Res> {
  __$$StoryImplCopyWithImpl(
      _$StoryImpl _value, $Res Function(_$StoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = freezed,
    Object? author = freezed,
    Object? categoryId = freezed,
    Object? category = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? coverUrl = freezed,
    Object? isDraft = freezed,
    Object? isMature = freezed,
    Object? isCompleted = freezed,
    Object? isCopyright = freezed,
    Object? isPaywalled = freezed,
    Object? chapterPrice = freezed,
    Object? coinCost = freezed,
    Object? authorEarningPercentage = freezed,
    Object? paywallEffectiveDate = freezed,
    Object? numFreeChapters = freezed,
    Object? publishedCount = freezed,
    Object? draftCount = freezed,
    Object? reportCount = freezed,
    Object? voteCount = freezed,
    Object? readCount = freezed,
    Object? totalVote = freezed,
    Object? totalRead = freezed,
    Object? totalComment = freezed,
    Object? explicitPercentage = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? isEnabled = freezed,
    Object? chapters = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$StoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as AuthorStory?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as AppCategory?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      coverUrl: freezed == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isDraft: freezed == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool?,
      isMature: freezed == isMature
          ? _value.isMature
          : isMature // ignore: cast_nullable_to_non_nullable
              as bool?,
      isCompleted: freezed == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      isCopyright: freezed == isCopyright
          ? _value.isCopyright
          : isCopyright // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPaywalled: freezed == isPaywalled
          ? _value.isPaywalled
          : isPaywalled // ignore: cast_nullable_to_non_nullable
              as bool?,
      chapterPrice: freezed == chapterPrice
          ? _value.chapterPrice
          : chapterPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      coinCost: freezed == coinCost
          ? _value.coinCost
          : coinCost // ignore: cast_nullable_to_non_nullable
              as int?,
      authorEarningPercentage: freezed == authorEarningPercentage
          ? _value.authorEarningPercentage
          : authorEarningPercentage // ignore: cast_nullable_to_non_nullable
              as int?,
      paywallEffectiveDate: freezed == paywallEffectiveDate
          ? _value.paywallEffectiveDate
          : paywallEffectiveDate // ignore: cast_nullable_to_non_nullable
              as String?,
      numFreeChapters: freezed == numFreeChapters
          ? _value.numFreeChapters
          : numFreeChapters // ignore: cast_nullable_to_non_nullable
              as int?,
      publishedCount: freezed == publishedCount
          ? _value.publishedCount
          : publishedCount // ignore: cast_nullable_to_non_nullable
              as int?,
      draftCount: freezed == draftCount
          ? _value.draftCount
          : draftCount // ignore: cast_nullable_to_non_nullable
              as int?,
      reportCount: freezed == reportCount
          ? _value.reportCount
          : reportCount // ignore: cast_nullable_to_non_nullable
              as int?,
      voteCount: freezed == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int?,
      readCount: freezed == readCount
          ? _value.readCount
          : readCount // ignore: cast_nullable_to_non_nullable
              as int?,
      totalVote: freezed == totalVote
          ? _value.totalVote
          : totalVote // ignore: cast_nullable_to_non_nullable
              as int?,
      totalRead: freezed == totalRead
          ? _value.totalRead
          : totalRead // ignore: cast_nullable_to_non_nullable
              as int?,
      totalComment: freezed == totalComment
          ? _value.totalComment
          : totalComment // ignore: cast_nullable_to_non_nullable
              as int?,
      explicitPercentage: freezed == explicitPercentage
          ? _value.explicitPercentage
          : explicitPercentage // ignore: cast_nullable_to_non_nullable
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
      chapters: freezed == chapters
          ? _value._chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<Chapter>?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryImpl with DiagnosticableTreeMixin implements _Story {
  const _$StoryImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'author_id') this.authorId,
      @JsonKey(name: 'author') this.author,
      @JsonKey(name: 'category_id') this.categoryId,
      @JsonKey(name: 'category') this.category,
      @JsonKey(name: 'title') this.title = '',
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'cover_url') this.coverUrl,
      @JsonKey(name: 'is_draft') this.isDraft,
      @JsonKey(name: 'is_mature') this.isMature,
      @JsonKey(name: 'is_completed') this.isCompleted,
      @JsonKey(name: 'is_copyright') this.isCopyright,
      @JsonKey(name: 'is_paywalled') this.isPaywalled,
      @JsonKey(name: 'chapter_price') this.chapterPrice,
      @JsonKey(name: 'coin_cost') this.coinCost,
      @JsonKey(name: 'author_earning_percentage') this.authorEarningPercentage,
      @JsonKey(name: 'paywall_effective_date') this.paywallEffectiveDate,
      @JsonKey(name: 'num_free_chapters') this.numFreeChapters,
      @JsonKey(name: 'published_count') this.publishedCount,
      @JsonKey(name: 'draft_count') this.draftCount,
      @JsonKey(name: 'report_count') this.reportCount,
      @JsonKey(name: 'vote_count') this.voteCount,
      @JsonKey(name: 'read_count') this.readCount,
      @JsonKey(name: 'total_vote') this.totalVote,
      @JsonKey(name: 'total_read') this.totalRead,
      @JsonKey(name: 'total_comment') this.totalComment,
      @JsonKey(name: 'explicit_percentage') this.explicitPercentage,
      @JsonKey(name: 'created_date') this.createdDate,
      @JsonKey(name: 'updated_date') this.updatedDate,
      @JsonKey(name: 'is_enabled') this.isEnabled,
      @JsonKey(name: 'chapters') final List<Chapter>? chapters = const [],
      @JsonKey(name: 'tags') final List<Tag>? tags = const []})
      : _chapters = chapters,
        _tags = tags;

  factory _$StoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'author_id')
  final String? authorId;
  @override
  @JsonKey(name: 'author')
  final AuthorStory? author;
  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
// Story position
  @override
  @JsonKey(name: 'category')
  final AppCategory? category;
// Story position
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'cover_url')
  final String? coverUrl;
  @override
  @JsonKey(name: 'is_draft')
  final bool? isDraft;
  @override
  @JsonKey(name: 'is_mature')
  final bool? isMature;
  @override
  @JsonKey(name: 'is_completed')
  final bool? isCompleted;
  @override
  @JsonKey(name: 'is_copyright')
  final bool? isCopyright;
  @override
  @JsonKey(name: 'is_paywalled')
  final bool? isPaywalled;
  @override
  @JsonKey(name: 'chapter_price')
  final int? chapterPrice;
  @override
  @JsonKey(name: 'coin_cost')
  final int? coinCost;
  @override
  @JsonKey(name: 'author_earning_percentage')
  final int? authorEarningPercentage;
  @override
  @JsonKey(name: 'paywall_effective_date')
  final String? paywallEffectiveDate;
  @override
  @JsonKey(name: 'num_free_chapters')
  final int? numFreeChapters;
  @override
  @JsonKey(name: 'published_count')
  final int? publishedCount;
  @override
  @JsonKey(name: 'draft_count')
  final int? draftCount;
  @override
  @JsonKey(name: 'report_count')
  final int? reportCount;
  @override
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  @override
  @JsonKey(name: 'read_count')
  final int? readCount;
  @override
  @JsonKey(name: 'total_vote')
  final int? totalVote;
  @override
  @JsonKey(name: 'total_read')
  final int? totalRead;
  @override
  @JsonKey(name: 'total_comment')
  final int? totalComment;
  @override
  @JsonKey(name: 'explicit_percentage')
  final int? explicitPercentage;
  @override
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @override
  @JsonKey(name: 'updated_date')
  final String? updatedDate;
  @override
  @JsonKey(name: 'is_enabled')
  final bool? isEnabled;
  final List<Chapter>? _chapters;
  @override
  @JsonKey(name: 'chapters')
  List<Chapter>? get chapters {
    final value = _chapters;
    if (value == null) return null;
    if (_chapters is EqualUnmodifiableListView) return _chapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Tag>? _tags;
  @override
  @JsonKey(name: 'tags')
  List<Tag>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Story(id: $id, authorId: $authorId, author: $author, categoryId: $categoryId, category: $category, title: $title, description: $description, coverUrl: $coverUrl, isDraft: $isDraft, isMature: $isMature, isCompleted: $isCompleted, isCopyright: $isCopyright, isPaywalled: $isPaywalled, chapterPrice: $chapterPrice, coinCost: $coinCost, authorEarningPercentage: $authorEarningPercentage, paywallEffectiveDate: $paywallEffectiveDate, numFreeChapters: $numFreeChapters, publishedCount: $publishedCount, draftCount: $draftCount, reportCount: $reportCount, voteCount: $voteCount, readCount: $readCount, totalVote: $totalVote, totalRead: $totalRead, totalComment: $totalComment, explicitPercentage: $explicitPercentage, createdDate: $createdDate, updatedDate: $updatedDate, isEnabled: $isEnabled, chapters: $chapters, tags: $tags)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Story'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('authorId', authorId))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('categoryId', categoryId))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('coverUrl', coverUrl))
      ..add(DiagnosticsProperty('isDraft', isDraft))
      ..add(DiagnosticsProperty('isMature', isMature))
      ..add(DiagnosticsProperty('isCompleted', isCompleted))
      ..add(DiagnosticsProperty('isCopyright', isCopyright))
      ..add(DiagnosticsProperty('isPaywalled', isPaywalled))
      ..add(DiagnosticsProperty('chapterPrice', chapterPrice))
      ..add(DiagnosticsProperty('coinCost', coinCost))
      ..add(DiagnosticsProperty(
          'authorEarningPercentage', authorEarningPercentage))
      ..add(DiagnosticsProperty('paywallEffectiveDate', paywallEffectiveDate))
      ..add(DiagnosticsProperty('numFreeChapters', numFreeChapters))
      ..add(DiagnosticsProperty('publishedCount', publishedCount))
      ..add(DiagnosticsProperty('draftCount', draftCount))
      ..add(DiagnosticsProperty('reportCount', reportCount))
      ..add(DiagnosticsProperty('voteCount', voteCount))
      ..add(DiagnosticsProperty('readCount', readCount))
      ..add(DiagnosticsProperty('totalVote', totalVote))
      ..add(DiagnosticsProperty('totalRead', totalRead))
      ..add(DiagnosticsProperty('totalComment', totalComment))
      ..add(DiagnosticsProperty('explicitPercentage', explicitPercentage))
      ..add(DiagnosticsProperty('createdDate', createdDate))
      ..add(DiagnosticsProperty('updatedDate', updatedDate))
      ..add(DiagnosticsProperty('isEnabled', isEnabled))
      ..add(DiagnosticsProperty('chapters', chapters))
      ..add(DiagnosticsProperty('tags', tags));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            (identical(other.isDraft, isDraft) || other.isDraft == isDraft) &&
            (identical(other.isMature, isMature) ||
                other.isMature == isMature) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isCopyright, isCopyright) ||
                other.isCopyright == isCopyright) &&
            (identical(other.isPaywalled, isPaywalled) ||
                other.isPaywalled == isPaywalled) &&
            (identical(other.chapterPrice, chapterPrice) ||
                other.chapterPrice == chapterPrice) &&
            (identical(other.coinCost, coinCost) ||
                other.coinCost == coinCost) &&
            (identical(
                    other.authorEarningPercentage, authorEarningPercentage) ||
                other.authorEarningPercentage == authorEarningPercentage) &&
            (identical(other.paywallEffectiveDate, paywallEffectiveDate) ||
                other.paywallEffectiveDate == paywallEffectiveDate) &&
            (identical(other.numFreeChapters, numFreeChapters) ||
                other.numFreeChapters == numFreeChapters) &&
            (identical(other.publishedCount, publishedCount) ||
                other.publishedCount == publishedCount) &&
            (identical(other.draftCount, draftCount) ||
                other.draftCount == draftCount) &&
            (identical(other.reportCount, reportCount) ||
                other.reportCount == reportCount) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            (identical(other.readCount, readCount) ||
                other.readCount == readCount) &&
            (identical(other.totalVote, totalVote) ||
                other.totalVote == totalVote) &&
            (identical(other.totalRead, totalRead) ||
                other.totalRead == totalRead) &&
            (identical(other.totalComment, totalComment) ||
                other.totalComment == totalComment) &&
            (identical(other.explicitPercentage, explicitPercentage) ||
                other.explicitPercentage == explicitPercentage) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            const DeepCollectionEquality().equals(other._chapters, _chapters) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        authorId,
        author,
        categoryId,
        category,
        title,
        description,
        coverUrl,
        isDraft,
        isMature,
        isCompleted,
        isCopyright,
        isPaywalled,
        chapterPrice,
        coinCost,
        authorEarningPercentage,
        paywallEffectiveDate,
        numFreeChapters,
        publishedCount,
        draftCount,
        reportCount,
        voteCount,
        readCount,
        totalVote,
        totalRead,
        totalComment,
        explicitPercentage,
        createdDate,
        updatedDate,
        isEnabled,
        const DeepCollectionEquality().hash(_chapters),
        const DeepCollectionEquality().hash(_tags)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryImplCopyWith<_$StoryImpl> get copyWith =>
      __$$StoryImplCopyWithImpl<_$StoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryImplToJson(
      this,
    );
  }
}

abstract class _Story implements Story {
  const factory _Story(
      {@JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'author_id') final String? authorId,
      @JsonKey(name: 'author') final AuthorStory? author,
      @JsonKey(name: 'category_id') final String? categoryId,
      @JsonKey(name: 'category') final AppCategory? category,
      @JsonKey(name: 'title') final String title,
      @JsonKey(name: 'description') final String? description,
      @JsonKey(name: 'cover_url') final String? coverUrl,
      @JsonKey(name: 'is_draft') final bool? isDraft,
      @JsonKey(name: 'is_mature') final bool? isMature,
      @JsonKey(name: 'is_completed') final bool? isCompleted,
      @JsonKey(name: 'is_copyright') final bool? isCopyright,
      @JsonKey(name: 'is_paywalled') final bool? isPaywalled,
      @JsonKey(name: 'chapter_price') final int? chapterPrice,
      @JsonKey(name: 'coin_cost') final int? coinCost,
      @JsonKey(name: 'author_earning_percentage')
      final int? authorEarningPercentage,
      @JsonKey(name: 'paywall_effective_date')
      final String? paywallEffectiveDate,
      @JsonKey(name: 'num_free_chapters') final int? numFreeChapters,
      @JsonKey(name: 'published_count') final int? publishedCount,
      @JsonKey(name: 'draft_count') final int? draftCount,
      @JsonKey(name: 'report_count') final int? reportCount,
      @JsonKey(name: 'vote_count') final int? voteCount,
      @JsonKey(name: 'read_count') final int? readCount,
      @JsonKey(name: 'total_vote') final int? totalVote,
      @JsonKey(name: 'total_read') final int? totalRead,
      @JsonKey(name: 'total_comment') final int? totalComment,
      @JsonKey(name: 'explicit_percentage') final int? explicitPercentage,
      @JsonKey(name: 'created_date') final String? createdDate,
      @JsonKey(name: 'updated_date') final String? updatedDate,
      @JsonKey(name: 'is_enabled') final bool? isEnabled,
      @JsonKey(name: 'chapters') final List<Chapter>? chapters,
      @JsonKey(name: 'tags') final List<Tag>? tags}) = _$StoryImpl;

  factory _Story.fromJson(Map<String, dynamic> json) = _$StoryImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'author_id')
  String? get authorId;
  @override
  @JsonKey(name: 'author')
  AuthorStory? get author;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override // Story position
  @JsonKey(name: 'category')
  AppCategory? get category;
  @override // Story position
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'cover_url')
  String? get coverUrl;
  @override
  @JsonKey(name: 'is_draft')
  bool? get isDraft;
  @override
  @JsonKey(name: 'is_mature')
  bool? get isMature;
  @override
  @JsonKey(name: 'is_completed')
  bool? get isCompleted;
  @override
  @JsonKey(name: 'is_copyright')
  bool? get isCopyright;
  @override
  @JsonKey(name: 'is_paywalled')
  bool? get isPaywalled;
  @override
  @JsonKey(name: 'chapter_price')
  int? get chapterPrice;
  @override
  @JsonKey(name: 'coin_cost')
  int? get coinCost;
  @override
  @JsonKey(name: 'author_earning_percentage')
  int? get authorEarningPercentage;
  @override
  @JsonKey(name: 'paywall_effective_date')
  String? get paywallEffectiveDate;
  @override
  @JsonKey(name: 'num_free_chapters')
  int? get numFreeChapters;
  @override
  @JsonKey(name: 'published_count')
  int? get publishedCount;
  @override
  @JsonKey(name: 'draft_count')
  int? get draftCount;
  @override
  @JsonKey(name: 'report_count')
  int? get reportCount;
  @override
  @JsonKey(name: 'vote_count')
  int? get voteCount;
  @override
  @JsonKey(name: 'read_count')
  int? get readCount;
  @override
  @JsonKey(name: 'total_vote')
  int? get totalVote;
  @override
  @JsonKey(name: 'total_read')
  int? get totalRead;
  @override
  @JsonKey(name: 'total_comment')
  int? get totalComment;
  @override
  @JsonKey(name: 'explicit_percentage')
  int? get explicitPercentage;
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
  @JsonKey(name: 'chapters')
  List<Chapter>? get chapters;
  @override
  @JsonKey(name: 'tags')
  List<Tag>? get tags;
  @override
  @JsonKey(ignore: true)
  _$$StoryImplCopyWith<_$StoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
