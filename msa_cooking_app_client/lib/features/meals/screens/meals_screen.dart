import 'package:flutter/material.dart';
import 'package:msa_cooking_app_client/features/meals/widgets/meals_tile.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Your Meals"),
        elevation: 0,
      ),
      body: ListView(
        children: [
          MealsTile(),
        ],
      ),
    );
  }
}
