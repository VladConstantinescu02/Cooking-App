// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoonacular_get_meal_instructions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpoonacularGetMealInstructions _$SpoonacularGetMealInstructionsFromJson(
        Map<String, dynamic> json) =>
    SpoonacularGetMealInstructions(
      (json['steps'] as List<dynamic>)
          .map((e) => SpoonacularGetMealInstructionStep.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpoonacularGetMealInstructionsToJson(
        SpoonacularGetMealInstructions instance) =>
    <String, dynamic>{
      'steps': instance.steps,
    };
