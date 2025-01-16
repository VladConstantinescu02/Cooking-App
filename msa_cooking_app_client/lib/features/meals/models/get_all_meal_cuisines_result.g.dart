// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_meal_cuisines_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllMealCuisinesResult _$GetAllMealCuisinesResultFromJson(
        Map<String, dynamic> json) =>
    GetAllMealCuisinesResult(
      json['message'] as String,
      (json['mealCuisines'] as List<dynamic>)
          .map((e) => GetMealCuisine.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllMealCuisinesResultToJson(
        GetAllMealCuisinesResult instance) =>
    <String, dynamic>{
      'message': instance.message,
      'mealCuisines': instance.mealCuisines,
    };
