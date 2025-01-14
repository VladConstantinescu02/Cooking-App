import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/fridge/providers/fridge_provider.dart';
import 'package:msa_cooking_app_client/features/fridge/providers/ingredient_measuring_units_provider.dart';

import '../models/add_fridge_ingredient.dart';

class UpdateFridgeIngredientForm extends ConsumerStatefulWidget {
  final String _ingredientId;
  final String _ingredientName;
  final double _ingredientQuantity;
  final String _ingredientMeasuringUnitSuffix;

  const UpdateFridgeIngredientForm({super.key, required String ingredientId, required String ingredientName, required double ingredientQuantity, required String ingredientMeasuringUnitSuffix}) : _ingredientId = ingredientId, _ingredientName = ingredientName, _ingredientQuantity = ingredientQuantity, _ingredientMeasuringUnitSuffix = ingredientMeasuringUnitSuffix;

  @override
  _UpdateFridgeIngredientFormState createState() => _UpdateFridgeIngredientFormState();
}

class _UpdateFridgeIngredientFormState extends ConsumerState<UpdateFridgeIngredientForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ingredientQuantityController = TextEditingController();
  int? _selectedMeasuringUnit;

  @override
  Widget build(BuildContext context) {
    final ingredientName = widget._ingredientName;
    final ingredientMeasuringUnits = ref.watch(ingredientMeasuringUnitsProvider);

    if (_ingredientQuantityController.text == '') {
      _ingredientQuantityController.text = widget._ingredientQuantity.toString();
    }

    _selectedMeasuringUnit ??= ingredientMeasuringUnits.value?.firstWhere((mu) => mu.unitSuffix == widget._ingredientMeasuringUnitSuffix).id;

    return AlertDialog(
      title: Text('Update "$ingredientName"'),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _ingredientQuantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  final number = double.tryParse(value);
                  if (number == null || number <= 0) {
                    return 'Please enter a valid positive number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ingredientMeasuringUnits.when(
                data: (measuringUnits) => DropdownButtonFormField<int>(
                  value: _selectedMeasuringUnit,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedMeasuringUnit = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Measuring Unit',
                    border: OutlineInputBorder(),
                  ),
                  items: measuringUnits
                      .asMap()
                      .entries
                      .map(
                        (entry) => DropdownMenuItem<int>(
                      value: entry.value.id,
                      child: Text(entry.value.unitName),
                    ),
                  )
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a measuring unit';
                    }
                    return null;
                  },
                ),
                loading: () => const CircularProgressIndicator(),
                error: (error, _) => Text('Error: $error'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final ingredient = AddFridgeIngredient(
                      widget._ingredientId ?? '',
                      double.tryParse(_ingredientQuantityController.text) ?? 0.0,
                      _selectedMeasuringUnit ?? 1,
                    );
                    Navigator.of(context).pop();
                    await ref.read(fridgeProvider.notifier).updateFridgeIngredient(ingredient);
                  }
                },
                child: const Text('Update ingredient'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}