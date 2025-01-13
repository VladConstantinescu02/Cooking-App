import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:msa_cooking_app_client/shared/api/authentication_api_client.dart';

import '../../config/config.dart';

final authenticationApiClientProvider = Provider<AuthenticationApiClient>((ref) {
  const String baseAddress = AppConfig.apiBaseAddress;
  final client = http.Client();
  return AuthenticationApiClient(baseAddress, client);
});
