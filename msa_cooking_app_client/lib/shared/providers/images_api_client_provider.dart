import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:msa_cooking_app_client/shared/api/images_api_client.dart';

import '../../config/config.dart';
import '../../features/authentication/models/user_account.dart';
import '../../features/authentication/providers/authentication_provider.dart';

final imagesApiClientProvider = Provider<ImagesApiClient>((ref) {
  const String baseAddress = AppConfig.apiBaseAddress;
  final client = http.Client();
  final AsyncValue<UserAccount> account = ref.watch(authenticationProvider);
  return ImagesApiClient(baseAddress, client, account.value!.token);
});