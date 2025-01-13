import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:msa_cooking_app_client/features/meals/models/get_all_dietary_options_response.dart';

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
}