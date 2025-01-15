import 'package:json_annotation/json_annotation.dart';

part "create_profile_response.g.dart";

@JsonSerializable()
class CreateProfileResponse {
  final String message;

  CreateProfileResponse(this.message);

  factory CreateProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProfileResponseToJson(this);
}