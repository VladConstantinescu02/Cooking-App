// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_meal_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMealType _$GetMealTypeFromJson(Map<String, dynamic> json) => GetMealType(
      (json['id'] as num).toInt(),
      json['type'] as String,
    );

Map<String, dynamic> _$GetMealTypeToJson(GetMealType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };
