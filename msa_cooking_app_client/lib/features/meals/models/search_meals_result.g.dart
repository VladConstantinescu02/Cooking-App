// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_meals_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMealsResult _$SearchMealsResultFromJson(Map<String, dynamic> json) =>
    SearchMealsResult(
      json['message'] as String,
      json['result'] == null
          ? null
          : SpoonacularSearchMealResult.fromJson(
              json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchMealsResultToJson(SearchMealsResult instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };
