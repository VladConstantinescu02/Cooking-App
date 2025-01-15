import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_meal_result.dart';
import 'package:msa_cooking_app_client/features/meals/providers/get_meal_provider.dart';

class MealDetailsWidget extends ConsumerWidget {
  final String mealId;

  const MealDetailsWidget(this.mealId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getMealAsyncState = ref.watch(mealGetProvider(mealId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Details'),
        backgroundColor: Colors.deepOrange,
      ),
      body: getMealAsyncState.when(
        data: (mealResult) => mealResult == null
            ? const Center(child: Text('Meal not found.'))
            : MealDetailsContent(mealResult),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class MealDetailsContent extends StatelessWidget {
  final GetMealResult mealResult;

  const MealDetailsContent(this.mealResult, {super.key});

  @override
  Widget build(BuildContext context) {
    final meal = mealResult.meal;
    final mealData = meal.meal;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meal Image
          if (mealData?.image != null)
            Image.network(
              mealData!.image!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
          const SizedBox(height: 16),

          // Meal Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              mealData?.title ?? 'Unknown Meal',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Ready in Minutes
          if (mealData != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Ready in ${mealData.readyInMinutes} minutes',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),

          // Summary
          if (mealData?.summary != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: HtmlWidget(mealData!.summary!),
            ),

          const Divider(height: 32, thickness: 1),

          // Ingredients
          if (mealData != null && mealData.extendedIngredients.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ingredients:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...mealData.extendedIngredients.map(
                        (ingredient) => Text(
                      '- ${ingredient.original ?? ingredient.name}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

          const Divider(height: 32, thickness: 1),

          // Instructions
          if (mealData != null && mealData.analyzedInstructions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Instructions:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...mealData.analyzedInstructions.first.steps.map(
                        (step) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${step.number}. ${step.step}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          if (step.equipment.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'Equipment: ${step.equipment.map((e) => e.name).join(", ")}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
