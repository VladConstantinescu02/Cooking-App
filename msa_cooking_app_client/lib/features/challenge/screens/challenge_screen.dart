import 'package:flutter/material.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          children: [
            Text("Challenge Screen"),
            Icon(Icons.home_filled)
          ]
        )
    );
  }

}