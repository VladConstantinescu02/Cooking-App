import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:msa_cooking_app_client/features/authentication/models/authenticate_user_result.dart';
import 'package:msa_cooking_app_client/features/authentication/models/get_auth_token_request.dart';
import 'package:msa_cooking_app_client/shared/api/authentication_api_client.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';

class AuthenticationService {
  final GoogleSignIn _googleSignIn;
  final AuthenticationApiClient _authenticationApiClient;

  AuthenticationService({required GoogleSignIn googleSignIn, required AuthenticationApiClient authenticationApiClient})
      : _googleSignIn = googleSignIn, _authenticationApiClient = authenticationApiClient;

  Future<Result<AuthenticateUserResult, Exception>> authenticateUser() async {
    try {
      var googleAccount = await _googleSignIn.signIn();
      if (googleAccount == null) return Failure(Exception("Unsuccessful login"));
      final googleAuth = await googleAccount.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken ?? "";
      if (idToken == null) {
        return Failure(Exception("Could not retrieve id token"));
      }
      final apiJwtTokenResult = await _authenticationApiClient.getAuthenticationToken(GetAuthTokenRequest(idToken, accessToken));
      if (apiJwtTokenResult is Success<String?, Exception>) {
        return Success(AuthenticateUserResult(apiJwtTokenResult.value, googleAccount));
      } else {
        return Failure(Exception("Problem when retrieving token"));
      }
    } on Exception catch (e) {
      log("Error authenticating user: $e");
      return Failure(Exception("Unexpected behavior"));
    }
  }

  Future<Result<void, Exception>> logoutUser() async {
    try {
      await _googleSignIn.signOut();
      return const Success(null);
    } on Exception catch (e) {
      log("Error logging out user: $e");
      return Failure(Exception("Unexpected behavior"));
    }
  }
}