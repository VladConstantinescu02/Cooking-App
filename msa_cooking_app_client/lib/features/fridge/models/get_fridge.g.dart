// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fridge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFridge _$GetFridgeFromJson(Map<String, dynamic> json) => GetFridge(
      json['fridgeName'] as String?,
      (json['fridgeIngredients'] as List<dynamic>?)
          ?.map((e) => GetFridgeIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['fridgeAlergensIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$GetFridgeToJson(GetFridge instance) => <String, dynamic>{
      'fridgeName': instance.fridgeName,
      'fridgeIngredients': instance.fridgeIngredients,
      'fridgeAlergensIds': instance.fridgeAlergensIds,
    };
