import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:msa_cooking_app_client/features/meals/models/delete_meal_result.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_all_dietary_options_response.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_all_meal_cuisines_result.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_all_meal_types_result.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_all_meals_result.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_meal_result.dart';
import 'package:msa_cooking_app_client/features/meals/models/save_meal_result.dart';
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

  Future<Result<SaveMealResult, Exception>> saveMeal(String mealId) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.post(Uri.http(_baseAddress, "api/meals", {'spoonacularMealId': mealId}), headers: headers);
      if (response.statusCode == 200) {
        return Success(SaveMealResult.fromJson(jsonDecode(response.body)));
      } else {
        return Failure(Exception("No meal"));
      }
    } on Exception catch (e) {
      log("Error when saving meal $e");
      return Failure(Exception("Error when saving meal"));
    }
  }

  Future<Result<DeleteMealResult, Exception>> deleteMeal(String mealId) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.delete(Uri.http(_baseAddress, "api/meals", {'mealId': mealId}), headers: headers);
      if (response.statusCode == 200) {
        return Success(DeleteMealResult.fromJson(jsonDecode(response.body)));
      } else {
        return Failure(Exception("No meal"));
      }
    } on Exception catch (e) {
      log("Error when deleting meal $e");
      return Failure(Exception("Error when deleting meal"));
    }
  }

  Future<Result<GetAllMealCuisinesResult, Exception>> getAllMealCuisines() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.get(Uri.http(_baseAddress, "api/meals/meal-cuisines"), headers: headers);
      if (response.statusCode == 200) {
        return Success(GetAllMealCuisinesResult.fromJson(jsonDecode(response.body)));
      } else {
        return Failure(Exception("No meal cuisines"));
      }
    } on Exception catch (e) {
      log("Error when retrieving meal cuisines $e");
      return Failure(Exception("Error when retrieving meal cuisines"));
    }
  }

  Future<Result<GetAllMealTypesResult, Exception>> getAllMealTypes() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.get(Uri.http(_baseAddress, "api/meals/meal-types"), headers: headers);
      if (response.statusCode == 200) {
        return Success(GetAllMealTypesResult.fromJson(jsonDecode(response.body)));
      } else {
        return Failure(Exception("No meal types"));
      }
    } on Exception catch (e) {
      log("Error when retrieving meal types $e");
      return Failure(Exception("Error when retrieving meal types"));
    }
  }
}