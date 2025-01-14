// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ingredient_measuring_units_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetIngredientMeasuringUnitsResponse
    _$GetIngredientMeasuringUnitsResponseFromJson(Map<String, dynamic> json) =>
        GetIngredientMeasuringUnitsResponse(
          json['message'] as String,
          (json['ingredientMeasuringUnits'] as List<dynamic>)
              .map((e) => GetIngredientMeasuringUnit.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetIngredientMeasuringUnitsResponseToJson(
        GetIngredientMeasuringUnitsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'ingredientMeasuringUnits': instance.ingredientMeasuringUnits,
    };
