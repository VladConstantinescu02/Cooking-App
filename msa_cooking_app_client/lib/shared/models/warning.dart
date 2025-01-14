
import 'package:json_annotation/json_annotation.dart';

part "warning.g.dart";

@JsonSerializable()
class Warning {
  final String message;

  Warning(this.message);

  factory Warning.fromJson(Map<String, dynamic> json) =>
      _$WarningFromJson(json);

  Map<String, dynamic> toJson() => _$WarningToJson(this);
}