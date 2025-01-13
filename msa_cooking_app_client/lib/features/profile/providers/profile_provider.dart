import 'package:msa_cooking_app_client/shared/api/profiles_api_client.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';
import 'package:msa_cooking_app_client/shared/providers/profile_api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:msa_cooking_app_client/features/profile/models/profile.dart' as profile_model;

part "profile_provider.g.dart";

@riverpod
class Profile extends _$Profile {
    ProfilesApiClient get _profileApiClient => ref.watch(profileApiClientProvider);

    Future<void> getProfile() async {
        state = const AsyncLoading();
        Result<profile_model.Profile, Exception> result = await _profileApiClient.getProfile();
        if (result is Success<profile_model.Profile, Exception>) {
            final profile = result.value;
            state = AsyncValue<profile_model.Profile>.data(profile);
        } else if (result is Failure<profile_model.Profile, Exception>) {
            state = AsyncValue<profile_model.Profile>.data(profile_model.Profile.defaultProfile());
        }
    }

    @override
    Future<profile_model.Profile> build() async {
        state = const AsyncLoading();
        Result<profile_model.Profile, Exception> result = await _profileApiClient.getProfile();
        if (result is Success<profile_model.Profile, Exception>) {
            return result.value;
        }
        state = const AsyncLoading();
        return profile_model.Profile.defaultProfile();
    }
}