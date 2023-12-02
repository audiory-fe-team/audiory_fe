// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wall_comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WallComment _$WallCommentFromJson(Map<String, dynamic> json) {
  return _WallComment.fromJson(json);
}

/// @nodoc
mixin _$WallComment {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'text')
  String? get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_liked')
  bool? get isLiked => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_id')
  String? get parentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  Profile? get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  String? get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_date')
  String? get updatedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'children')
  List<WallComment>? get children => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WallCommentCopyWith<WallComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallCommentCopyWith<$Res> {
  factory $WallCommentCopyWith(
          WallComment value, $Res Function(WallComment) then) =
      _$WallCommentCopyWithImpl<$Res, WallComment>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'text') String? text,
      @JsonKey(name: 'is_liked') bool? isLiked,
      @JsonKey(name: 'parent_id') String? parentId,
      @JsonKey(name: 'user') Profile? user,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate,
      @JsonKey(name: 'children') List<WallComment>? children});
}

/// @nodoc
class _$WallCommentCopyWithImpl<$Res, $Val extends WallComment>
    implements $WallCommentCopyWith<$Res> {
  _$WallCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? text = freezed,
    Object? isLiked = freezed,
    Object? parentId = freezed,
    Object? user = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? children = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      isLiked: freezed == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as Profile?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      children: freezed == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<WallComment>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WallCommentImplCopyWith<$Res>
    implements $WallCommentCopyWith<$Res> {
  factory _$$WallCommentImplCopyWith(
          _$WallCommentImpl value, $Res Function(_$WallCommentImpl) then) =
      __$$WallCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'text') String? text,
      @JsonKey(name: 'is_liked') bool? isLiked,
      @JsonKey(name: 'parent_id') String? parentId,
      @JsonKey(name: 'user') Profile? user,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate,
      @JsonKey(name: 'children') List<WallComment>? children});
}

/// @nodoc
class __$$WallCommentImplCopyWithImpl<$Res>
    extends _$WallCommentCopyWithImpl<$Res, _$WallCommentImpl>
    implements _$$WallCommentImplCopyWith<$Res> {
  __$$WallCommentImplCopyWithImpl(
      _$WallCommentImpl _value, $Res Function(_$WallCommentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? text = freezed,
    Object? isLiked = freezed,
    Object? parentId = freezed,
    Object? user = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? children = freezed,
  }) {
    return _then(_$WallCommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      isLiked: freezed == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as Profile?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      children: freezed == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<WallComment>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WallCommentImpl implements _WallComment {
  const _$WallCommentImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'user_id') this.userId = '',
      @JsonKey(name: 'text') this.text = '',
      @JsonKey(name: 'is_liked') this.isLiked = false,
      @JsonKey(name: 'parent_id') this.parentId = null,
      @JsonKey(name: 'user') this.user,
      @JsonKey(name: 'created_date') this.createdDate = '',
      @JsonKey(name: 'updated_date') this.updatedDate = '',
      @JsonKey(name: 'children') final List<WallComment>? children = const []})
      : _children = children;

  factory _$WallCommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallCommentImplFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'text')
  final String? text;
  @override
  @JsonKey(name: 'is_liked')
  final bool? isLiked;
  @override
  @JsonKey(name: 'parent_id')
  final String? parentId;
  @override
  @JsonKey(name: 'user')
  final Profile? user;
  @override
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @override
  @JsonKey(name: 'updated_date')
  final String? updatedDate;
  final List<WallComment>? _children;
  @override
  @JsonKey(name: 'children')
  List<WallComment>? get children {
    final value = _children;
    if (value == null) return null;
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WallComment(id: $id, userId: $userId, text: $text, isLiked: $isLiked, parentId: $parentId, user: $user, createdDate: $createdDate, updatedDate: $updatedDate, children: $children)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallCommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      text,
      isLiked,
      parentId,
      user,
      createdDate,
      updatedDate,
      const DeepCollectionEquality().hash(_children));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WallCommentImplCopyWith<_$WallCommentImpl> get copyWith =>
      __$$WallCommentImplCopyWithImpl<_$WallCommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WallCommentImplToJson(
      this,
    );
  }
}

abstract class _WallComment implements WallComment {
  const factory _WallComment(
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'user_id') final String? userId,
          @JsonKey(name: 'text') final String? text,
          @JsonKey(name: 'is_liked') final bool? isLiked,
          @JsonKey(name: 'parent_id') final String? parentId,
          @JsonKey(name: 'user') final Profile? user,
          @JsonKey(name: 'created_date') final String? createdDate,
          @JsonKey(name: 'updated_date') final String? updatedDate,
          @JsonKey(name: 'children') final List<WallComment>? children}) =
      _$WallCommentImpl;

  factory _WallComment.fromJson(Map<String, dynamic> json) =
      _$WallCommentImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'text')
  String? get text;
  @override
  @JsonKey(name: 'is_liked')
  bool? get isLiked;
  @override
  @JsonKey(name: 'parent_id')
  String? get parentId;
  @override
  @JsonKey(name: 'user')
  Profile? get user;
  @override
  @JsonKey(name: 'created_date')
  String? get createdDate;
  @override
  @JsonKey(name: 'updated_date')
  String? get updatedDate;
  @override
  @JsonKey(name: 'children')
  List<WallComment>? get children;
  @override
  @JsonKey(ignore: true)
  _$$WallCommentImplCopyWith<_$WallCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
