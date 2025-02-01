// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contentDetailHash() => r'a14af2c5a74748f63432678e87718beb04659b5b';

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

abstract class _$ContentDetail
    extends BuildlessAutoDisposeAsyncNotifier<Content> {
  late final int id;

  FutureOr<Content> build(
    int id,
  );
}

/// See also [ContentDetail].
@ProviderFor(ContentDetail)
const contentDetailProvider = ContentDetailFamily();

/// See also [ContentDetail].
class ContentDetailFamily extends Family<AsyncValue<Content>> {
  /// See also [ContentDetail].
  const ContentDetailFamily();

  /// See also [ContentDetail].
  ContentDetailProvider call(
    int id,
  ) {
    return ContentDetailProvider(
      id,
    );
  }

  @override
  ContentDetailProvider getProviderOverride(
    covariant ContentDetailProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'contentDetailProvider';
}

/// See also [ContentDetail].
class ContentDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ContentDetail, Content> {
  /// See also [ContentDetail].
  ContentDetailProvider(
    int id,
  ) : this._internal(
          () => ContentDetail()..id = id,
          from: contentDetailProvider,
          name: r'contentDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$contentDetailHash,
          dependencies: ContentDetailFamily._dependencies,
          allTransitiveDependencies:
              ContentDetailFamily._allTransitiveDependencies,
          id: id,
        );

  ContentDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  FutureOr<Content> runNotifierBuild(
    covariant ContentDetail notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ContentDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: ContentDetailProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ContentDetail, Content>
      createElement() {
    return _ContentDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ContentDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ContentDetailRef on AutoDisposeAsyncNotifierProviderRef<Content> {
  /// The parameter `id` of this provider.
  int get id;
}

class _ContentDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ContentDetail, Content>
    with ContentDetailRef {
  _ContentDetailProviderElement(super.provider);

  @override
  int get id => (origin as ContentDetailProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
