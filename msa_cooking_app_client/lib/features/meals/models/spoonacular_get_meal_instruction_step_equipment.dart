
import 'package:json_annotation/json_annotation.dart';

part 'spoonacular_get_meal_instruction_step_equipment.g.dart';

@JsonSerializable()
class SpoonacularGetMealInstructionStepEquipment {
  final String id;
  final String name;
  final String? image;

  SpoonacularGetMealInstructionStepEquipment(this.id, this.name, this.image);

  factory SpoonacularGetMealInstructionStepEquipment.fromJson(Map<String, dynamic> json) =>
      _$SpoonacularGetMealInstructionStepEquipmentFromJson(json);

  Map<String, dynamic> toJson() => _$SpoonacularGetMealInstructionStepEquipmentToJson(this);
}