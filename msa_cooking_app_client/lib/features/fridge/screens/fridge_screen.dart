import 'package:flutter/material.dart';
import 'package:msa_cooking_app_client/features/fridge/widgets/fridge_tile.dart';
import 'package:msa_cooking_app_client/features/fridge/widgets/ingredient_dialog_box.dart';

class FridgeScreen extends StatelessWidget {
  FridgeScreen({super.key});

  List foodList = [
    ["1a","Fish", 200.0, 100.0, 'g'],
    ["1b","Veggie", 300.0, 50.0, 'g'],
  ];


  void addIngredient(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return IngredientDialogBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('Your Fridge'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addIngredient(context);
        },
        backgroundColor: Colors.black87,
        elevation: 0,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Ingredient',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          return FridgeTile(ingredientID: foodList[index][0], ingredientName: foodList[index][1], ingredientCalories: foodList[index][2], ingredientQty: foodList[index][3], ingredientQtySuffix: foodList[index][4]);
        },
      ),
      );
  }
}