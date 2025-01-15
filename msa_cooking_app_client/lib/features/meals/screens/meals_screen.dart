import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/meals/providers/meals_provider.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_all_meals_meal.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:msa_cooking_app_client/features/meals/widgets/get_meal.dart';

class MealsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsStateAsync = ref.watch(mealsProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return Dialog.fullscreen(
              child: Text("Hello!"),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
      body: mealsStateAsync.when(
        data: (mealsState) {
          if (mealsState.meals == null || mealsState.meals!.isEmpty) {
            return const Center(
              child: Text(
                'No meals available!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: mealsState.meals!.length,
            itemBuilder: (context, index) {
              final meal = mealsState.meals![index];
              return MealCard(meal: meal);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'An error occurred: $error',
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final GetAllMealsMeal meal;

  const MealCard({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              Image.network(
                meal.image,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, size: 100, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: TextButton.icon(
                        onPressed: () {
                          showDialog(context: context, builder: (context) {
                            return Dialog.fullscreen(
                              child: MealDetailsWidget(meal.id),
                            );
                          });
                        },
                        label: Text(
                          meal.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      icon: const Icon(Icons.ads_click),
                      )
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'remove') {
                            // Handle delete action
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'remove',
                            child: Text('Remove'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: HtmlWidget(
                    meal.summary,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    customStylesBuilder: (element) {
                      return {
                        'overflow': 'hidden',
                        'text-overflow': 'ellipsis',
                        'display': '-webkit-box',
                        '-webkit-line-clamp': '3',
                        '-webkit-box-orient': 'vertical',
                        'color': 'black'
                      };
                    },
                    onTapUrl: (url) {
                      return true;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${meal.readyInMinutes} mins',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                    meal.wasPrepared
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.timer, color: Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
