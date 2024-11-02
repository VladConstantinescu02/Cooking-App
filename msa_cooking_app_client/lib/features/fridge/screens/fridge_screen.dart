import 'package:flutter/material.dart';

class FridgeScreen extends StatelessWidget {
  const FridgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          children: [
            Text("Fridge Screen"),
            Icon(Icons.fastfood_rounded)
          ]
        )
    );
  }
}