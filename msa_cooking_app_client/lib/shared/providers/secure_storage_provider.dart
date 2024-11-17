import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:msa_cooking_app_client/shared/helpers/secure_storage.dart';

final secureStorageProvider = Provider<SecureStorage>((ref) {
  const flutterSecureStorage = FlutterSecureStorage();
  return SecureStorage(flutterSecureStorage: flutterSecureStorage);
});