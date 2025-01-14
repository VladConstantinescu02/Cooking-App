// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ingredient_measuring_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetIngredientMeasuringUnit _$GetIngredientMeasuringUnitFromJson(
        Map<String, dynamic> json) =>
    GetIngredientMeasuringUnit(
      (json['id'] as num).toInt(),
      json['unitName'] as String,
      json['unitSuffix'] as String,
    );

Map<String, dynamic> _$GetIngredientMeasuringUnitToJson(
        GetIngredientMeasuringUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unitName': instance.unitName,
      'unitSuffix': instance.unitSuffix,
    };
