// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_auth_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAuthTokenRequest _$GetAuthTokenRequestFromJson(Map<String, dynamic> json) =>
    GetAuthTokenRequest(
      json['idToken'] as String,
      json['accessToken'] as String,
    );

Map<String, dynamic> _$GetAuthTokenRequestToJson(
        GetAuthTokenRequest instance) =>
    <String, dynamic>{
      'idToken': instance.idToken,
      'accessToken': instance.accessToken,
    };
