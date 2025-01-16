// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_meal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mealGetHash() => r'a1b5678771afe864db4efb23e4d651502c4ae417';

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

/// See also [mealGet].
@ProviderFor(mealGet)
const mealGetProvider = MealGetFamily();

/// See also [mealGet].
class MealGetFamily extends Family<AsyncValue<GetMealResult?>> {
  /// See also [mealGet].
  const MealGetFamily();

  /// See also [mealGet].
  MealGetProvider call(
    String mealId,
  ) {
    return MealGetProvider(
      mealId,
    );
  }

  @override
  MealGetProvider getProviderOverride(
    covariant MealGetProvider provider,
  ) {
    return call(
      provider.mealId,
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
  String? get name => r'mealGetProvider';
}

/// See also [mealGet].
class MealGetProvider extends AutoDisposeFutureProvider<GetMealResult?> {
  /// See also [mealGet].
  MealGetProvider(
    String mealId,
  ) : this._internal(
          (ref) => mealGet(
            ref as MealGetRef,
            mealId,
          ),
          from: mealGetProvider,
          name: r'mealGetProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mealGetHash,
          dependencies: MealGetFamily._dependencies,
          allTransitiveDependencies: MealGetFamily._allTransitiveDependencies,
          mealId: mealId,
        );

  MealGetProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mealId,
  }) : super.internal();

  final String mealId;

  @override
  Override overrideWith(
    FutureOr<GetMealResult?> Function(MealGetRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MealGetProvider._internal(
        (ref) => create(ref as MealGetRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mealId: mealId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<GetMealResult?> createElement() {
    return _MealGetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MealGetProvider && other.mealId == mealId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mealId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MealGetRef on AutoDisposeFutureProviderRef<GetMealResult?> {
  /// The parameter `mealId` of this provider.
  String get mealId;
}

class _MealGetProviderElement
    extends AutoDisposeFutureProviderElement<GetMealResult?> with MealGetRef {
  _MealGetProviderElement(super.provider);

  @override
  String get mealId => (origin as MealGetProvider).mealId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
