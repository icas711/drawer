// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$canvasMaxSizeHash() => r'f30d6d6d2aed62e8736019283114fed26cff6d15';

/// See also [canvasMaxSize].
@ProviderFor(canvasMaxSize)
final canvasMaxSizeProvider = AutoDisposeProvider<Rect>.internal(
  canvasMaxSize,
  name: r'canvasMaxSizeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$canvasMaxSizeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CanvasMaxSizeRef = AutoDisposeProviderRef<Rect>;
String _$toLocalHash() => r'c39b8a2d6b7741c13fbf784ddf14566d107908d5';

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

/// See also [toLocal].
@ProviderFor(toLocal)
const toLocalProvider = ToLocalFamily();

/// See also [toLocal].
class ToLocalFamily extends Family<Offset> {
  /// See also [toLocal].
  const ToLocalFamily();

  /// See also [toLocal].
  ToLocalProvider call(
    Offset global,
  ) {
    return ToLocalProvider(
      global,
    );
  }

  @override
  ToLocalProvider getProviderOverride(
    covariant ToLocalProvider provider,
  ) {
    return call(
      provider.global,
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
  String? get name => r'toLocalProvider';
}

/// See also [toLocal].
class ToLocalProvider extends AutoDisposeProvider<Offset> {
  /// See also [toLocal].
  ToLocalProvider(
    Offset global,
  ) : this._internal(
          (ref) => toLocal(
            ref as ToLocalRef,
            global,
          ),
          from: toLocalProvider,
          name: r'toLocalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$toLocalHash,
          dependencies: ToLocalFamily._dependencies,
          allTransitiveDependencies: ToLocalFamily._allTransitiveDependencies,
          global: global,
        );

  ToLocalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.global,
  }) : super.internal();

  final Offset global;

  @override
  Override overrideWith(
    Offset Function(ToLocalRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ToLocalProvider._internal(
        (ref) => create(ref as ToLocalRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        global: global,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Offset> createElement() {
    return _ToLocalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ToLocalProvider && other.global == global;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, global.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ToLocalRef on AutoDisposeProviderRef<Offset> {
  /// The parameter `global` of this provider.
  Offset get global;
}

class _ToLocalProviderElement extends AutoDisposeProviderElement<Offset>
    with ToLocalRef {
  _ToLocalProviderElement(super.provider);

  @override
  Offset get global => (origin as ToLocalProvider).global;
}

String _$panHash() => r'4819c8be4274cae6ea337558071d273c6f6ea22c';

/// See also [pan].
@ProviderFor(pan)
const panProvider = PanFamily();

/// See also [pan].
class PanFamily extends Family<void> {
  /// See also [pan].
  const PanFamily();

  /// See also [pan].
  PanProvider call(
    Offset delta,
  ) {
    return PanProvider(
      delta,
    );
  }

  @override
  PanProvider getProviderOverride(
    covariant PanProvider provider,
  ) {
    return call(
      provider.delta,
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
  String? get name => r'panProvider';
}

/// See also [pan].
class PanProvider extends AutoDisposeProvider<void> {
  /// See also [pan].
  PanProvider(
    Offset delta,
  ) : this._internal(
          (ref) => pan(
            ref as PanRef,
            delta,
          ),
          from: panProvider,
          name: r'panProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$panHash,
          dependencies: PanFamily._dependencies,
          allTransitiveDependencies: PanFamily._allTransitiveDependencies,
          delta: delta,
        );

  PanProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.delta,
  }) : super.internal();

  final Offset delta;

  @override
  Override overrideWith(
    void Function(PanRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PanProvider._internal(
        (ref) => create(ref as PanRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        delta: delta,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<void> createElement() {
    return _PanProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PanProvider && other.delta == delta;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, delta.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PanRef on AutoDisposeProviderRef<void> {
  /// The parameter `delta` of this provider.
  Offset get delta;
}

class _PanProviderElement extends AutoDisposeProviderElement<void> with PanRef {
  _PanProviderElement(super.provider);

  @override
  Offset get delta => (origin as PanProvider).delta;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
