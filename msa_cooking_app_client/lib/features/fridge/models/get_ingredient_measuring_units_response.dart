import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/fridge/models/get_ingredient_measuring_unit.dart';

part 'get_ingredient_measuring_units_response.g.dart';

@JsonSerializable()
class GetIngredientMeasuringUnitsResponse {
  final String message;
  final List<GetIngredientMeasuringUnit> ingredientMeasuringUnits;

  GetIngredientMeasuringUnitsResponse(this.message, this.ingredientMeasuringUnits);

  factory GetIngredientMeasuringUnitsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetIngredientMeasuringUnitsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetIngredientMeasuringUnitsResponseToJson(this);
}