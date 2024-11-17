import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/authentication/providers/google_signin_provider.dart';
import 'package:msa_cooking_app_client/features/authentication/services/authentication_service.dart';
import 'package:msa_cooking_app_client/shared/providers/authentication_api_client_provider.dart';

final authenticationServiceProvider = Provider<AuthenticationService>((ref) {
  final googleSignIn = ref.watch(googleSignInProvider);
  final authenticationApiClient = ref.watch(authenticationApiClientProvider);
  return AuthenticationService(googleSignIn: googleSignIn, authenticationApiClient: authenticationApiClient);
});