import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:msa_cooking_app_client/features/authentication/providers/authentication_provider.dart';
import 'package:msa_cooking_app_client/features/authentication/screens/authentication_screen.dart';
import 'package:msa_cooking_app_client/features/fridge/screens/fridge_screen.dart';
import 'package:msa_cooking_app_client/features/meals/screens/meals_screen.dart';
import 'package:msa_cooking_app_client/features/profile/providers/profile_provider.dart';
import 'package:msa_cooking_app_client/features/profile/screens/create_profile_screen.dart';
import 'package:msa_cooking_app_client/features/profile/screens/profile_screen.dart';
import 'package:msa_cooking_app_client/features/profile/screens/update_profile_screen.dart';
import 'package:msa_cooking_app_client/main.dart';
import 'package:msa_cooking_app_client/shared/screens/error_screen.dart';
import 'package:msa_cooking_app_client/shared/screens/loading_screen.dart';
import 'package:msa_cooking_app_client/shared/widgets/layout.dart';
import 'package:msa_cooking_app_client/features/profile/models/profile.dart' as profile_model;

import '../../features/authentication/models/user_account.dart';
import '../../features/profile/screens/update_profile_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final AsyncValue<UserAccount> account = ref.watch(authenticationProvider);
  final AsyncValue<profile_model.Profile> profile = ref.watch(profileProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/auth',
    routes: <RouteBase>[
      GoRoute(
        path: '/auth',
        name: 'Auth',
        builder: (context, state) => const AuthenticationScreen(),
      ),
      GoRoute(
        path: '/loading',
        name: 'Loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Layout(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/home',
              name: 'Home',
              builder: (context, state) => const MyApp(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/meals',
              name: 'Meals',
              builder: (context, state) => MealsScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/fridge',
              name: 'Fridge',
              builder: (context, state) => const FridgeScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/profile',
              name: 'Profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/error',
              name: 'Error',
              builder: (context, state) => const ErrorScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/create-profile',
              name: 'CreateProfile',
              builder: (context, state) => const CreateProfileScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/update-profile',
              name: 'UpdateProfile',
              builder: (context, state) => const UpdateProfileScreen(),
            ),
          ]),
        ],
      ),
    ],
    redirect: (context, state) {
      final accountState = account;
      final profileState = profile;

      if (accountState is AsyncLoading || profileState is AsyncLoading) {
        return '/loading';
      }

      if (accountState is AsyncError || profileState is AsyncError) {
        return '/error';
      }

      var isAuthenticated = accountState.value?.isAuthenticated;
      var profileExists = profileState.value?.id != null;

      if (isAuthenticated == null) {
        return '/loading';
      }

      if (!isAuthenticated) {
        return '/auth';
      }

      if (isAuthenticated && !profileExists) {
        return '/create-profile';
      }

      if (state.uri.toString() == '/auth') {
        return isAuthenticated ? '/home' : null;
      }

      return null;
    },
  );
});