// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fridge_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFridgeResponse _$GetFridgeResponseFromJson(Map<String, dynamic> json) =>
    GetFridgeResponse(
      json['message'] as String,
      GetFridge.fromJson(json['fridge'] as Map<String, dynamic>),
      (json['warnings'] as List<dynamic>)
          .map((e) => Warning.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetFridgeResponseToJson(GetFridgeResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'fridge': instance.fridge,
      'warnings': instance.warnings,
    };
