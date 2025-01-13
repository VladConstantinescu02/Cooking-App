import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:msa_cooking_app_client/features/profile/models/create_profile.dart';
import 'package:msa_cooking_app_client/features/profile/models/create_profile_response.dart';
import 'package:msa_cooking_app_client/features/profile/models/get_profile_response.dart';
import 'package:msa_cooking_app_client/features/profile/models/profile.dart';
import 'package:msa_cooking_app_client/shared/models/get_search_ingredients_response.dart';
import 'package:msa_cooking_app_client/shared/models/search_ingredient.dart';

import '../errors/result.dart';

class IngredientsApiClient {
  final String _baseAddress;
  final http.Client client;
  final String token;

  IngredientsApiClient(this._baseAddress, this.client, this.token);

  Future<Result<List<SearchIngredient>, Exception>> searchIngredients(String query) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.get(Uri.http(_baseAddress, "api/ingredients/search", { 'query': query }), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final responseResults = GetSearchIngredientsResponse.fromJson(json);
        return Success(responseResults.results);
      } else {
        return Failure(Exception("No search ingredient results"));
      }
    } on Exception catch (e) {
      log("Error when searching ingredients $e");
      return Failure(Exception("Error on search ingredients"));
    }
  }

  Future<Result<CreateProfileResponse, Exception>> createProfile(CreateProfile createProfile) async {
    try {
      final request = http.MultipartRequest('POST', Uri.http(_baseAddress, "api/profile"));
      if (createProfile.profilePhoto != null) {
        request.files.add(
            await http.MultipartFile.fromPath('image', createProfile.profilePhoto!.path)
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
}