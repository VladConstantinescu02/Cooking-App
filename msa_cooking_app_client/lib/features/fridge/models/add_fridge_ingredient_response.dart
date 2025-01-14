
import 'package:json_annotation/json_annotation.dart';

part 'add_fridge_ingredient_response.g.dart';

@JsonSerializable()
class AddFridgeIngredientResponse {
  final String message;

  AddFridgeIngredientResponse(this.message);

  factory AddFridgeIngredientResponse.fromJson(Map<String, dynamic> json) =>
      _$AddFridgeIngredientResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddFridgeIngredientResponseToJson(this);
}