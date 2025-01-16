import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/meals/models/spoonacular_get_meal.dart';

part 'get_meal.g.dart';

@JsonSerializable()
class GetMeal {
  final SpoonacularGetMeal? meal;
  final String? lastPreparedAt;
  final bool wasPrepared;

  GetMeal(this.meal, this.lastPreparedAt, this.wasPrepared);

  factory GetMeal.fromJson(Map<String, dynamic> json) =>
      _$GetMealFromJson(json);

  Map<String, dynamic> toJson() => _$GetMealToJson(this);
}