// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMeal _$GetMealFromJson(Map<String, dynamic> json) => GetMeal(
      json['meal'] == null
          ? null
          : SpoonacularGetMeal.fromJson(json['meal'] as Map<String, dynamic>),
      json['lastPreparedAt'] as String?,
      json['wasPrepared'] as bool,
    );

Map<String, dynamic> _$GetMealToJson(GetMeal instance) => <String, dynamic>{
      'meal': instance.meal,
      'lastPreparedAt': instance.lastPreparedAt,
      'wasPrepared': instance.wasPrepared,
    };
