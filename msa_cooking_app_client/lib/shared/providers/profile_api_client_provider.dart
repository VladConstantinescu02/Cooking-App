import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:msa_cooking_app_client/shared/api/profiles_api_client.dart';

import '../../config/config.dart';
import '../../features/authentication/models/user_account.dart';
import '../../features/authentication/providers/authentication_provider.dart';

final profileApiClientProvider = Provider<ProfilesApiClient>((ref) {
  const String baseAddress = AppConfig.apiBaseAddress;
  final client = http.Client();
  final AsyncValue<UserAccount> account = ref.watch(authenticationProvider);
  return ProfilesApiClient(baseAddress, client, account.value!.token);
});