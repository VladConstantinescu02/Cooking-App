
import 'package:json_annotation/json_annotation.dart';

part "get_dietary_option.g.dart";

@JsonSerializable()
class GetDietaryOption {
  final int id;
  final String name;

  GetDietaryOption(this.id, this.name);

  factory GetDietaryOption.fromJson(Map<String, dynamic> json) =>
      _$GetDietaryOptionFromJson(json);

  Map<String, dynamic> toJson() => _$GetDietaryOptionToJson(this);
}