import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/fridge/models/get_fridge_ingredient.dart';

part "get_fridge.g.dart";

@JsonSerializable()
class GetFridge {
  final String? fridgeName;
  final List<GetFridgeIngredient>? fridgeIngredients;
  final List<String>? fridgeAlergensIds;

  GetFridge(this.fridgeName, this.fridgeIngredients, this.fridgeAlergensIds);

  factory GetFridge.fromJson(Map<String, dynamic> json) =>
      _$GetFridgeFromJson(json);

  Map<String, dynamic> toJson() => _$GetFridgeToJson(this);

  static GetFridge defaultFridge() {
    return GetFridge(null, null, null);
  }
}