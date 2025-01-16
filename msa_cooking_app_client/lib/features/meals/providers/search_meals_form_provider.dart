import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_meals_form_provider.g.dart';

@riverpod
class SearchMealsForm extends _$SearchMealsForm {
  @override
  Map<String, dynamic> build() {
    return {};
  }

  void updateField(String key, dynamic value) {
    state = {...state, key: value};
  }
}