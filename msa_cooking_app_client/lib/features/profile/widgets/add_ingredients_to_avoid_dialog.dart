import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/shared/widgets/search_ingredients.dart';

import '../../../shared/models/search_ingredient.dart';

class AddIngredientsToAvoidDialog extends ConsumerWidget {
  final void Function(SearchIngredient ingredient) onIngredientSelected;
  final List<SearchIngredient> _ingredientsSearched;

  const AddIngredientsToAvoidDialog(this._ingredientsSearched, {super.key, required this.onIngredientSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("Add Ingredient to Avoid", style: TextStyle(fontSize: 18)),
      content: SearchIngredients(onIngredientSelected: onIngredientSelected, _ingredientsSearched),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}