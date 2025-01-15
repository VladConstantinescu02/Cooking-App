import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:msa_cooking_app_client/features/meals/models/get_all_dietary_options_response.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_all_meals_result.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_meal_result.dart';
import 'package:msa_cooking_app_client/features/meals/models/search_meals.dart';
import 'package:msa_cooking_app_client/features/meals/models/search_meals_result.dart';

import '../errors/result.dart';

class MealsApiClient {
  final String _baseAddress;
  final http.Client client;
  final String token;

  MealsApiClient(this._baseAddress, this.client, this.token);

  Future<Result<GetAllDietaryOptionsResponse, Exception>> getAllDietaryOptions() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.get(Uri.http(_baseAddress, "api/meals/dietary-options"), headers: headers);
      if (response.statusCode == 200) {
        return Success(GetAllDietaryOptionsResponse.fromJson(jsonDecode(response.body)));
      } else {
        return Failure(Exception("No dietary options"));
      }
    } on Exception catch (e) {
      log("Error when retrieving dietary options $e");
      return Failure(Exception("Error when retrieving dietary options"));
    }
  }

  Future<Result<SearchMealsResult, Exception>> searchMeals(SearchMeals searchMeals) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.post(Uri.http(_baseAddress, "search-meal"), headers: headers, body: jsonEncode(searchMeals));
      if (response.statusCode == 200) {
        return Success(SearchMealsResult.fromJson(jsonDecode(response.body)));
      } else {
        return Failure(Exception("No search meals"));
      }
    } on Exception catch (e) {
      log("Error when searching meals $e");
      return Failure(Exception("Error when searching meals"));
    }
  }

  Future<Result<GetAllMealsResult, Exception>> getAllMeals() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.get(Uri.http(_baseAddress, "api/meals/all"), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Success(GetAllMealsResult.fromJson(json));
      } else {
        return Failure(Exception("No meals"));
      }
    } on Exception catch (e) {
      log("Error when retrieving all meals $e");
      return Failure(Exception("Error when retrieving all meals"));
    }
  }

  Future<Result<GetMealResult, Exception>> getMeal(String mealId) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.get(Uri.http(_baseAddress, "api/meals", {'mealId': mealId}), headers: headers);
      if (response.statusCode == 200) {
        return Success(GetMealResult.fromJson(jsonDecode(response.body)));
      } else {
        return Failure(Exception("No meal"));
      }
    } on Exception catch (e) {
      log("Error when retrieving meal $e");
      return Failure(Exception("Error when retrieving meal"));
    }
  }
}