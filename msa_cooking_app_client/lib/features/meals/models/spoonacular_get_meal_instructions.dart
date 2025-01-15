import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/meals/models/spoonacular_get_meal_instruction_step.dart';

part 'spoonacular_get_meal_instructions.g.dart';

@JsonSerializable()
class SpoonacularGetMealInstructions {
  final List<SpoonacularGetMealInstructionStep> steps;

  SpoonacularGetMealInstructions(this.steps);

  factory SpoonacularGetMealInstructions.fromJson(Map<String, dynamic> json) =>
      _$SpoonacularGetMealInstructionsFromJson(json);

  Map<String, dynamic> toJson() => _$SpoonacularGetMealInstructionsToJson(this);
}