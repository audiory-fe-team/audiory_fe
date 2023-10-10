// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthorStory _$$_AuthorStoryFromJson(Map<String, dynamic> json) =>
    _$_AuthorStory(
      id: json['id'] as String,
      fullName: json['full_name'] as String? ?? '',
      sex: json['sex'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      registrationTokens: json['registration_tokens'] as String? ?? '',
      roleId: json['role_id'] as String? ?? '',
    );

Map<String, dynamic> _$$_AuthorStoryToJson(_$_AuthorStory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'sex': instance.sex,
      'avatar_url': instance.avatarUrl,
      'registration_tokens': instance.registrationTokens,
      'role_id': instance.roleId,
    };
