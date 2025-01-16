// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_meals_meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllMealsMeal _$GetAllMealsMealFromJson(Map<String, dynamic> json) =>
    GetAllMealsMeal(
      json['id'] as String,
      json['name'] as String,
      json['summary'] as String,
      (json['readyInMinutes'] as num).toDouble(),
      json['image'] as String,
      json['lastPreparedAt'] as String?,
      json['wasPrepared'] as bool,
      json['profileId'] as String,
      json['ingredientsJson'] as String?,
    );

Map<String, dynamic> _$GetAllMealsMealToJson(GetAllMealsMeal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'summary': instance.summary,
      'readyInMinutes': instance.readyInMinutes,
      'image': instance.image,
      'lastPreparedAt': instance.lastPreparedAt,
      'wasPrepared': instance.wasPrepared,
      'profileId': instance.profileId,
      'ingredientsJson': instance.ingredientsJson,
    };
