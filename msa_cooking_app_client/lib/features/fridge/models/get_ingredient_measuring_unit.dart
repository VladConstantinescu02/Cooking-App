
import 'package:json_annotation/json_annotation.dart';

part 'get_ingredient_measuring_unit.g.dart';

@JsonSerializable()
class GetIngredientMeasuringUnit {
  final int id;
  final String unitName;
  final String unitSuffix;

  GetIngredientMeasuringUnit(this.id, this.unitName, this.unitSuffix);

  factory GetIngredientMeasuringUnit.fromJson(Map<String, dynamic> json) =>
      _$GetIngredientMeasuringUnitFromJson(json);

  Map<String, dynamic> toJson() => _$GetIngredientMeasuringUnitToJson(this);
}