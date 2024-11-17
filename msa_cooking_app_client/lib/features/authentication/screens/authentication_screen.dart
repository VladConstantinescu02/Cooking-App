import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:msa_cooking_app_client/features/authentication/models/user_account.dart';
import 'package:msa_cooking_app_client/features/authentication/providers/authentication_provider.dart';
import 'package:msa_cooking_app_client/features/authentication/widgets/authentication_button.dart';

class AuthenticationScreen extends ConsumerWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserAccount> account = ref.watch(authenticationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Authenticate"),
      ),
      body: account.when(
        data: (googleAccount) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthenticationButton(),
              if (googleAccount.displayName.isNotEmpty)
                Center(
                  child: Text('Signed in as: ${googleAccount.displayName}'),
                ),
              if (googleAccount.email.isNotEmpty)
                Center(
                  child: Text('Email: ${googleAccount.email}'),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

