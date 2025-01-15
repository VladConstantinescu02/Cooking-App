
import 'package:json_annotation/json_annotation.dart';

part 'get_all_meals_meal.g.dart';

@JsonSerializable()
class GetAllMealsMeal {
  final String id;
  final String name;
  final String summary;
  final double readyInMinutes;
  final String image;
  final String? lastPreparedAt;
  final bool wasPrepared;
  final String profileId;
  final String? ingredientsJson;

  GetAllMealsMeal(this.id, this.name, this.summary, this.readyInMinutes, this.image, this.lastPreparedAt, this.wasPrepared, this.profileId, this.ingredientsJson);

  factory GetAllMealsMeal.fromJson(Map<String, dynamic> json) =>
      _$GetAllMealsMealFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllMealsMealToJson(this);
}