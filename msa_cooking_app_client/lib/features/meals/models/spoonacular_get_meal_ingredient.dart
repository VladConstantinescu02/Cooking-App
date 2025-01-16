import 'package:json_annotation/json_annotation.dart';

part 'spoonacular_get_meal_ingredient.g.dart';

@JsonSerializable()
class SpoonacularGetMealIngredient {
  final String id;
  final String name;
  final String? original;
  final double? amount;
  final String? unit;

  SpoonacularGetMealIngredient(this.id, this.name, this.original, this.amount, this.unit);

  factory SpoonacularGetMealIngredient.fromJson(Map<String, dynamic> json) =>
      _$SpoonacularGetMealIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$SpoonacularGetMealIngredientToJson(this);
}