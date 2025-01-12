// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_dietary_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDietaryOption _$GetDietaryOptionFromJson(Map<String, dynamic> json) =>
    GetDietaryOption(
      (json['id'] as num).toInt(),
      json['name'] as String,
    );

Map<String, dynamic> _$GetDietaryOptionToJson(GetDietaryOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
