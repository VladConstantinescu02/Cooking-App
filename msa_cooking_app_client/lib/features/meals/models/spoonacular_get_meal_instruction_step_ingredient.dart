
import 'package:json_annotation/json_annotation.dart';

part 'spoonacular_get_meal_instruction_step_ingredient.g.dart';

@JsonSerializable()
class SpoonacularGetMealInstructionStepIngredient {
  final String id;
  final String name;

  SpoonacularGetMealInstructionStepIngredient(this.id, this.name);

  factory SpoonacularGetMealInstructionStepIngredient.fromJson(Map<String, dynamic> json) =>
      _$SpoonacularGetMealInstructionStepIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$SpoonacularGetMealInstructionStepIngredientToJson(this);
}