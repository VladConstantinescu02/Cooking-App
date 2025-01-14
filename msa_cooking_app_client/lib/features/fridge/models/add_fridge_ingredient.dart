
import 'package:json_annotation/json_annotation.dart';

part 'add_fridge_ingredient.g.dart';

@JsonSerializable()
class AddFridgeIngredient {
  final String ingredientId;
  final double ingredientQuantity;
  final int ingredientMeasuringUnitId;

  AddFridgeIngredient(this.ingredientId, this.ingredientQuantity, this.ingredientMeasuringUnitId);

  factory AddFridgeIngredient.fromJson(Map<String, dynamic> json) =>
      _$AddFridgeIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$AddFridgeIngredientToJson(this);
}