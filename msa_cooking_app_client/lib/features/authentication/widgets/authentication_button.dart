import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/authentication/providers/authentication_provider.dart';

class AuthenticationButton extends ConsumerWidget {
  const AuthenticationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Image.asset('images/logo_white.png'),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await ref.read(authenticationProvider.notifier).signInWithGoogle();
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.supervised_user_circle),
                SizedBox(width: 8),
                Text("Log In with your Google Account"),
              ],
            ),
          ),
        )
      ],
    );
  }
}