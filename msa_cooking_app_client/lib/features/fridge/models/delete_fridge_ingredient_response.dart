
import 'package:json_annotation/json_annotation.dart';

part 'delete_fridge_ingredient_response.g.dart';

@JsonSerializable()
class DeleteFridgeIngredientResponse {
  final String message;

  DeleteFridgeIngredientResponse(this.message);

  factory DeleteFridgeIngredientResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteFridgeIngredientResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteFridgeIngredientResponseToJson(this);
}