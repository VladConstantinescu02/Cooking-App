import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_all_meal_types_result.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';
import 'package:msa_cooking_app_client/shared/providers/meals_api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "get_all_meal_types_provider.g.dart";

@riverpod
Future<GetAllMealTypesResult?> getAllMealTypes(Ref ref) async {
  final mealsApiClient = ref.read(mealsApiClientProvider);
  var result = await mealsApiClient.getAllMealTypes();
  if (result is Success<GetAllMealTypesResult, Exception>) {
    return result.value;
  } else {
    return null;
  }
}