
import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/profile/models/profile.dart';

part "profile_diet_restriction.g.dart";

@JsonSerializable()
class ProfileDietRestriction {
  final int id;
  final String name;

  static ProfileDietRestriction defaultProfileDietRestriction() {
    return ProfileDietRestriction(0, '');
  }

  ProfileDietRestriction(this.id, this.name);

  factory ProfileDietRestriction.fromJson(Map<String, dynamic> json) =>
      _$ProfileDietRestrictionFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDietRestrictionToJson(this);
}