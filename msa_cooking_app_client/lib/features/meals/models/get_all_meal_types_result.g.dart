// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_meal_types_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllMealTypesResult _$GetAllMealTypesResultFromJson(
        Map<String, dynamic> json) =>
    GetAllMealTypesResult(
      json['message'] as String,
      (json['mealTypes'] as List<dynamic>)
          .map((e) => GetMealType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllMealTypesResultToJson(
        GetAllMealTypesResult instance) =>
    <String, dynamic>{
      'message': instance.message,
      'mealTypes': instance.mealTypes,
    };
