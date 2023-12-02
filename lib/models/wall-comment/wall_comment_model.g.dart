// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wall_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WallCommentImpl _$$WallCommentImplFromJson(Map<String, dynamic> json) =>
    _$WallCommentImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      isLiked: json['is_liked'] as bool? ?? false,
      parentId: json['parent_id'] as String? ?? null,
      user: json['user'] == null
          ? null
          : Profile.fromJson(json['user'] as Map<String, dynamic>),
      createdDate: json['created_date'] as String? ?? '',
      updatedDate: json['updated_date'] as String? ?? '',
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => WallComment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WallCommentImplToJson(_$WallCommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'text': instance.text,
      'is_liked': instance.isLiked,
      'parent_id': instance.parentId,
      'user': instance.user?.toJson(),
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
      'children': instance.children?.map((e) => e.toJson()).toList(),
    };
