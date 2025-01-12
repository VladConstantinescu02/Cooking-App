import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/profile/models/profile.dart';

part "get_profile_response.g.dart";

@JsonSerializable()
class GetProfileResponse {
  final String message;
  final Profile profile;

  GetProfileResponse(this.message, this.profile);

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProfileResponseToJson(this);
}