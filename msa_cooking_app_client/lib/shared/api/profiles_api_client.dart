import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:msa_cooking_app_client/features/profile/models/create_profile.dart';
import 'package:msa_cooking_app_client/features/profile/models/create_profile_response.dart';
import 'package:msa_cooking_app_client/features/profile/models/delete_profile_response.dart';
import 'package:msa_cooking_app_client/features/profile/models/get_profile_response.dart';
import 'package:msa_cooking_app_client/features/profile/models/profile.dart';

import '../errors/result.dart';

class ProfilesApiClient {
  final String _baseAddress;
  final http.Client client;
  final String token;

  ProfilesApiClient(this._baseAddress, this.client, this.token);

  Future<Result<Profile, Exception>> getProfile() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.get(Uri.http(_baseAddress, "api/profile"), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final responseProfile = GetProfileResponse.fromJson(json);
        return Success(responseProfile.profile);
      } else {
        return Failure(Exception("No profile"));
      }
    } on Exception catch (e) {
      log("Error when retrieving profile $e");
      return Failure(Exception("Error on retrieving profile"));
    }
  }

  Future<Result<CreateProfileResponse, Exception>> createProfile(CreateProfile createProfile) async {
    try {
      final request = http.MultipartRequest('POST', Uri.http(_baseAddress, "api/profile"));
      if (createProfile.profilePhoto != null) {
        request.files.add(
          await http.MultipartFile.fromPath('profilePhoto', createProfile.profilePhoto!.path)
        );
      }
      if (createProfile.dietaryOptionId != null) {
        request.fields['dietaryOptionId'] = createProfile.dietaryOptionId.toString();
      }
      if (createProfile.ingredientAllergies != null) {
        createProfile.ingredientAllergies?.forEach((a) {
          request.fields['ingredientAllergies'] = a;
        });
      }
      request.fields['userName'] = createProfile.userName;
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      });
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final responseResult = CreateProfileResponse.fromJson(json);
        return Success(responseResult);
      } else {
        return Failure(Exception("No response"));
      }
    } on Exception catch (e) {
      log("Error when creating profile $e");
      return Failure(Exception("Error when creating profile"));
    }
  }

  Future<Result<CreateProfileResponse, Exception>> updateProfile(CreateProfile createProfile) async {
    try {
      final request = http.MultipartRequest('PUT', Uri.http(_baseAddress, "api/profile"));
      if (createProfile.profilePhoto != null) {
        request.files.add(
            await http.MultipartFile.fromPath('profilePhoto', createProfile.profilePhoto!.path)
        );
      }
      if (createProfile.dietaryOptionId != null) {
        request.fields['dietaryOptionId'] = createProfile.dietaryOptionId.toString();
      }
      if (createProfile.ingredientAllergies != null) {
        createProfile.ingredientAllergies?.forEach((a) {
          request.fields['ingredientAllergies'] = a;
        });
      }
      request.fields['userName'] = createProfile.userName;
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      });
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final responseResult = CreateProfileResponse.fromJson(json);
        return Success(responseResult);
      } else {
        final json = jsonDecode(response.body);
        return Failure(Exception(json["title"]));
      }
    } on Exception catch (e) {
      log("Error when updating profile $e");
      return Failure(Exception("Error when updating profile"));
    }
  }

  Future<Result<DeleteProfileResponse, Exception>> deleteProfile() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.delete(Uri.http(_baseAddress, "api/profile"), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final responseProfile = DeleteProfileResponse.fromJson(json);
        return Success(responseProfile);
      } else {
        return Failure(Exception("No profile!"));
      }
    } on Exception catch (e) {
      log("Error when deleting profile $e");
      return Failure(Exception("Error on deleting profile"));
    }
  }
}