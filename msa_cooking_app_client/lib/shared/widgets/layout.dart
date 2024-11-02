import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:msa_cooking_app_client/features/navigation/widgets/navigation.dart';

class Layout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const Layout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Msa Cooking App")
      ),
        body: navigationShell,
        bottomNavigationBar: Navigation(navigationShell: navigationShell),
    );
  }
}