// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoonacular_search_meal_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpoonacularSearchMealResult _$SpoonacularSearchMealResultFromJson(
        Map<String, dynamic> json) =>
    SpoonacularSearchMealResult(
      (json['results'] as List<dynamic>)
          .map((e) => SpoonacularSearchMealResultMeal.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpoonacularSearchMealResultToJson(
        SpoonacularSearchMealResult instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
