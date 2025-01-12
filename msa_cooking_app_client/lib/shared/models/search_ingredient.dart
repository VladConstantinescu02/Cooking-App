
import 'package:json_annotation/json_annotation.dart';

part "search_ingredient.g.dart";

@JsonSerializable()
class SearchIngredient {
  final String id;
  final String name;

  SearchIngredient(this.id, this.name);

  factory SearchIngredient.fromJson(Map<String, dynamic> json) =>
      _$SearchIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$SearchIngredientToJson(this);

  SearchIngredient copy() {
    return SearchIngredient(this.id, this.name);
  }
}