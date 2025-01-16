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
        title: Row(
          children: [
            Image.asset(
              "images/logo_white.png",
              fit: BoxFit.contain,
              height: 30,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authenticationProvider.notifier).signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
        elevation: 0,
      ),
      body: Container(
        child: navigationShell,
      ),
      bottomNavigationBar: Container(
        child: Navigation(navigationShell: navigationShell),
      ),
    );
  }
}