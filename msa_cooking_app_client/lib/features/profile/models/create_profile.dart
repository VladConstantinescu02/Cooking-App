import 'dart:io';

class CreateProfile {
  final String userName;
  final List<String>? ingredientAllergies;
  final int? dietaryOptionId;
  final File? profilePhoto;

  CreateProfile(this.userName, this.ingredientAllergies, this.dietaryOptionId, this.profilePhoto);
}