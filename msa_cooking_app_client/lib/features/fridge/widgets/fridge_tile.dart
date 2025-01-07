import 'package:flutter/material.dart';

class FridgeTile extends StatelessWidget {
  final String ingredientID; // Not displayed, but kept for potential backend use
  final String ingredientName;
  final double ingredientCalories;
  final double ingredientQty;
  final String ingredientQtySuffix;

  FridgeTile({
    super.key,
    required this.ingredientID,
    required this.ingredientName,
    required this.ingredientCalories,
    required this.ingredientQty,
    required this.ingredientQtySuffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for ingredient name and calories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Ingredient name
                Text(
                  ingredientName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Ingredient calories
                Text(
                  '${ingredientCalories.toStringAsFixed(0)} kcal',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // Space between rows
            // Quantity information below the ingredient name
            Text(
              '${ingredientQty.toStringAsFixed(1)} $ingredientQtySuffix',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
