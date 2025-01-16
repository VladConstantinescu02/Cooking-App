
import 'package:json_annotation/json_annotation.dart';

part 'get_meal_cuisine.g.dart';

@JsonSerializable()
class GetMealCuisine {
  final int id;
  final String cuisine;

  GetMealCuisine(this.id, this.cuisine);

  factory GetMealCuisine.fromJson(Map<String, dynamic> json) =>
      _$GetMealCuisineFromJson(json);

  Map<String, dynamic> toJson() => _$GetMealCuisineToJson(this);
}