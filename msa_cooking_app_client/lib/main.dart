import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:msa_cooking_app_client/config/routing/router_configuration.dart";
import 'package:msa_cooking_app_client/features/navigation/screens/home_screen.dart';

void main() {
  runApp(
    ProviderScope(
        child: MaterialApp.router(
          routerConfig: router
        )
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

