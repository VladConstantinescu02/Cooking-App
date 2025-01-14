import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/search_ingredient.dart';
import '../providers/ingredients_api_client_provider.dart';
import '../errors/result.dart';

class SearchIngredients extends ConsumerStatefulWidget {
  final void Function(SearchIngredient ingredient) onIngredientSelected;
  final List<SearchIngredient> _ingredientsSearched;

  const SearchIngredients(this._ingredientsSearched, {super.key, required this.onIngredientSelected});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SearchIngredientsState();
  }
}

class _SearchIngredientsState extends ConsumerState<SearchIngredients> {
  late TextEditingController _controller;
  late Timer _debounce;
  String _query = '';
  List<SearchIngredient> _ingredients = [];
  bool _isLoading = false;
  List<SearchIngredient> _ingredientsSearched = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _debounce = Timer(Duration.zero, () {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _query = query;
      _ingredientsSearched = [];
      _ingredients = [];
    });

    if (_debounce.isActive) _debounce.cancel();

    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (_query.isNotEmpty) {
        _searchIngredients(query);
      }
    });
  }

  Future<void> _searchIngredients(String query) async {
    if (query == '') {
      setState(() {
        _ingredients = [];
      });
    }
    setState(() {
      _isLoading = true;
    });

    final result = await ref.read(ingredientsApiClientProvider).searchIngredients(query);

    setState(() {
      _isLoading = false;
    });

    if (result is Success<List<SearchIngredient>, Exception>) {
      setState(() {
        _ingredients = result.value;
      });
    } else {
      setState(() {
        _ingredients = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _ingredientsSearched = widget._ingredientsSearched
        .map((ingredient) => ingredient.copy())
        .toList();
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Search for ingredients...',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: _onSearchChanged,
          ),
          const SizedBox(height: 5),
          if (_isLoading)
            const CircularProgressIndicator(),
          if (!_isLoading && _ingredients.isEmpty && _query.isNotEmpty)
            const Text(
              'No ingredients found. Try a different query.',
              style: TextStyle(color: Colors.red),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = _ingredients[index];
                final isSelected = _ingredientsSearched.any((searchedIngredient) => searchedIngredient.id == ingredient.id);

                return ListTile(
                  title: Text(ingredient.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  trailing: Icon(
                    isSelected ? Icons.check_box : Icons.add_circle,
                  ),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _ingredientsSearched.removeWhere((searchedIngredient) => searchedIngredient.id == ingredient.id);
                      } else {
                        if (!_ingredientsSearched.contains(ingredient)) {
                          _ingredientsSearched.add(ingredient);
                        }
                      }
                    });

                    widget.onIngredientSelected(ingredient);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}