import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_stepper/stepper.dart';
import 'package:msa_cooking_app_client/features/meals/providers/meals_provider.dart';
import 'package:msa_cooking_app_client/features/meals/widgets/search_meal_results.dart';
import 'package:msa_cooking_app_client/features/meals/widgets/search_meal_step1.dart';
import 'package:msa_cooking_app_client/features/meals/widgets/search_meal_step2.dart';
import 'package:msa_cooking_app_client/features/meals/widgets/search_meal_step3.dart';
import 'package:msa_cooking_app_client/features/meals/widgets/search_meal_step4.dart';

import '../models/search_meals.dart';

class SearchMeal extends ConsumerStatefulWidget {
  const SearchMeal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchMealState();
}

class _SearchMealState extends ConsumerState<SearchMeal> {
  int activeStep = 0;
  int upperBound = 4;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> formBody = {
    'useAllFridgeIngredients': true,
    "includeProfileAlergens": true,
    "useProfileDiet": false
  };

  void updateQueryField(String key, dynamic value) {
    setState(() {
      formBody = {...formBody, key: value};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconStepper(
          icons: const [
            Icon(Icons.food_bank),
            Icon(Icons.fastfood),
            Icon(Icons.emoji_food_beverage),
            Icon(Icons.sports),
            Icon(Icons.medical_information)
        ],
        activeStep: activeStep,
        onStepReached: (index) {
            if(index > activeStep) {
              if (validateStep()) {
                setState(() {
                  activeStep = index;
                });
              }
            } else {
              setState(() {
                activeStep = index;
              });
            }
        },
      ),
        header(),
        Expanded(
          child: Center(
            child: Padding(padding: const EdgeInsets.only(left: 25, right: 25), child: buildContent(),)
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            previousButton(),
            nextButton(),
          ],
        ),
      ]
    );
  }

  bool validateStep() {
    return _formKey.currentState?.validate() ?? false;
  }

  /// Returns the next button.
  Widget nextButton() {
      return ElevatedButton(
        onPressed: () {
          // Increment activeStep, when the next button is tapped. However, check for upper bound.
          if (activeStep < upperBound) {
            if (validateStep()) {
              setState(() {
                activeStep++;
              });
            }
          }
        },
        child: Text('Next'),
      );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: const Text('Prev'),
    );
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          headerText(),
          softWrap: true,
          overflow: TextOverflow.visible,
          style: const TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }


  String headerText() {
    switch (activeStep) {
      case 0:
        return 'Describe your meal';
      case 1:
        return 'More details about your meal';

      case 2:
        return 'If you want, you can specify some ingredients';

      case 3:
        return 'Any dietary preferences?';

      case 4:
        return 'Submit the form and get your meals';

      default:
        return 'Introduction';
    }
  }

  Widget buildContent() {
    switch (activeStep) {
      case 0:
        return SearchMealStep1(_formKey, formBody, updateQueryField);
      case 1:
        return SearchMealStep2(_formKey, formBody, updateQueryField);

      case 2:
        return SearchMealStep3(_formKey, formBody, updateQueryField);

      case 3:
        return SearchMealStep4(_formKey, formBody, updateQueryField);

      case 4:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OutlinedButton(
            onPressed: () async {
              if (formBody['cuisineId'] != null) {
                formBody['cuisineId'] = int.parse(formBody['cuisineId']);
              }
              if (formBody['mealTypeId'] != null) {
                formBody['mealTypeId'] = int.parse(formBody['mealTypeId']);
              }
              if (formBody['dietId'] != null) {
                formBody['dietId'] = int.parse(formBody['dietId']);
              }
              showBottomSheet(context: context, builder: (context) => SearchMealResults(SearchMeals.fromJson(formBody)));
              setState(() {
                activeStep = 0;
              });
              },
            child: const Text("Submit")
            )
          ],
        );

      default:
        return Text("Step 5");
    }
  }
}