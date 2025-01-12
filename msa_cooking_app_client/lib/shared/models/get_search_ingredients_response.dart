import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/shared/models/search_ingredient.dart';

part "get_search_ingredients_response.g.dart";

@JsonSerializable()
class GetSearchIngredientsResponse {
  final List<SearchIngredient> results;

  GetSearchIngredientsResponse(this.results);

  factory GetSearchIngredientsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSearchIngredientsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetSearchIngredientsResponseToJson(this);
}