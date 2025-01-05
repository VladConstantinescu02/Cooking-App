import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:msa_cooking_app_client/features/authentication/models/get_auth_token_request.dart';

import '../errors/result.dart';

class AuthenticationApiClient {
  final String _baseAddress;
  final http.Client client;
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  AuthenticationApiClient(this._baseAddress, this.client);

  Future<Result<String?, Exception>> getAuthenticationToken(GetAuthTokenRequest getAuthTokenRequest) async {
    try {
      final requestBody = jsonEncode(getAuthTokenRequest.toJson());
      final response = await client.post(Uri.http(_baseAddress, "/api/authenticate/google"), headers: headers, body: requestBody);
      if (response.statusCode == 200) {
        return Success(jsonDecode(response.body));
      } else {
        return Failure(Exception("Invalid token"));
      }
    } on Exception catch (e) {
      log("Error when retrieving authentication token $e");
      return Failure(Exception("Error on authentication"));
    }
  }
}