import 'package:json_annotation/json_annotation.dart';
import 'package:msa_cooking_app_client/features/profile/models/profile_alergen.dart';
import 'package:msa_cooking_app_client/features/profile/models/profile_diet_restriction.dart';

part "profile.g.dart";

@JsonSerializable()
class Profile {
  final String? id;
  final String? userName;
  final String? fullName;
  final String? profilePhotoUrl;
  final String? userId;
  final List<ProfileAlergen>? alergens;
  final ProfileDietRestriction? dietRestriction;

  Profile(this.id, this.userName, this.fullName, this.profilePhotoUrl, this.userId, this.alergens, this.dietRestriction);

  static Profile defaultProfile() {
    return Profile(
        null,
        null,
        null,
        null,
        null,
        List.empty(),
        ProfileDietRestriction.defaultProfileDietRestriction()
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
