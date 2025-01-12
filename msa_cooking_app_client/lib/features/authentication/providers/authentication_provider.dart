import 'package:msa_cooking_app_client/features/authentication/models/authenticate_user_result.dart';
import 'package:msa_cooking_app_client/features/authentication/models/user_account.dart';
import 'package:msa_cooking_app_client/features/authentication/providers/authentication_service_provider.dart';
import 'package:msa_cooking_app_client/features/authentication/services/authentication_service.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';
import 'package:msa_cooking_app_client/shared/helpers/secure_storage.dart';
import 'package:msa_cooking_app_client/shared/providers/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:msa_cooking_app_client/features/profile/providers/profile_provider.dart' as profile_provider;
import 'package:msa_cooking_app_client/features/profile/models/profile.dart' as profile_model;

part 'authentication_provider.g.dart';

@riverpod
class Authentication extends _$Authentication {
  AuthenticationService get _authenticationService => ref.watch(authenticationServiceProvider);
  SecureStorage get _secureStorage => ref.watch(secureStorageProvider);
  AsyncValue<profile_model.Profile> get _profileState => ref.watch(profile_provider.profileProvider);

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    Result<AuthenticateUserResult?, Exception> result = await _authenticationService.authenticateUser();

    if (result is Success<AuthenticateUserResult?, Exception>) {
      final googleAccount = result.value?.googleAccount;

      if (googleAccount != null) {
        final userAccount = UserAccount.fromGoogleAccount(googleAccount, result.value?.jwtToken ?? "");
        state = AsyncValue<UserAccount>.data(userAccount);

        await _secureStorage.setUserAccountState(userAccount);

        await ref.read(profile_provider.profileProvider.notifier).getProfile();
      } else {
        state = AsyncError('Google account is null', StackTrace.current);
      }
    } else if (result is Failure<AuthenticateUserResult?, Exception>) {
      state = AsyncError(result.exception.toString(), StackTrace.current);
    }
  }

  Future<void> signOut() async {
    final value = await _authenticationService.logoutUser();
    if (value is Success) {
      state = AsyncValue<UserAccount>.data(UserAccount.defaultAccount());
      await _secureStorage.clearStorage();
    } else if (value is Failure) {
      state = AsyncError(value.exception.toString(), StackTrace.current);
    }
  }

  @override
  Future<UserAccount> build() async {
    final getUserAccountResult = await _secureStorage.getUserAccountState();
    if (getUserAccountResult is Success<UserAccount?, Exception>) {
      if (getUserAccountResult.value == null) {
        _secureStorage.setUserAccountState(UserAccount.defaultAccount());
      }
      return getUserAccountResult.value ?? UserAccount.defaultAccount();
    } else if (getUserAccountResult is Failure<UserAccount?, Exception>) {
      return UserAccount.defaultAccount();
    }
    return UserAccount.defaultAccount();
  }
}


