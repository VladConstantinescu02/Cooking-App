
import 'package:json_annotation/json_annotation.dart';

part 'search_meals.g.dart';

@JsonSerializable()
class SearchMeals {
  final String query;
  final int? cuisineId;
  final bool useProfileDiet;
  final int? dietId;
  final bool useAllFridgeIngredients;
  final List<String>? ingredients;
  final int mealTypeId;
  final double? minCalories;
  final double? maxCalories;
  final bool includeProfileAlergens;
  final List<String>? excludedProfileAlergens;

  SearchMeals(this.query, this.cuisineId, this.useProfileDiet, this.dietId, this.useAllFridgeIngredients, this.ingredients, this.mealTypeId, this.minCalories, this.maxCalories, this.includeProfileAlergens, this.excludedProfileAlergens);

  factory SearchMeals.fromJson(Map<String, dynamic> json) =>
      _$SearchMealsFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMealsToJson(this);
}