import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_dietary_option.dart';

part "get_all_dietary_options_response.g.dart";

@JsonSerializable()
class GetAllDietaryOptionsResponse {
  final String message;
  final List<GetDietaryOption> dietaryOptions;

  GetAllDietaryOptionsResponse(this.message, this.dietaryOptions);

  factory GetAllDietaryOptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllDietaryOptionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllDietaryOptionsResponseToJson(this);
}