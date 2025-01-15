import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/meals/models/spoonacular_search_meal_ingredient_result.dart';

part 'spoonacular_search_meal_result_meal.g.dart';

@JsonSerializable()
class SpoonacularSearchMealResultMeal {
  final String id;
  final int usedIngredientCount;
  final int missedIngredientCount;
  final String title;
  final String? image;
  final List<SpoonacularSearchMealIngredientResult>? missedIngredients;
  final List<SpoonacularSearchMealIngredientResult>? usedIngredients;

  SpoonacularSearchMealResultMeal(this.id, this.usedIngredientCount, this.missedIngredientCount, this.title, this.image, this.missedIngredients, this.usedIngredients);

  factory SpoonacularSearchMealResultMeal.fromJson(Map<String, dynamic> json) =>
      _$SpoonacularSearchMealResultMealFromJson(json);

  Map<String, dynamic> toJson() => _$SpoonacularSearchMealResultMealToJson(this);
}