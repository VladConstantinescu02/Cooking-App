// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoonacular_get_meal_ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpoonacularGetMealIngredient _$SpoonacularGetMealIngredientFromJson(
        Map<String, dynamic> json) =>
    SpoonacularGetMealIngredient(
      json['id'] as String,
      json['name'] as String,
      json['original'] as String?,
      (json['amount'] as num?)?.toDouble(),
      json['unit'] as String?,
    );

Map<String, dynamic> _$SpoonacularGetMealIngredientToJson(
        SpoonacularGetMealIngredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'original': instance.original,
      'amount': instance.amount,
      'unit': instance.unit,
    };
