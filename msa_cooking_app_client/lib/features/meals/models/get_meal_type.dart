
import 'package:json_annotation/json_annotation.dart';

part 'get_meal_type.g.dart';

@JsonSerializable()
class GetMealType {
  final int id;
  final String type;

  GetMealType(this.id, this.type);

  factory GetMealType.fromJson(Map<String, dynamic> json) =>
      _$GetMealTypeFromJson(json);

  Map<String, dynamic> toJson() => _$GetMealTypeToJson(this);
}