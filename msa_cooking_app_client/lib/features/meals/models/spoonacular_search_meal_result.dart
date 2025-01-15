import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/meals/models/spoonacular_search_meal_result_meal.dart';

part 'spoonacular_search_meal_result.g.dart';

@JsonSerializable()
class SpoonacularSearchMealResult {
  final List<SpoonacularSearchMealResultMeal> results;

  SpoonacularSearchMealResult(this.results);

  factory SpoonacularSearchMealResult.fromJson(Map<String, dynamic> json) =>
      _$SpoonacularSearchMealResultFromJson(json);

  Map<String, dynamic> toJson() => _$SpoonacularSearchMealResultToJson(this);
}