
import 'package:json_annotation/json_annotation.dart';

part 'spoonacular_search_meal_ingredient_result.g.dart';

@JsonSerializable()
class SpoonacularSearchMealIngredientResult {
  final String id;
  final double amount;
  final String? unit;
  final String? unitShort;
  final String name;
  final String? image;

  SpoonacularSearchMealIngredientResult(this.id, this.amount, this.unit, this.unitShort, this.name, this.image);

  factory SpoonacularSearchMealIngredientResult.fromJson(Map<String, dynamic> json) =>
      _$SpoonacularSearchMealIngredientResultFromJson(json);

  Map<String, dynamic> toJson() => _$SpoonacularSearchMealIngredientResultToJson(this);
}