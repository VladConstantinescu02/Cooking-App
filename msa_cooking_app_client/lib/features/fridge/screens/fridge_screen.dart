import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/fridge/models/get_fridge_ingredient.dart';
import 'package:msa_cooking_app_client/features/fridge/providers/fridge_provider.dart';
import 'package:msa_cooking_app_client/features/fridge/widgets/fridge_ingredient.dart';
import 'package:msa_cooking_app_client/features/fridge/widgets/fridge_tile.dart';
import 'package:msa_cooking_app_client/features/fridge/widgets/ingredient_dialog_box.dart';
import 'package:msa_cooking_app_client/shared/models/search_ingredient.dart';

import '../../../shared/widgets/search_ingredients.dart';
import '../widgets/add_fridge_ingredient_form.dart';

class FridgeScreen extends ConsumerStatefulWidget {
  const FridgeScreen({super.key});

  @override
  ConsumerState<FridgeScreen> createState() => _FridgeScreenState();
}

class _FridgeScreenState extends ConsumerState<FridgeScreen> {
  final _controllerName = TextEditingController();
  final _controllerCalorie = TextEditingController();
  final _controllerAmount = TextEditingController();

  List<SearchIngredient> ingredients = [];

  // Default selected type
  String selectedType = 'g';

  List foodList = [
    GetFridgeIngredient("121212", "morcov", 234, 2, "pieces"),
    GetFridgeIngredient("121213", "telina", 250, 400, "g")
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

  void deleteIngredient(int ingredientIndex) {
    setState(() {
      foodList.removeAt(ingredientIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final fridgeStateAsync = ref.watch(fridgeProvider);
    final fridgeIngredients = fridgeStateAsync.value?.fridge?.fridgeIngredients;
    ingredients = fridgeIngredients?.map((fi) => SearchIngredient(fi.ingredientId, fi.name)).toList() ?? [];
    return Scaffold(
      body: Container(
        child: fridgeIngredients != null && fridgeIngredients.isNotEmpty ?
        fridgeStateAsync.when(
          data: (fridgeState) => ListView.builder(
            itemCount: fridgeIngredients.length,
            itemBuilder: (context, index) {
              return FridgeIngredient(
                fridgeIngredient: fridgeIngredients![index],
              );
            },
          ),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 50),
                const SizedBox(height: 16),
                Text(
                  'Failed to load fridge. Please try again.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ) :
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.not_interested, size: 100,),
                  Text('No fridge ingredients', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  Text('Use the button below to add some', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),)
                ]
              ),
            )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
          context: context,
          builder: (context) => SearchIngredients(
              onIngredientSelected: (SearchIngredient s) {
                showAdaptiveDialog(context: context, builder: (BuildContext context) {
                  return AddFridgeIngredientForm(ingredientId: s.id, ingredientName: s.name);
                });
              }, ingredients)
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

}
