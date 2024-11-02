import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          children: [
            Text("Profile Screen"),
            Icon(Icons.account_circle_rounded)
          ]
        )
    );
  }
}