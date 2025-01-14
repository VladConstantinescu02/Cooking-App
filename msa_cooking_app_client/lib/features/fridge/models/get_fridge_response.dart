import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/fridge/models/get_fridge.dart';

import '../../../shared/models/warning.dart';

part "get_fridge_response.g.dart";

@JsonSerializable()
class GetFridgeResponse {
  final String message;
  final GetFridge fridge;
  final List<Warning> warnings;

  GetFridgeResponse(this.message, this.fridge, this.warnings);

  factory GetFridgeResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFridgeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetFridgeResponseToJson(this);
}