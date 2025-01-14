// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fridge_ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFridgeIngredient _$GetFridgeIngredientFromJson(Map<String, dynamic> json) =>
    GetFridgeIngredient(
      json['ingredientId'] as String,
      json['name'] as String,
      (json['caloriesPer100Grams'] as num).toDouble(),
      (json['quantity'] as num).toDouble(),
      json['ingredientMeasuringUnitSuffix'] as String,
    );

Map<String, dynamic> _$GetFridgeIngredientToJson(
        GetFridgeIngredient instance) =>
    <String, dynamic>{
      'ingredientId': instance.ingredientId,
      'name': instance.name,
      'caloriesPer100Grams': instance.caloriesPer100Grams,
      'quantity': instance.quantity,
      'ingredientMeasuringUnitSuffix': instance.ingredientMeasuringUnitSuffix,
    };
