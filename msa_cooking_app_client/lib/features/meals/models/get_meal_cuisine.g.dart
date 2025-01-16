// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_meal_cuisine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMealCuisine _$GetMealCuisineFromJson(Map<String, dynamic> json) =>
    GetMealCuisine(
      (json['id'] as num).toInt(),
      json['cuisine'] as String,
    );

Map<String, dynamic> _$GetMealCuisineToJson(GetMealCuisine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cuisine': instance.cuisine,
    };
