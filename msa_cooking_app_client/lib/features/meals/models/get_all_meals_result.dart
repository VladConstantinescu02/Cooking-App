import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_all_meals_meal.dart';

part 'get_all_meals_result.g.dart';

@JsonSerializable()
class GetAllMealsResult {
  final String message;
  final List<GetAllMealsMeal> meals;

  GetAllMealsResult(this.message, this.meals);

  factory GetAllMealsResult.fromJson(Map<String, dynamic> json) =>
      _$GetAllMealsResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllMealsResultToJson(this);
}