import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_all_dietary_options_response.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_dietary_option.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';
import 'package:msa_cooking_app_client/shared/providers/meals_api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "dietary_options_provider.g.dart";

@riverpod
Future<List<GetDietaryOption>> dietaryOptions(Ref ref) async {
  final mealsApiClient = ref.read(mealsApiClientProvider);
  var result = await mealsApiClient.getAllDietaryOptions();
  if (result is Success<GetAllDietaryOptionsResponse, Exception>) {
    return result.value.dietaryOptions;
  } else {
    return List.empty();
  }
}