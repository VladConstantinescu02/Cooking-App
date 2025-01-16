import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../fridge/providers/fridge_provider.dart';

class SearchMealStep3 extends ConsumerStatefulWidget {
  SearchMealStep3(this._formKey, this.formBody, this.updateField, {super.key});
  final GlobalKey<FormState> _formKey;
  final dynamic formBody;
  final void Function(String key, dynamic value) updateField;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchMealStep3State();
}

class _SearchMealStep3State extends ConsumerState<SearchMealStep3> {
  bool useAllFridgeIngredients = false;
  List<String> selectedIngredients = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.formBody != null) {
        useAllFridgeIngredients = widget.formBody['useAllFridgeIngredients'] ?? false;

        selectedIngredients = List<String>.from(widget.formBody['ingredients'] ?? []);

        widget.updateField('ingredients', selectedIngredients);
        widget.updateField('useAllFridgeIngredients', useAllFridgeIngredients);

        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fridgeStateAsync = ref.watch(fridgeProvider);

    return Form(
      key: widget._formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: ListTile(
                title: const Text("Use all fridge ingredients?"),
                trailing: Checkbox(
                  value: useAllFridgeIngredients,
                  onChanged: (bool? value) {
                    setState(() {
                      useAllFridgeIngredients = value ?? false;
                      if (useAllFridgeIngredients) {
                        widget.updateField('ingredients', null);
                        selectedIngredients = [];
                      }
                      widget.updateField('useAllFridgeIngredients', value);
                    });
                  },
                ),
              ),
            ),
          ),

          if (fridgeStateAsync.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),

          if (!useAllFridgeIngredients && !fridgeStateAsync.isLoading)
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: fridgeStateAsync.value!.fridge!.fridgeIngredients!.map((ingredient) {
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: CheckboxListTile(
                        title: Text(ingredient.name),
                        value: selectedIngredients.contains(ingredient.ingredientId),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedIngredients.add(ingredient.ingredientId);
                            } else {
                              selectedIngredients.remove(ingredient.ingredientId);
                            }
                            widget.updateField('ingredients', selectedIngredients);
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

          if (fridgeStateAsync.hasError)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error loading ingredients: ${fridgeStateAsync.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}



