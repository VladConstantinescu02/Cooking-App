import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/fridge/models/get_ingredient_measuring_unit.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';
import 'package:msa_cooking_app_client/shared/providers/fridges_api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/get_ingredient_measuring_units_response.dart';

part "ingredient_measuring_units_provider.g.dart";

@riverpod
Future<List<GetIngredientMeasuringUnit>> ingredientMeasuringUnits(Ref ref) async {
  final fridgesApi = ref.read(fridgesApiClientProvider);
  var result = await fridgesApi.getIngredientMeasuringUnits();
  if (result is Success<GetIngredientMeasuringUnitsResponse, Exception>) {
    return result.value.ingredientMeasuringUnits;
  } else {
    return List.empty();
  }
}