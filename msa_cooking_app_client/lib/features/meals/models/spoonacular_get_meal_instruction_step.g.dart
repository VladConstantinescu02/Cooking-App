// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoonacular_get_meal_instruction_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpoonacularGetMealInstructionStep _$SpoonacularGetMealInstructionStepFromJson(
        Map<String, dynamic> json) =>
    SpoonacularGetMealInstructionStep(
      (json['number'] as num).toInt(),
      json['step'] as String,
      (json['ingredients'] as List<dynamic>)
          .map((e) => SpoonacularGetMealInstructionStepIngredient.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      (json['equipment'] as List<dynamic>)
          .map((e) => SpoonacularGetMealInstructionStepEquipment.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpoonacularGetMealInstructionStepToJson(
        SpoonacularGetMealInstructionStep instance) =>
    <String, dynamic>{
      'number': instance.number,
      'step': instance.step,
      'ingredients': instance.ingredients,
      'equipment': instance.equipment,
    };
