import 'package:msa_cooking_app_client/features/meals/models/get_all_meals_meal.dart';
import 'package:msa_cooking_app_client/features/meals/models/spoonacular_search_meal_result.dart';

class MealsState {
  final SpoonacularSearchMealResult? result;
  final List<GetAllMealsMeal>? meals;

  MealsState(this.result, this.meals);

  static MealsState defaultState() {
    return MealsState(null, null);
  }
}