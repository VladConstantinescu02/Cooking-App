// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoonacular_search_meal_ingredient_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpoonacularSearchMealIngredientResult
    _$SpoonacularSearchMealIngredientResultFromJson(
            Map<String, dynamic> json) =>
        SpoonacularSearchMealIngredientResult(
          json['id'] as String,
          (json['amount'] as num).toDouble(),
          json['unit'] as String?,
          json['unitShort'] as String?,
          json['name'] as String,
          json['image'] as String?,
        );

Map<String, dynamic> _$SpoonacularSearchMealIngredientResultToJson(
        SpoonacularSearchMealIngredientResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'unit': instance.unit,
      'unitShort': instance.unitShort,
      'name': instance.name,
      'image': instance.image,
    };
