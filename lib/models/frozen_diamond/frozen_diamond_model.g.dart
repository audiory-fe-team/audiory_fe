// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frozen_diamond_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FrozenDiamondImpl _$$FrozenDiamondImplFromJson(Map<String, dynamic> json) =>
    _$FrozenDiamondImpl(
      storyId: json['story_id'] as String? ?? '',
      amount: json['amount'] ?? 0,
      unfrozenDate: json['unfrozen_date'] as String?,
      story: json['story'] == null
          ? null
          : Story.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FrozenDiamondImplToJson(_$FrozenDiamondImpl instance) =>
    <String, dynamic>{
      'story_id': instance.storyId,
      'amount': instance.amount,
      'unfrozen_date': instance.unfrozenDate,
      'story': instance.story?.toJson(),
    };
