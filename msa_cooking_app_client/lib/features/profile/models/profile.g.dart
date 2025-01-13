// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      json['id'] as String?,
      json['userName'] as String?,
      json['fullName'] as String?,
      json['profilePhotoUrl'] as String?,
      json['userId'] as String?,
      (json['alergens'] as List<dynamic>?)
          ?.map((e) => ProfileAlergen.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['dietRestriction'] == null
          ? null
          : ProfileDietRestriction.fromJson(
              json['dietRestriction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'userId': instance.userId,
      'alergens': instance.alergens,
      'dietRestriction': instance.dietRestriction,
    };
