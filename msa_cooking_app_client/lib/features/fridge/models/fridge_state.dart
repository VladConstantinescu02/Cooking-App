import 'package:msa_cooking_app_client/features/fridge/models/get_fridge.dart';

import '../../../shared/models/warning.dart';

class FridgeState {
  final GetFridge? fridge;
  final List<Warning>? warnings;

  FridgeState(this.fridge, this.warnings);

  static FridgeState defaultState() {
    return FridgeState(null, null);
  }
}