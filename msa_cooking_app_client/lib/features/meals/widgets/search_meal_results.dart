import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/meals/providers/meals_provider.dart';
import 'package:msa_cooking_app_client/features/meals/models/spoonacular_search_meal_result_meal.dart';
import 'package:msa_cooking_app_client/features/meals/providers/meals_search_result_provider.dart';

import '../models/search_meals.dart';

class SearchMealResults extends ConsumerWidget {
  final SearchMeals searchMeals;

  SearchMealResults(this.searchMeals);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsStateAsync = ref.watch(mealsSearchResultProvider(searchMeals));

    // Handle loading state
    return mealsStateAsync.when(
      loading: () => Center(child: CircularProgressIndicator()),  // Display loading spinner while data is fetched
      error: (error, stack) => Center(child: Text('Something went wrong!')),  // Show error message
      data: (mealsState) {
        final meals = mealsState?.result?.results;

        if (meals!.isEmpty) {
          return Center(child: Text('No meals found'));
        }

        // Display the list of meals
        return ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            final meal = meals[index];
            return MealCard(meal: meal); // Custom card widget for each meal
          },
        );
      },
    );
  }
}

class MealCard extends ConsumerWidget {
  final SpoonacularSearchMealResultMeal meal;

  const MealCard({required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meal image
            if (meal.image != null)
              Image.network(
                meal.image!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meal title
                  Text(
                    meal.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Ingredients counts
                  Row(
                    children: [
                      _buildIngredientInfo(meal.usedIngredientCount, 'Used'),
                      SizedBox(width: 15),
                      _buildIngredientInfo(meal.missedIngredientCount, 'Missing'),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Display missing ingredients
                  if (meal.missedIngredients != null && meal.missedIngredients!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Missing Ingredients:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          ...meal.missedIngredients!.map((ingredient) {
                            return Text(
                              '- ${ingredient.name}',
                              style: TextStyle(fontSize: 14),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  // Save Button
                  Align(
                    alignment: Alignment.centerRight,
                    child:
                        ref.watch(mealsProvider).isLoading ?
                        CircularProgressIndicator() :
                    ElevatedButton(
                      onPressed: () {
                        ref.read(mealsProvider.notifier).saveMeal(meal.id);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.save),
                          SizedBox(width: 5),
                          Text('Save'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build ingredient info widget
  Widget _buildIngredientInfo(int count, String label) {
    return Row(
      children: [
        Icon(Icons.fastfood, size: 20),
        SizedBox(width: 5),
        Text(
          '$label: $count',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
