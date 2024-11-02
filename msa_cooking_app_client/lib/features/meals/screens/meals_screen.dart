import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          children: [
            Text("Meals Screen"),
            Icon(Icons.set_meal)
          ]
        )
    );
  }
}