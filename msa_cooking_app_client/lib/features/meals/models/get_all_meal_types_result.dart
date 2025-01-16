import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_meal_type.dart';

part 'get_all_meal_types_result.g.dart';

@JsonSerializable()
class GetAllMealTypesResult {
  final String message;
  final List<GetMealType> mealTypes;

  GetAllMealTypesResult(this.message, this.mealTypes);

  factory GetAllMealTypesResult.fromJson(Map<String, dynamic> json) =>
      _$GetAllMealTypesResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllMealTypesResultToJson(this);
}