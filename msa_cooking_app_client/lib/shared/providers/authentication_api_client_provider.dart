import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:msa_cooking_app_client/shared/api/authentication_api_client.dart';

import '../../config/config.dart';

final authenticationApiClientProvider = Provider<AuthenticationApiClient>((ref) {
  const String baseAddress = AppConfig.apiBaseAddress;
  final ioc = HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final client = IOClient(ioc);
  return AuthenticationApiClient(baseAddress, client);
});