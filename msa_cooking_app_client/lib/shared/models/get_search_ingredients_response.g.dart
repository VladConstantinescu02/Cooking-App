// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_search_ingredients_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSearchIngredientsResponse _$GetSearchIngredientsResponseFromJson(
        Map<String, dynamic> json) =>
    GetSearchIngredientsResponse(
      (json['results'] as List<dynamic>)
          .map((e) => SearchIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSearchIngredientsResponseToJson(
        GetSearchIngredientsResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
