
import 'package:json_annotation/json_annotation.dart';

part "get_fridge_ingredient.g.dart";

@JsonSerializable()
class GetFridgeIngredient {
  final String ingredientId;
  final String name;
  final double caloriesPer100Grams;
  final double quantity;
  final String ingredientMeasuringUnitSuffix;

  GetFridgeIngredient(this.ingredientId, this.name, this.caloriesPer100Grams, this.quantity, this.ingredientMeasuringUnitSuffix);
  factory GetFridgeIngredient.fromJson(Map<String, dynamic> json) =>
      _$GetFridgeIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$GetFridgeIngredientToJson(this);
}