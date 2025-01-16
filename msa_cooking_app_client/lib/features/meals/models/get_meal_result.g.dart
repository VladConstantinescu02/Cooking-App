// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_meal_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMealResult _$GetMealResultFromJson(Map<String, dynamic> json) =>
    GetMealResult(
      json['message'] as String,
      GetMeal.fromJson(json['meal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMealResultToJson(GetMealResult instance) =>
    <String, dynamic>{
      'message': instance.message,
      'meal': instance.meal,
    };
