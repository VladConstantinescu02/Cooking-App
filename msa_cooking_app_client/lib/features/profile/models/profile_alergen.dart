import 'package:json_annotation/json_annotation.dart';

part 'profile_alergen.g.dart';

@JsonSerializable()
class ProfileAlergen {
  final String id;
  final String name;

  ProfileAlergen(this.id, this.name);

  factory ProfileAlergen.fromJson(Map<String, dynamic> json) =>
      _$ProfileAlergenFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileAlergenToJson(this);
}