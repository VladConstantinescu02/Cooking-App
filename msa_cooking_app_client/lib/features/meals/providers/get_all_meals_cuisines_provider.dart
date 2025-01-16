import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_all_meal_cuisines_result.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';
import 'package:msa_cooking_app_client/shared/providers/meals_api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_all_meals_cuisines_provider.g.dart";

@riverpod
Future<GetAllMealCuisinesResult?> getAllMealCuisines(Ref ref) async {
  final mealsApiClient = ref.read(mealsApiClientProvider);
  var result = await mealsApiClient.getAllMealCuisines();
  if (result is Success<GetAllMealCuisinesResult, Exception>) {
    return result.value;
  } else {
    return null;
  }
}