import 'package:flutter/cupertino.dart';
import 'package:msa_cooking_app_client/features/test/domain/models/ingredient.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  const IngredientItem({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(ingredient.id),
        Text(ingredient.name),
        Text(ingredient.caloriesPer100Grams.toString())
      ]
    );
  }
}