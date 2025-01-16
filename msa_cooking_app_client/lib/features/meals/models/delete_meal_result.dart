
import 'package:json_annotation/json_annotation.dart';

part 'delete_meal_result.g.dart';

@JsonSerializable()
class DeleteMealResult {
  final String message;

  DeleteMealResult(this.message);

  factory DeleteMealResult.fromJson(Map<String, dynamic> json) =>
      _$DeleteMealResultFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteMealResultToJson(this);
}