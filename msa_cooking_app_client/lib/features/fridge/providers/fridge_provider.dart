import 'package:msa_cooking_app_client/features/fridge/models/add_fridge_ingredient.dart';
import 'package:msa_cooking_app_client/features/fridge/models/add_fridge_ingredient_response.dart';
import 'package:msa_cooking_app_client/features/fridge/models/delete_fridge_ingredient_response.dart';
import 'package:msa_cooking_app_client/features/fridge/models/fridge_state.dart';
import 'package:msa_cooking_app_client/shared/providers/fridges_api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/api/fridges_api_client.dart';
import '../../../shared/errors/result.dart';
import '../models/get_fridge_response.dart';
part 'fridge_provider.g.dart';

@riverpod
class Fridge extends _$Fridge {
  FridgesApiClient get _fridgesApiClient => ref.watch(fridgesApiClientProvider);

  Future<void> getFridge() async {
    state = const AsyncLoading();
    Result<GetFridgeResponse, Exception> result = await _fridgesApiClient.getFridge();
    if (result is Success<GetFridgeResponse, Exception>) {
      final fridge = result.value.fridge;
      final fridgeState = FridgeState(fridge, result.value.warnings);
      state = AsyncValue<FridgeState>.data(fridgeState);
    } else if (result is Failure<GetFridgeResponse, Exception>) {
      state = AsyncValue<FridgeState>.data(FridgeState.defaultState());
    }
  }

  Future<void> addFridgeIngredient(AddFridgeIngredient addFridgeIngredient) async {
    state = const AsyncLoading();
    Result<AddFridgeIngredientResponse, Exception> result = await _fridgesApiClient.addFridgeIngredient(addFridgeIngredient);
    if (result is Success<AddFridgeIngredientResponse, Exception>) {
      ref.invalidateSelf();
      await future;
    }
  }

  Future<void> updateFridgeIngredient(AddFridgeIngredient addFridgeIngredient) async {
    state = const AsyncLoading();
    Result<AddFridgeIngredientResponse, Exception> result = await _fridgesApiClient.updateFridgeIngredient(addFridgeIngredient);
    if (result is Success<AddFridgeIngredientResponse, Exception>) {
      ref.invalidateSelf();
      await future;
    }
  }

  Future<void> deleteFridgeIngredient(String fridgeIngredientId) async {
    state = const AsyncLoading();
    Result<DeleteFridgeIngredientResponse, Exception> result = await _fridgesApiClient.deleteFridgeIngredient(fridgeIngredientId);
    if (result is Success<DeleteFridgeIngredientResponse, Exception>) {
      ref.invalidateSelf();
      await future;
    }
  }

  @override
  Future<FridgeState> build() async {
    Result<GetFridgeResponse, Exception> result = await _fridgesApiClient.getFridge();
    if (result is Success<GetFridgeResponse, Exception>) {
      final fridge = result.value.fridge;
      final fridgeState = FridgeState(fridge, result.value.warnings);
      return fridgeState;
    }
    return FridgeState.defaultState();
  }
}