// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Streak _$$_StreakFromJson(Map<String, dynamic> json) => _$_Streak(
      name: json['name'] as String,
      hasReceived: json['has_received'] as bool? ?? false,
      amount: json['amount'] as int? ?? 0,
    );

Map<String, dynamic> _$$_StreakToJson(_$_Streak instance) => <String, dynamic>{
      'name': instance.name,
      'has_received': instance.hasReceived,
      'amount': instance.amount,
    };
