// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_meals_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllMealsResult _$GetAllMealsResultFromJson(Map<String, dynamic> json) =>
    GetAllMealsResult(
      json['message'] as String,
      (json['meals'] as List<dynamic>)
          .map((e) => GetAllMealsMeal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllMealsResultToJson(GetAllMealsResult instance) =>
    <String, dynamic>{
      'message': instance.message,
      'meals': instance.meals,
    };
