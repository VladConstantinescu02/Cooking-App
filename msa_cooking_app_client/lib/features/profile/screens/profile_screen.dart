import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/authentication/providers/authentication_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAccountAsync = ref.watch(authenticationProvider);

    return Center(
      child: userAccountAsync.when(
        data: (userAccount) {
          // Display user details when data is available
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Profile Screen",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Icon(
                Icons.account_circle_rounded,
                size: 100,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                "Name: ${userAccount.displayName}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Email: ${userAccount.email}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(authenticationProvider.notifier).signOut();
                },
                child: const Text("Sign Out"),
              ),
            ],
          );
        },
        loading: () {
          // Display a loading indicator while fetching data
          return const CircularProgressIndicator();
        },
        error: (error, stackTrace) {
          // Display an error message if something goes wrong
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                "Error: $error",
                style: const TextStyle(fontSize: 18, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.refresh(authenticationProvider); // Retry fetching data
                },
                child: const Text("Retry"),
              ),
            ],
          );
        },
      ),
    );
  }
}