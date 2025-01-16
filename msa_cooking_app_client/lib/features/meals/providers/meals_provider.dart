import 'package:msa_cooking_app_client/features/meals/models/delete_meal_result.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_all_meals_result.dart';
import 'package:msa_cooking_app_client/features/meals/models/meals_state.dart';
import 'package:msa_cooking_app_client/features/meals/models/save_meal_result.dart';
import 'package:msa_cooking_app_client/features/meals/models/search_meals.dart';
import 'package:msa_cooking_app_client/features/meals/models/search_meals_result.dart';
import 'package:msa_cooking_app_client/shared/api/meals_api_client.dart';
import 'package:msa_cooking_app_client/shared/providers/meals_api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../shared/errors/result.dart';

part 'meals_provider.g.dart';

@riverpod
class Meals extends _$Meals {
  MealsApiClient get _mealsApiClient => ref.watch(mealsApiClientProvider);

  Future<void> searchMeals(SearchMeals searchMeals) async {
    state = const AsyncLoading();
    Result<SearchMealsResult, Exception> result = await _mealsApiClient.searchMeals(searchMeals);
    if (result is Success<SearchMealsResult, Exception>) {
      final mealsResult = result.value.result;
      final mealsState = MealsState(mealsResult, null);
      state = AsyncValue<MealsState>.data(mealsState);
    } else if (result is Failure<SearchMealsResult, Exception>) {
      state = AsyncValue<MealsState>.data(MealsState.defaultState());
    }
  }

  Future<void> getAllMeals() async {
    state = const AsyncLoading();
    Result<GetAllMealsResult, Exception> result = await _mealsApiClient.getAllMeals();
    if (result is Success<GetAllMealsResult, Exception>) {

    }
  }

  Future<void> deleteMeal(String mealId) async {
    state = const AsyncLoading();
    Result<DeleteMealResult, Exception> result = await _mealsApiClient.deleteMeal(mealId);
    if (result is Success<DeleteMealResult, Exception>) {
      ref.invalidateSelf();
      await future;
    }
  }

  Future<void> saveMeal(String mealId) async {
    state = const AsyncLoading();
    Result<SaveMealResult, Exception> result = await _mealsApiClient.saveMeal(mealId);
    if (result is Success<SaveMealResult, Exception>) {
      ref.invalidateSelf();
      await future;
    }
  }

  @override
  Future<MealsState> build() async {
    state = const AsyncLoading();
    Result<GetAllMealsResult, Exception> result = await _mealsApiClient.getAllMeals();
    if (result is Success<GetAllMealsResult, Exception>) {
      var meals = result.value.meals;
      return MealsState(null, meals);
    }
    return MealsState.defaultState();
  }
}