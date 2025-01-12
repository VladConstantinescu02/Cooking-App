import 'package:json_annotation/json_annotation.dart';

part "delete_profile_response.g.dart";

@JsonSerializable()
class DeleteProfileResponse {
  final String message;

  DeleteProfileResponse(this.message);

  factory DeleteProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteProfileResponseToJson(this);
}