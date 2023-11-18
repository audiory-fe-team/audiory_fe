// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StreakImpl _$$StreakImplFromJson(Map<String, dynamic> json) => _$StreakImpl(
      name: json['name'] as String,
      hasReceived: json['has_received'] as bool? ?? false,
      isToday: json['is_today'] as bool? ?? false,
      amount: json['amount'] as int? ?? 0,
    );

Map<String, dynamic> _$$StreakImplToJson(_$StreakImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'has_received': instance.hasReceived,
      'is_today': instance.isToday,
      'amount': instance.amount,
    };
