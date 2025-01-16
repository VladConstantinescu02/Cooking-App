// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals_search_result_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mealsSearchResultHash() => r'14a3706101d0fcbbff55fe4f9b7c28349fc5ebd1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [mealsSearchResult].
@ProviderFor(mealsSearchResult)
const mealsSearchResultProvider = MealsSearchResultFamily();

/// See also [mealsSearchResult].
class MealsSearchResultFamily extends Family<AsyncValue<SearchMealsResult?>> {
  /// See also [mealsSearchResult].
  const MealsSearchResultFamily();

  /// See also [mealsSearchResult].
  MealsSearchResultProvider call(
    SearchMeals searchMeals,
  ) {
    return MealsSearchResultProvider(
      searchMeals,
    );
  }

  @override
  MealsSearchResultProvider getProviderOverride(
    covariant MealsSearchResultProvider provider,
  ) {
    return call(
      provider.searchMeals,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'mealsSearchResultProvider';
}

/// See also [mealsSearchResult].
class MealsSearchResultProvider
    extends AutoDisposeFutureProvider<SearchMealsResult?> {
  /// See also [mealsSearchResult].
  MealsSearchResultProvider(
    SearchMeals searchMeals,
  ) : this._internal(
          (ref) => mealsSearchResult(
            ref as MealsSearchResultRef,
            searchMeals,
          ),
          from: mealsSearchResultProvider,
          name: r'mealsSearchResultProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mealsSearchResultHash,
          dependencies: MealsSearchResultFamily._dependencies,
          allTransitiveDependencies:
              MealsSearchResultFamily._allTransitiveDependencies,
          searchMeals: searchMeals,
        );

  MealsSearchResultProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchMeals,
  }) : super.internal();

  final SearchMeals searchMeals;

  @override
  Override overrideWith(
    FutureOr<SearchMealsResult?> Function(MealsSearchResultRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MealsSearchResultProvider._internal(
        (ref) => create(ref as MealsSearchResultRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchMeals: searchMeals,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SearchMealsResult?> createElement() {
    return _MealsSearchResultProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MealsSearchResultProvider &&
        other.searchMeals == searchMeals;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchMeals.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MealsSearchResultRef on AutoDisposeFutureProviderRef<SearchMealsResult?> {
  /// The parameter `searchMeals` of this provider.
  SearchMeals get searchMeals;
}

class _MealsSearchResultProviderElement
    extends AutoDisposeFutureProviderElement<SearchMealsResult?>
    with MealsSearchResultRef {
  _MealsSearchResultProviderElement(super.provider);

  @override
  SearchMeals get searchMeals =>
      (origin as MealsSearchResultProvider).searchMeals;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
