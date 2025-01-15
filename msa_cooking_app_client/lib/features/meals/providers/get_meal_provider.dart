import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_meal_result.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';
import 'package:msa_cooking_app_client/shared/providers/meals_api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_meal_provider.g.dart";

@riverpod
Future<GetMealResult?> mealGet(Ref ref, String mealId) async {
  final mealsApiClient = ref.read(mealsApiClientProvider);
  var result = await mealsApiClient.getMeal(mealId);
  if (result is Success<GetMealResult, Exception>) {
    return result.value;
  } else {
    return null;
  }
}