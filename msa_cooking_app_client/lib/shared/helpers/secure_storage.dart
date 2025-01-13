import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:msa_cooking_app_client/features/authentication/models/user_account.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';

class SecureStorage {
  final FlutterSecureStorage _flutterSecureStorage;
  final String _accessUserAccountStateKey = "accessUserAccountState";

  SecureStorage({required FlutterSecureStorage flutterSecureStorage}) : _flutterSecureStorage = flutterSecureStorage;

  Future<Result<void, Exception>> setUserAccountState(UserAccount userAccountState) async {
    try {
      await _flutterSecureStorage.write(key: _accessUserAccountStateKey, value: jsonEncode(userAccountState.toJson()));
      return const Success(null);
    } on Exception catch(e) {
      log("Error saving account state: $e");
      return Failure(Exception("Unable to set user account"));
    }
  }

  Future<Result<UserAccount?, Exception>> getUserAccountState() async {
    try {
      final userAccountStateString = await _flutterSecureStorage.read(key: _accessUserAccountStateKey);
      if (userAccountStateString == null) {
        return const Success(null);
      }
      return Success(UserAccount.fromJson(jsonDecode(userAccountStateString)));
    } on Exception catch(e) {
      log("Error saving account state: $e");
      return Failure(Exception("Unable to get user account"));
    }
  }

  Future<Result<void, Exception>> clearStorage() async {
    try {
      await _flutterSecureStorage.deleteAll();
      return const Success(null);
    } on Exception catch (e) {
      log("Error clearing storage: $e");
      return Failure(Exception("Unable to clear storage"));
    }
  }
}