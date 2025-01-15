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
    return SearchIngredients(onIngredientSelected: onIngredientSelected, _ingredientsSearched);
  }
}