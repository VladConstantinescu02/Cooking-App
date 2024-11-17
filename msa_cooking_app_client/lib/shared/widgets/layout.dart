import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:msa_cooking_app_client/features/authentication/providers/authentication_provider.dart';
import 'package:msa_cooking_app_client/features/navigation/widgets/navigation.dart';

class Layout extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const Layout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Msa Cooking App"),
        actions: [
          IconButton(
              onPressed: () {
                  ref.read(authenticationProvider.notifier).signOut();
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
        body: navigationShell,
        bottomNavigationBar: Navigation(navigationShell: navigationShell),
    );
  }
}