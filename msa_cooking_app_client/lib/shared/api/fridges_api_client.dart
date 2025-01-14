import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:msa_cooking_app_client/features/fridge/models/add_fridge_ingredient.dart';
import 'package:msa_cooking_app_client/features/fridge/models/add_fridge_ingredient_response.dart';
import 'package:msa_cooking_app_client/features/fridge/models/delete_fridge_ingredient_response.dart';
import 'package:msa_cooking_app_client/features/fridge/models/get_fridge_response.dart';
import 'package:msa_cooking_app_client/features/fridge/models/get_ingredient_measuring_units_response.dart';

import '../errors/result.dart';

class FridgesApiClient {
  final String _baseAddress;
  final http.Client client;
  final String token;

  FridgesApiClient(this._baseAddress, this.client, this.token);

  Future<Result<GetFridgeResponse, Exception>> getFridge() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.get(Uri.http(_baseAddress, "api/fridge"), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final responseFridge = GetFridgeResponse.fromJson(json);
        return Success(responseFridge);
      } else {
        return Failure(Exception("No fridge"));
      }
    } on Exception catch (e) {
      log("Error when retrieving fridge $e");
      return Failure(Exception("Error on retrieving fridge"));
    }
  }

  Future<Result<DeleteFridgeIngredientResponse, Exception>> deleteFridgeIngredient(String fridgeIngredientId) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.delete(Uri.http(_baseAddress, "api/fridge/ingredient", { 'fridgeIngredientId': fridgeIngredientId }), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final responseFridge = DeleteFridgeIngredientResponse.fromJson(json);
        return Success(responseFridge);
      } else {
        return Failure(Exception("No fridge ingredient"));
      }
    } on Exception catch (e) {
      log("Error when deleting fridge ingredient $e");
      return Failure(Exception("Error on retrieving fridge ingredient"));
    }
  }

  Future<Result<AddFridgeIngredientResponse, Exception>> addFridgeIngredient(AddFridgeIngredient addFridgeIngredient) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.post(Uri.http(_baseAddress, "api/fridge/ingredient"), headers: headers, body: jsonEncode(addFridgeIngredient));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final responseFridgeIngredient = AddFridgeIngredientResponse.fromJson(json);
        return Success(responseFridgeIngredient);
      } else {
        return Failure(Exception("No fridge ingredient"));
      }
    } on Exception catch (e) {
      log("Error when adding fridge ingredient $e");
      return Failure(Exception("Error when adding fridge ingredient"));
    }
  }

  Future<Result<AddFridgeIngredientResponse, Exception>> updateFridgeIngredient(AddFridgeIngredient addFridgeIngredient) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.put(Uri.http(_baseAddress, "api/fridge/ingredient"), headers: headers, body: jsonEncode(addFridgeIngredient));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final responseFridgeIngredient = AddFridgeIngredientResponse.fromJson(json);
        return Success(responseFridgeIngredient);
      } else {
        return Failure(Exception("No fridge ingredient"));
      }
    } on Exception catch (e) {
      log("Error when adding updating ingredient $e");
      return Failure(Exception("Error when updating fridge ingredient"));
    }
  }

  Future<Result<GetIngredientMeasuringUnitsResponse, Exception>> getIngredientMeasuringUnits() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.get(Uri.http(_baseAddress, "api/fridge/ingredients/measuring-units"), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final responseIngredientMeasuringUnit = GetIngredientMeasuringUnitsResponse.fromJson(json);
        return Success(responseIngredientMeasuringUnit);
      } else {
        return Failure(Exception("No ingredient measuring unit"));
      }
    } on Exception catch (e) {
      log("Error when retrieving ingredient measuring units $e");
      return Failure(Exception("Error on retrieving ingredient measuring units"));
    }
  }
}