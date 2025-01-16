
import 'package:json_annotation/json_annotation.dart';

part 'save_meal_result.g.dart';

@JsonSerializable()
class SaveMealResult {
  final String message;

  SaveMealResult(this.message);

  factory SaveMealResult.fromJson(Map<String, dynamic> json) =>
      _$SaveMealResultFromJson(json);

  Map<String, dynamic> toJson() => _$SaveMealResultToJson(this);
}