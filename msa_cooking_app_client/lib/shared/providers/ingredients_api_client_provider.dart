import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../../features/authentication/models/user_account.dart';
import '../../features/authentication/providers/authentication_provider.dart';
import '../api/ingredients_api_client.dart';

final ingredientsApiClientProvider = Provider<IngredientsApiClient>((ref) {
  const String baseAddress = AppConfig.apiBaseAddress;
  final client = http.Client();
  final AsyncValue<UserAccount> account = ref.watch(authenticationProvider);
  return IngredientsApiClient(baseAddress, client, account.value!.token);
});