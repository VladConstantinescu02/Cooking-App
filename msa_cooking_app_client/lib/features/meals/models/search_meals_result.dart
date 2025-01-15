import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/meals/models/spoonacular_search_meal_result.dart';

part 'search_meals_result.g.dart';

@JsonSerializable()
class SearchMealsResult {
  final String message;
  final SpoonacularSearchMealResult? result;

  SearchMealsResult(this.message, this.result);

  factory SearchMealsResult.fromJson(Map<String, dynamic> json) =>
      _$SearchMealsResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMealsResultToJson(this);
}