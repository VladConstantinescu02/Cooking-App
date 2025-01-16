import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/fridge/models/get_fridge_ingredient.dart';
import 'package:msa_cooking_app_client/features/fridge/widgets/update_fridge_ingredient_form.dart';

import '../providers/fridge_provider.dart';

class FridgeIngredient extends ConsumerWidget {
  final GetFridgeIngredient fridgeIngredient;

  const FridgeIngredient({
    super.key,
    required this.fridgeIngredient,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(fridgeIngredient.ingredientId),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        final bool? confirm = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Delete'),
              content: const Text('Are you sure you want to delete this ingredient?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                    await ref.read(fridgeProvider.notifier).deleteFridgeIngredient(fridgeIngredient.ingredientId);
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );
        return confirm ?? false; // Dismiss only if the user confirmed
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(
          Icons.delete_outline,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                child: Text(
                  fridgeIngredient.name[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fridgeIngredient.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${fridgeIngredient.caloriesPer100Grams.toStringAsFixed(1)} cal/100g',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${fridgeIngredient.quantity} ${fridgeIngredient.ingredientMeasuringUnitSuffix}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) async {
                  if (value == 'edit')  {
                    showAdaptiveDialog(context: context, builder: (BuildContext context) {
                      return UpdateFridgeIngredientForm(ingredientId: fridgeIngredient.ingredientId, ingredientName: fridgeIngredient.name, ingredientQuantity: fridgeIngredient.quantity, ingredientMeasuringUnitSuffix: fridgeIngredient.ingredientMeasuringUnitSuffix);
                    });
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
