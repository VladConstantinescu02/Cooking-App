import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/meals/providers/get_all_meals_cuisines_provider.dart';
import 'package:msa_cooking_app_client/features/meals/providers/search_meals_form_provider.dart';

class SearchMealStep1 extends ConsumerStatefulWidget {
  SearchMealStep1(this._formKey, this.formBody, this.updateField, {super.key});
  final GlobalKey<FormState> _formKey;
  final dynamic formBody;
  final void Function(String key, dynamic value) updateField;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchMealStep1State();
}

class _SearchMealStep1State extends ConsumerState<SearchMealStep1> {
  late TextEditingController queryController;

  @override
  void initState() {
    super.initState();
    queryController = TextEditingController(text: widget.formBody['query'] ?? '');
    queryController.addListener(() {
      widget.updateField('query', queryController.text);
    });
  }

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mealCuisinesStateAsync = ref.watch(getAllMealCuisinesProvider);

    return Form(
      key: widget._formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: queryController,
              key: const Key('query'),
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: "What would you like to eat?*",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter what would you like to eat";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            mealCuisinesStateAsync.when(
              data: (mealCuisinesResult) => DropdownButtonFormField<String>(
                value: widget.formBody['cuisineId'],
                decoration: const InputDecoration(
                  labelText: "Cuisine",
                  icon: Icon(Icons.food_bank_outlined),
                  border: OutlineInputBorder(),
                ),
                items: mealCuisinesResult?.mealCuisines.map((cuisine) {
                  return DropdownMenuItem<String>(
                    value: cuisine.id.toString(),
                    child: Text(cuisine.cuisine),
                  );
                }).toList(),
                onChanged: (newValue) {
                  widget.updateField('cuisineId', newValue);
                },
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text('Error: $error'),
            ),
          ],
        ),
      ),
    );
  }
}
