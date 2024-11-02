import 'package:flutter/material.dart';  // Make sure to import material.dart for widgets
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/test/domain/models/ingredient.dart';
import 'package:msa_cooking_app_client/features/test/providers/ingredient_provider.dart';
import 'package:msa_cooking_app_client/features/test/widgets/ingredient_item.dart';

class IngredientsListScreen extends ConsumerWidget {
  const IngredientsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the ingredientProvider to get the AsyncValue
    final AsyncValue<List<Ingredient>> ingredients = ref.watch(ingredientProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredients List'), // Add an AppBar for better UX
      ),
      body: ingredients.when(
        data: (ingredientList) {
          // This is where you handle the case when the data is available
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: ingredientList.length, // Use the length of the actual list
            itemBuilder: (BuildContext context, int index) {
              final ingredient = ingredientList[index]; // Get the ingredient
              return SizedBox(
                height: 50,
                child: Center(child: IngredientItem(ingredient: ingredient)), // Assuming Ingredient has a 'name' property
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()), // Show loading indicator
        error: (error, stack) => Center(child: Text('Erro: $error')), // Handle error case
      ),
    );
  }
}
