import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FridgeTile extends StatelessWidget {
  final String ingredientID;
  final String ingredientName;
  final double ingredientCalories;
  final double ingredientQty;
  final String ingredientQtySuffix;
  Function(BuildContext)? deleteFridgeTile;

  FridgeTile({
    super.key,
    required this.ingredientID,
    required this.ingredientName,
    required this.ingredientCalories,
    required this.ingredientQty,
    required this.ingredientQtySuffix,
    required this.deleteFridgeTile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                  onPressed: deleteFridgeTile,
                  icon: Icons.delete_sweep,
                  backgroundColor: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
              ),
            ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ingredientName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${ingredientCalories.toStringAsFixed(0)} kcal',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
      ),
    );
  }
}
