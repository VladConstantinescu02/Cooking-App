import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/meals/models/search_meals.dart';
import 'package:msa_cooking_app_client/features/meals/models/search_meals_result.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';
import 'package:msa_cooking_app_client/shared/providers/meals_api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "meals_search_result_provider.g.dart";

@riverpod
Future<SearchMealsResult?> mealsSearchResult(Ref ref, SearchMeals searchMeals) async {
  final mealsApiClient = ref.read(mealsApiClientProvider);
  var result = await mealsApiClient.searchMeals(searchMeals);
  if (result is Success<SearchMealsResult, Exception>) {
    return result.value;
  } else {
    return null;
  }
}