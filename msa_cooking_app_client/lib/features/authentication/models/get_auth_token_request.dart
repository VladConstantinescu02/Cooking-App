import 'package:json_annotation/json_annotation.dart';

part 'get_auth_token_request.g.dart';

@JsonSerializable()
class GetAuthTokenRequest {
  final String idToken;
  final String accessToken;

  GetAuthTokenRequest(this.idToken, this.accessToken);

  Map<String, dynamic> toJson() => _$GetAuthTokenRequestToJson(this);
}