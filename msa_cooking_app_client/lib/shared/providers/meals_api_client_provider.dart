import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../../features/authentication/models/user_account.dart';
import '../../features/authentication/providers/authentication_provider.dart';
import '../api/meals_api_client.dart';

final mealsApiClientProvider = Provider<MealsApiClient>((ref) {
  const String baseAddress = AppConfig.apiBaseAddress;
  final client = http.Client();
  final AsyncValue<UserAccount> account = ref.watch(authenticationProvider);
  return MealsApiClient(baseAddress, client, account.value!.token);
});