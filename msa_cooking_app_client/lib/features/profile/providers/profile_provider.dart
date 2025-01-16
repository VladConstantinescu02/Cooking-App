import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:msa_cooking_app_client/features/profile/models/create_profile.dart';
import 'package:msa_cooking_app_client/features/profile/models/delete_profile_response.dart';
import 'package:msa_cooking_app_client/shared/api/profiles_api_client.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';
import 'package:msa_cooking_app_client/shared/providers/profile_api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:msa_cooking_app_client/features/profile/models/profile.dart' as profile_model;

import '../models/create_profile_response.dart';

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

    Future<void> createProfile(CreateProfile profile, BuildContext context) async {
        state = const AsyncLoading();
        Result<CreateProfileResponse, Exception> result = await _profileApiClient.createProfile(profile);
        if (result is Success<CreateProfileResponse, Exception>) {
            ref.invalidateSelf();
            await future;
        }
    }

    Future<void> deleteProfile(BuildContext context) async {
        state = const AsyncLoading();
        Result<DeleteProfileResponse, Exception> result = await _profileApiClient.deleteProfile();
        if (result is Success<DeleteProfileResponse, Exception>) {
            ref.invalidateSelf();
            await future;
        }
    }

    Future<void> updateProfile(CreateProfile profile, BuildContext context) async {
        state = const AsyncLoading();
        Result<CreateProfileResponse, Exception> result = await _profileApiClient.updateProfile(profile);
        if (result is Success<CreateProfileResponse, Exception>) {
            ref.invalidateSelf();
            context.go('/profile');
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