import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/meals/providers/get_all_meal_types_provider.dart';
import 'package:msa_cooking_app_client/features/meals/providers/get_all_meals_cuisines_provider.dart';
import 'package:msa_cooking_app_client/features/meals/providers/search_meals_form_provider.dart';

import '../providers/dietary_options_provider.dart';

class SearchMealStep4 extends ConsumerStatefulWidget {
  SearchMealStep4(this._formKey, this.formBody, this.updateField, {super.key});
  final GlobalKey<FormState> _formKey;
  final dynamic formBody;
  final void Function(String key, dynamic value) updateField;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchMealStep4State();
}

class _SearchMealStep4State extends ConsumerState<SearchMealStep4> {
  late bool useProfileDiet;
  late String? dietId;

  @override
  void initState() {
    super.initState();
    useProfileDiet = widget.formBody['useProfileDiet'] ?? false;
    dietId = widget.formBody['dietId'];
  }

  @override
  Widget build(BuildContext context) {
    final dietaryOptionsAsyncValue = ref.watch(dietaryOptionsProvider);

    return Form(
      key: widget._formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
          Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: CheckboxListTile(
            title: const Text('Use profile diet?'),
            value: useProfileDiet,
            onChanged: (bool? value) {
              setState(() {
                useProfileDiet = value ?? false;
                if (useProfileDiet) {
                  widget.updateField('dietId', null);
                }
                widget.updateField('useProfileDiet', useProfileDiet);
              });
            },
          ),
        ),
          ],
        ),
      ),
    );
  }
}