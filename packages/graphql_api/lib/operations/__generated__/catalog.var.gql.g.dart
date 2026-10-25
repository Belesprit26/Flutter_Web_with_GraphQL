// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GServicesVars> _$gServicesVarsSerializer =
    _$GServicesVarsSerializer();
Serializer<GAvailableSlotsVars> _$gAvailableSlotsVarsSerializer =
    _$GAvailableSlotsVarsSerializer();
Serializer<GPaymentMethodsVars> _$gPaymentMethodsVarsSerializer =
    _$GPaymentMethodsVarsSerializer();

class _$GServicesVarsSerializer implements StructuredSerializer<GServicesVars> {
  @override
  final Iterable<Type> types = const [GServicesVars, _$GServicesVars];
  @override
  final String wireName = 'GServicesVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GServicesVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return <Object?>[];
  }

  @override
  GServicesVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return GServicesVarsBuilder().build();
  }
}

class _$GAvailableSlotsVarsSerializer
    implements StructuredSerializer<GAvailableSlotsVars> {
  @override
  final Iterable<Type> types = const [
    GAvailableSlotsVars,
    _$GAvailableSlotsVars,
  ];
  @override
  final String wireName = 'GAvailableSlotsVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GAvailableSlotsVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'days',
      serializers.serialize(object.days, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GAvailableSlotsVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GAvailableSlotsVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'days':
          result.days =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GPaymentMethodsVarsSerializer
    implements StructuredSerializer<GPaymentMethodsVars> {
  @override
  final Iterable<Type> types = const [
    GPaymentMethodsVars,
    _$GPaymentMethodsVars,
  ];
  @override
  final String wireName = 'GPaymentMethodsVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GPaymentMethodsVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return <Object?>[];
  }

  @override
  GPaymentMethodsVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return GPaymentMethodsVarsBuilder().build();
  }
}

class _$GServicesVars extends GServicesVars {
  factory _$GServicesVars([void Function(GServicesVarsBuilder)? updates]) =>
      (GServicesVarsBuilder()..update(updates))._build();

  _$GServicesVars._() : super._();
  @override
  GServicesVars rebuild(void Function(GServicesVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GServicesVarsBuilder toBuilder() => GServicesVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GServicesVars;
  }

  @override
  int get hashCode {
    return 771551673;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GServicesVars').toString();
  }
}

class GServicesVarsBuilder
    implements Builder<GServicesVars, GServicesVarsBuilder> {
  _$GServicesVars? _$v;

  GServicesVarsBuilder();

  @override
  void replace(GServicesVars other) {
    _$v = other as _$GServicesVars;
  }

  @override
  void update(void Function(GServicesVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GServicesVars build() => _build();

  _$GServicesVars _build() {
    final _$result = _$v ?? _$GServicesVars._();
    replace(_$result);
    return _$result;
  }
}

class _$GAvailableSlotsVars extends GAvailableSlotsVars {
  @override
  final int days;

  factory _$GAvailableSlotsVars([
    void Function(GAvailableSlotsVarsBuilder)? updates,
  ]) => (GAvailableSlotsVarsBuilder()..update(updates))._build();

  _$GAvailableSlotsVars._({required this.days}) : super._();
  @override
  GAvailableSlotsVars rebuild(
    void Function(GAvailableSlotsVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GAvailableSlotsVarsBuilder toBuilder() =>
      GAvailableSlotsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAvailableSlotsVars && days == other.days;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, days.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GAvailableSlotsVars',
    )..add('days', days)).toString();
  }
}

class GAvailableSlotsVarsBuilder
    implements Builder<GAvailableSlotsVars, GAvailableSlotsVarsBuilder> {
  _$GAvailableSlotsVars? _$v;

  int? _days;
  int? get days => _$this._days;
  set days(int? days) => _$this._days = days;

  GAvailableSlotsVarsBuilder();

  GAvailableSlotsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _days = $v.days;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAvailableSlotsVars other) {
    _$v = other as _$GAvailableSlotsVars;
  }

  @override
  void update(void Function(GAvailableSlotsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAvailableSlotsVars build() => _build();

  _$GAvailableSlotsVars _build() {
    final _$result =
        _$v ??
        _$GAvailableSlotsVars._(
          days: BuiltValueNullFieldError.checkNotNull(
            days,
            r'GAvailableSlotsVars',
            'days',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPaymentMethodsVars extends GPaymentMethodsVars {
  factory _$GPaymentMethodsVars([
    void Function(GPaymentMethodsVarsBuilder)? updates,
  ]) => (GPaymentMethodsVarsBuilder()..update(updates))._build();

  _$GPaymentMethodsVars._() : super._();
  @override
  GPaymentMethodsVars rebuild(
    void Function(GPaymentMethodsVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GPaymentMethodsVarsBuilder toBuilder() =>
      GPaymentMethodsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPaymentMethodsVars;
  }

  @override
  int get hashCode {
    return 748106685;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GPaymentMethodsVars').toString();
  }
}

class GPaymentMethodsVarsBuilder
    implements Builder<GPaymentMethodsVars, GPaymentMethodsVarsBuilder> {
  _$GPaymentMethodsVars? _$v;

  GPaymentMethodsVarsBuilder();

  @override
  void replace(GPaymentMethodsVars other) {
    _$v = other as _$GPaymentMethodsVars;
  }

  @override
  void update(void Function(GPaymentMethodsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPaymentMethodsVars build() => _build();

  _$GPaymentMethodsVars _build() {
    final _$result = _$v ?? _$GPaymentMethodsVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
