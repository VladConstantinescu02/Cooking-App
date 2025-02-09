import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/config/routing/router_configuration.dart';
import 'package:msa_cooking_app_client/features/navigation/screens/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(child: AppWithRouterProvider()),
  );
}

class AppWithRouterProvider extends ConsumerWidget {
  const AppWithRouterProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
        routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
