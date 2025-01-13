import 'package:flutter/material.dart';
import 'package:msa_cooking_app_client/features/fridge/widgets/fridge_tile.dart';
import 'package:msa_cooking_app_client/features/fridge/widgets/ingredient_dialog_box.dart';

class FridgeScreen extends StatefulWidget {
  const FridgeScreen({super.key});

  @override
  State<FridgeScreen> createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen> {
  final _controllerName = TextEditingController();
  final _controllerCalorie = TextEditingController();
  final _controllerAmount = TextEditingController();

  // Default selected type
  String selectedType = 'g';

  List foodList = [
    ["1a", "Fish", 200.0, 100.0, 'g'],
    ["1b", "Veggie", 300.0, 50.0, 'g'],
  ];


  void saveNewIngredient(BuildContext context, String selectedType) {
    setState(() {
      foodList.add([
        "id_${foodList.length + 1}",
        _controllerName.text,
        double.tryParse(_controllerCalorie.text) ?? 0.0,
        double.tryParse(_controllerAmount.text) ?? 0.0,
        selectedType,
      ]);
      _controllerName.clear();
      _controllerCalorie.clear();
      _controllerAmount.clear();
    });
    Navigator.of(context).pop();
  }


  void cancelNewIngredient(BuildContext context) {
    setState(() {
      _controllerName.clear();
      _controllerCalorie.clear();
      _controllerAmount.clear();
      selectedType = 'g';
    });
    Navigator.of(context).pop();
  }


  void addIngredient(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return IngredientDialogBox(
          controllerName: _controllerName,
          controllerCalorie: _controllerCalorie,
          controllerAmount: _controllerAmount,
          onSave: (String selectedType) {
            saveNewIngredient(context, selectedType);
          },
          onCancel: () {
            cancelNewIngredient(context);
          },
        );
      },
    );
  }

  // Function to delete an ingredient
  void deleteIngredient(int ingredientIndex) {
    setState(() {
      foodList.removeAt(ingredientIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Your Fridge'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addIngredient(context); // Add ingredient button
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
          return FridgeTile(
            ingredientID: foodList[index][0],
            ingredientName: foodList[index][1],
            ingredientCalories: foodList[index][2],
            ingredientQty: foodList[index][3],
            ingredientQtySuffix: foodList[index][4],
            deleteFridgeTile: (context) => deleteIngredient(index),
          );
        },
      ),
    );
  }
}
