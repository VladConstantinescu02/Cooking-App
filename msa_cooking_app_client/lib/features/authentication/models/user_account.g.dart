// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => UserAccount(
      displayName: json['displayName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      id: json['id'] as String? ?? '',
      serverAuthCode: json['serverAuthCode'] as String? ?? '',
      isAuthenticated: json['isAuthenticated'] as bool? ?? false,
      token: json['token'] as String? ?? '',
    );

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'id': instance.id,
      'token': instance.token,
      'serverAuthCode': instance.serverAuthCode,
      'isAuthenticated': instance.isAuthenticated,
    };
