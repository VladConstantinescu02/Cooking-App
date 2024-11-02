import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:msa_cooking_app_client/features/fridge/screens/fridge_screen.dart';
import 'package:msa_cooking_app_client/features/meals/screens/meals_screen.dart';
import 'package:msa_cooking_app_client/features/profile/screens/profile_screen.dart';
import 'package:msa_cooking_app_client/main.dart';
import 'package:msa_cooking_app_client/shared/widgets/layout.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: <RouteBase> [
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
              builder: (context, state) => const FridgeScreen()
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
  ]
);