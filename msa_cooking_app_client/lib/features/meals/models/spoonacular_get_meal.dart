import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/meals/models/spoonacular_get_meal_ingredient.dart';
import 'package:msa_cooking_app_client/features/meals/models/spoonacular_get_meal_instructions.dart';

part 'spoonacular_get_meal.g.dart';

@JsonSerializable()
class SpoonacularGetMeal {
  final String id;
  final String title;
  final double readyInMinutes;
  final String? image;
  final String? summary;
  final List<String>? cuisines;
  final List<String>? dishTypes;
  final List<String>? diets;
  final List<SpoonacularGetMealInstructions> analyzedInstructions;
  final List<SpoonacularGetMealIngredient> extendedIngredients;

  SpoonacularGetMeal(this.id, this.title, this.readyInMinutes, this.image, this.summary, this.cuisines, this.dishTypes, this.diets, this.analyzedInstructions, this.extendedIngredients);

  factory SpoonacularGetMeal.fromJson(Map<String, dynamic> json) =>
      _$SpoonacularGetMealFromJson(json);

  Map<String, dynamic> toJson() => _$SpoonacularGetMealToJson(this);
}