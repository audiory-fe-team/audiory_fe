// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReadingList _$$_ReadingListFromJson(Map<String, dynamic> json) =>
    _$_ReadingList(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      coverUrl: json['cover_url'] as String? ?? FALLBACK_IMG_URL,
      createdDate: json['created_date'] as String? ?? '',
      updatedDate: json['updated_date'] as String? ?? '',
      isPrivate: json['is_private'] as bool?,
      isEnabled: json['is_enabled'] as bool?,
      stories: (json['stories'] as List<dynamic>?)
              ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ReadingListToJson(_$_ReadingList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'user_id': instance.userId,
      'cover_url': instance.coverUrl,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
      'is_private': instance.isPrivate,
      'is_enabled': instance.isEnabled,
      'stories': instance.stories?.map((e) => e.toJson()).toList(),
    };
