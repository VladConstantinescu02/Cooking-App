import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:msa_cooking_app_client/features/authentication/providers/authentication_provider.dart';
import 'package:msa_cooking_app_client/features/authentication/screens/authentication_screen.dart';
import 'package:msa_cooking_app_client/features/fridge/screens/fridge_screen.dart';
import 'package:msa_cooking_app_client/features/meals/screens/meals_screen.dart';
import 'package:msa_cooking_app_client/features/profile/screens/profile_screen.dart';
import 'package:msa_cooking_app_client/main.dart';
import 'package:msa_cooking_app_client/shared/widgets/layout.dart';

import '../../features/authentication/models/user_account.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final AsyncValue<UserAccount> account = ref.watch(authenticationProvider);

  return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/auth',
      routes: <RouteBase> [
        GoRoute(
            path: '/auth',
            name: 'Auth',
            builder: (context, state) => const AuthenticationScreen()
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
                    builder: (context, state) => const MyApp()
                )
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                    path: '/meals',
                    name: 'Meals',
                    builder: (context, state) => const MealsScreen()
                )
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                    path: '/fridge',
                    name: 'Fridge',
                    builder: (context, state) => FridgeScreen()
                )
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                    path: '/profile',
                    name: 'Profile',
                    builder: (context, state) => const ProfileScreen()
                )
              ])
            ]
        )
      ],
    redirect: (context, state) {
      final accountState = account;

      if (accountState is AsyncLoading) {
        return null;
      }

      if (accountState is AsyncError) {
        return '/error';
      }

      var isAuthenticated = accountState.value?.isAuthenticated;
      if (isAuthenticated == null) {
        return null;
      }

      if (state.uri.toString() == '/auth') {
        return isAuthenticated ? '/home' : null;
      }

      return isAuthenticated ? null : '/auth';
    },
  );
});