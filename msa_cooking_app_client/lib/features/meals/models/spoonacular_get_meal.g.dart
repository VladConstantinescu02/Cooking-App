// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoonacular_get_meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpoonacularGetMeal _$SpoonacularGetMealFromJson(Map<String, dynamic> json) =>
    SpoonacularGetMeal(
      json['id'] as String,
      json['title'] as String,
      (json['readyInMinutes'] as num).toDouble(),
      json['image'] as String?,
      json['summary'] as String?,
      (json['cuisines'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['dishTypes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['diets'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['analyzedInstructions'] as List<dynamic>)
          .map((e) => SpoonacularGetMealInstructions.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      (json['extendedIngredients'] as List<dynamic>)
          .map((e) =>
              SpoonacularGetMealIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpoonacularGetMealToJson(SpoonacularGetMeal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'readyInMinutes': instance.readyInMinutes,
      'image': instance.image,
      'summary': instance.summary,
      'cuisines': instance.cuisines,
      'dishTypes': instance.dishTypes,
      'diets': instance.diets,
      'analyzedInstructions': instance.analyzedInstructions,
      'extendedIngredients': instance.extendedIngredients,
    };
