import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/meals/models/spoonacular_get_meal_instruction_step_equipment.dart';
import 'package:msa_cooking_app_client/features/meals/models/spoonacular_get_meal_instruction_step_ingredient.dart';

part 'spoonacular_get_meal_instruction_step.g.dart';

@JsonSerializable()
class SpoonacularGetMealInstructionStep {
  final int number;
  final String step;
  final List<SpoonacularGetMealInstructionStepIngredient> ingredients;
  final List<SpoonacularGetMealInstructionStepEquipment> equipment;

  SpoonacularGetMealInstructionStep(this.number, this.step, this.ingredients, this.equipment);

  factory SpoonacularGetMealInstructionStep.fromJson(Map<String, dynamic> json) =>
      _$SpoonacularGetMealInstructionStepFromJson(json);

  Map<String, dynamic> toJson() => _$SpoonacularGetMealInstructionStepToJson(this);
}