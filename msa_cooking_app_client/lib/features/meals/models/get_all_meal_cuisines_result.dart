import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_meal_cuisine.dart';

part 'get_all_meal_cuisines_result.g.dart';

@JsonSerializable()
class GetAllMealCuisinesResult {
  final String message;
  final List<GetMealCuisine> mealCuisines;

  GetAllMealCuisinesResult(this.message, this.mealCuisines);

  factory GetAllMealCuisinesResult.fromJson(Map<String, dynamic> json) =>
      _$GetAllMealCuisinesResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllMealCuisinesResultToJson(this);
}