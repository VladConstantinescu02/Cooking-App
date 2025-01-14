// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_fridge_ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFridgeIngredient _$AddFridgeIngredientFromJson(Map<String, dynamic> json) =>
    AddFridgeIngredient(
      json['ingredientId'] as String,
      (json['ingredientQuantity'] as num).toDouble(),
      (json['ingredientMeasuringUnitId'] as num).toInt(),
    );

Map<String, dynamic> _$AddFridgeIngredientToJson(
        AddFridgeIngredient instance) =>
    <String, dynamic>{
      'ingredientId': instance.ingredientId,
      'ingredientQuantity': instance.ingredientQuantity,
      'ingredientMeasuringUnitId': instance.ingredientMeasuringUnitId,
    };
