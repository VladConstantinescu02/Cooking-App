// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_dietary_options_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllDietaryOptionsResponse _$GetAllDietaryOptionsResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllDietaryOptionsResponse(
      json['message'] as String,
      (json['dietaryOptions'] as List<dynamic>)
          .map((e) => GetDietaryOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllDietaryOptionsResponseToJson(
        GetAllDietaryOptionsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'dietaryOptions': instance.dietaryOptions,
    };
