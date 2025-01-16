import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/meals/providers/get_all_meal_types_provider.dart';
import 'package:msa_cooking_app_client/features/meals/providers/get_all_meals_cuisines_provider.dart';
import 'package:msa_cooking_app_client/features/meals/providers/search_meals_form_provider.dart';

class SearchMealStep2 extends ConsumerStatefulWidget {
  SearchMealStep2(this._formKey, this.formBody, this.updateField, {super.key});
  final GlobalKey<FormState> _formKey;
  final dynamic formBody;
  final void Function(String key, dynamic value) updateField;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchMealStep2State();
}

class _SearchMealStep2State extends ConsumerState<SearchMealStep2> {
  late TextEditingController queryController;
  late TextEditingController minCaloriesController;
  late TextEditingController maxCaloriesController;

  @override
  void initState() {
    super.initState();
    queryController = TextEditingController(text: widget.formBody['query'] ?? '');
    queryController.addListener(() {
      widget.updateField('query', queryController.text);
    });

    minCaloriesController = TextEditingController(
        text: widget.formBody['minCalories']?.toString() ?? '');
    minCaloriesController.addListener(() {
      final value = int.tryParse(minCaloriesController.text);
      widget.updateField('minCalories', value);
    });

    maxCaloriesController = TextEditingController(
        text: widget.formBody['maxCalories']?.toString() ?? '');
    maxCaloriesController.addListener(() {
      final value = int.tryParse(maxCaloriesController.text);
      widget.updateField('maxCalories', value);
    });
  }

  @override
  void dispose() {
    queryController.dispose();
    minCaloriesController.dispose();
    maxCaloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mealTypesStateAsync = ref.watch(getAllMealTypesProvider);

    return Form(
      key: widget._formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            mealTypesStateAsync.when(
              data: (mealTypesResult) => DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the type of meal";
                  }
                  return null;
                },
                value: widget.formBody['mealTypeId'],
                decoration: const InputDecoration(
                  labelText: "Meal type*",
                  icon: Icon(Icons.food_bank_outlined),
                  border: OutlineInputBorder(),
                ),
                items: mealTypesResult?.mealTypes.map((mealType) {
                  return DropdownMenuItem<String>(
                    value: mealType.id.toString(),
                    child: Text(mealType.type),
                  );
                }).toList(),
                onChanged: (newValue) {
                  widget.updateField('mealTypeId', newValue);
                },
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text('Error: $error'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: minCaloriesController,
                    decoration: const InputDecoration(
                      labelText: "Min Cal",
                      icon: Icon(Icons.local_fire_department),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: maxCaloriesController,
                    decoration: const InputDecoration(
                      labelText: "Max Cal",
                      icon: Icon(Icons.local_fire_department),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}