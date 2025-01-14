// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_meals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMeals _$SearchMealsFromJson(Map<String, dynamic> json) => SearchMeals(
      json['query'] as String,
      (json['cuisineId'] as num?)?.toInt(),
      json['useProfileDiet'] as bool,
      (json['dietId'] as num?)?.toInt(),
      json['useAllFridgeIngredients'] as bool,
      (json['ingredients'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['mealTypeId'] as num).toInt(),
      (json['minCalories'] as num?)?.toDouble(),
      (json['maxCalories'] as num?)?.toDouble(),
      json['includeProfileAlergens'] as bool,
      (json['excludedProfileAlergens'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SearchMealsToJson(SearchMeals instance) =>
    <String, dynamic>{
      'query': instance.query,
      'cuisineId': instance.cuisineId,
      'useProfileDiet': instance.useProfileDiet,
      'dietId': instance.dietId,
      'useAllFridgeIngredients': instance.useAllFridgeIngredients,
      'ingredients': instance.ingredients,
      'mealTypeId': instance.mealTypeId,
      'minCalories': instance.minCalories,
      'maxCalories': instance.maxCalories,
      'includeProfileAlergens': instance.includeProfileAlergens,
      'excludedProfileAlergens': instance.excludedProfileAlergens,
    };
