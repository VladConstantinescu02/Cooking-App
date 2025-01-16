// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoonacular_search_meal_result_meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpoonacularSearchMealResultMeal _$SpoonacularSearchMealResultMealFromJson(
        Map<String, dynamic> json) =>
    SpoonacularSearchMealResultMeal(
      json['id'] as String,
      (json['usedIngredientCount'] as num).toInt(),
      (json['missedIngredientCount'] as num).toInt(),
      json['title'] as String,
      json['image'] as String?,
      (json['missedIngredients'] as List<dynamic>?)
          ?.map((e) => SpoonacularSearchMealIngredientResult.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      (json['usedIngredients'] as List<dynamic>?)
          ?.map((e) => SpoonacularSearchMealIngredientResult.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpoonacularSearchMealResultMealToJson(
        SpoonacularSearchMealResultMeal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'usedIngredientCount': instance.usedIngredientCount,
      'missedIngredientCount': instance.missedIngredientCount,
      'title': instance.title,
      'image': instance.image,
      'missedIngredients': instance.missedIngredients,
      'usedIngredients': instance.usedIngredients,
    };
