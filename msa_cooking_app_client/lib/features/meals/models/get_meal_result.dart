import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_meal.dart';

part 'get_meal_result.g.dart';

@JsonSerializable()
class GetMealResult {
  final String message;
  final GetMeal meal;

  GetMealResult(this.message, this.meal);

  factory GetMealResult.fromJson(Map<String, dynamic> json) =>
      _$GetMealResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetMealResultToJson(this);
}