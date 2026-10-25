// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.schema.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GCardBrand _$gCardBrandVISA = const GCardBrand._('VISA');
const GCardBrand _$gCardBrandMASTERCARD = const GCardBrand._('MASTERCARD');

GCardBrand _$gCardBrandValueOf(String name) {
  switch (name) {
    case 'VISA':
      return _$gCardBrandVISA;
    case 'MASTERCARD':
      return _$gCardBrandMASTERCARD;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GCardBrand> _$gCardBrandValues = BuiltSet<GCardBrand>(
  const <GCardBrand>[_$gCardBrandVISA, _$gCardBrandMASTERCARD],
);

const GOrderStatus _$gOrderStatusHOLD_PENDING = const GOrderStatus._(
  'HOLD_PENDING',
);
const GOrderStatus _$gOrderStatusHOLD_PLACED = const GOrderStatus._(
  'HOLD_PLACED',
);
const GOrderStatus _$gOrderStatusHOLD_FAILED = const GOrderStatus._(
  'HOLD_FAILED',
);

GOrderStatus _$gOrderStatusValueOf(String name) {
  switch (name) {
    case 'HOLD_PENDING':
      return _$gOrderStatusHOLD_PENDING;
    case 'HOLD_PLACED':
      return _$gOrderStatusHOLD_PLACED;
    case 'HOLD_FAILED':
      return _$gOrderStatusHOLD_FAILED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GOrderStatus> _$gOrderStatusValues = BuiltSet<GOrderStatus>(
  const <GOrderStatus>[
    _$gOrderStatusHOLD_PENDING,
    _$gOrderStatusHOLD_PLACED,
    _$gOrderStatusHOLD_FAILED,
  ],
);

const GOrderEventType _$gOrderEventTypeCREATED = const GOrderEventType._(
  'CREATED',
);
const GOrderEventType _$gOrderEventTypeHOLD_REQUESTED = const GOrderEventType._(
  'HOLD_REQUESTED',
);
const GOrderEventType _$gOrderEventTypeHOLD_PLACED = const GOrderEventType._(
  'HOLD_PLACED',
);
const GOrderEventType _$gOrderEventTypeHOLD_FAILED = const GOrderEventType._(
  'HOLD_FAILED',
);

GOrderEventType _$gOrderEventTypeValueOf(String name) {
  switch (name) {
    case 'CREATED':
      return _$gOrderEventTypeCREATED;
    case 'HOLD_REQUESTED':
      return _$gOrderEventTypeHOLD_REQUESTED;
    case 'HOLD_PLACED':
      return _$gOrderEventTypeHOLD_PLACED;
    case 'HOLD_FAILED':
      return _$gOrderEventTypeHOLD_FAILED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GOrderEventType> _$gOrderEventTypeValues =
    BuiltSet<GOrderEventType>(const <GOrderEventType>[
      _$gOrderEventTypeCREATED,
      _$gOrderEventTypeHOLD_REQUESTED,
      _$gOrderEventTypeHOLD_PLACED,
      _$gOrderEventTypeHOLD_FAILED,
    ]);

Serializer<GCardBrand> _$gCardBrandSerializer = _$GCardBrandSerializer();
Serializer<GCreateOrderInput> _$gCreateOrderInputSerializer =
    _$GCreateOrderInputSerializer();
Serializer<GOrderStatus> _$gOrderStatusSerializer = _$GOrderStatusSerializer();
Serializer<GOrderEventType> _$gOrderEventTypeSerializer =
    _$GOrderEventTypeSerializer();

class _$GCardBrandSerializer implements PrimitiveSerializer<GCardBrand> {
  @override
  final Iterable<Type> types = const <Type>[GCardBrand];
  @override
  final String wireName = 'GCardBrand';

  @override
  Object serialize(
    Serializers serializers,
    GCardBrand object, {
    FullType specifiedType = FullType.unspecified,
  }) => object.name;

  @override
  GCardBrand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GCardBrand.valueOf(serialized as String);
}

class _$GCreateOrderInputSerializer
    implements StructuredSerializer<GCreateOrderInput> {
  @override
  final Iterable<Type> types = const [GCreateOrderInput, _$GCreateOrderInput];
  @override
  final String wireName = 'GCreateOrderInput';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateOrderInput object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'idempotencyKey',
      serializers.serialize(
        object.idempotencyKey,
        specifiedType: const FullType(String),
      ),
      'serviceIds',
      serializers.serialize(
        object.serviceIds,
        specifiedType: const FullType(BuiltList, const [
          const FullType(String),
        ]),
      ),
      'slotId',
      serializers.serialize(
        object.slotId,
        specifiedType: const FullType(String),
      ),
      'paymentMethodId',
      serializers.serialize(
        object.paymentMethodId,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  GCreateOrderInput deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateOrderInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'idempotencyKey':
          result.idempotencyKey =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'serviceIds':
          result.serviceIds.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(String),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'slotId':
          result.slotId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'paymentMethodId':
          result.paymentMethodId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GOrderStatusSerializer implements PrimitiveSerializer<GOrderStatus> {
  @override
  final Iterable<Type> types = const <Type>[GOrderStatus];
  @override
  final String wireName = 'GOrderStatus';

  @override
  Object serialize(
    Serializers serializers,
    GOrderStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) => object.name;

  @override
  GOrderStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GOrderStatus.valueOf(serialized as String);
}

class _$GOrderEventTypeSerializer
    implements PrimitiveSerializer<GOrderEventType> {
  @override
  final Iterable<Type> types = const <Type>[GOrderEventType];
  @override
  final String wireName = 'GOrderEventType';

  @override
  Object serialize(
    Serializers serializers,
    GOrderEventType object, {
    FullType specifiedType = FullType.unspecified,
  }) => object.name;

  @override
  GOrderEventType deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GOrderEventType.valueOf(serialized as String);
}

class _$GCreateOrderInput extends GCreateOrderInput {
  @override
  final String idempotencyKey;
  @override
  final BuiltList<String> serviceIds;
  @override
  final String slotId;
  @override
  final String paymentMethodId;

  factory _$GCreateOrderInput([
    void Function(GCreateOrderInputBuilder)? updates,
  ]) => (GCreateOrderInputBuilder()..update(updates))._build();

  _$GCreateOrderInput._({
    required this.idempotencyKey,
    required this.serviceIds,
    required this.slotId,
    required this.paymentMethodId,
  }) : super._();
  @override
  GCreateOrderInput rebuild(void Function(GCreateOrderInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateOrderInputBuilder toBuilder() =>
      GCreateOrderInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateOrderInput &&
        idempotencyKey == other.idempotencyKey &&
        serviceIds == other.serviceIds &&
        slotId == other.slotId &&
        paymentMethodId == other.paymentMethodId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, serviceIds.hashCode);
    _$hash = $jc(_$hash, slotId.hashCode);
    _$hash = $jc(_$hash, paymentMethodId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateOrderInput')
          ..add('idempotencyKey', idempotencyKey)
          ..add('serviceIds', serviceIds)
          ..add('slotId', slotId)
          ..add('paymentMethodId', paymentMethodId))
        .toString();
  }
}

class GCreateOrderInputBuilder
    implements Builder<GCreateOrderInput, GCreateOrderInputBuilder> {
  _$GCreateOrderInput? _$v;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  ListBuilder<String>? _serviceIds;
  ListBuilder<String> get serviceIds =>
      _$this._serviceIds ??= ListBuilder<String>();
  set serviceIds(ListBuilder<String>? serviceIds) =>
      _$this._serviceIds = serviceIds;

  String? _slotId;
  String? get slotId => _$this._slotId;
  set slotId(String? slotId) => _$this._slotId = slotId;

  String? _paymentMethodId;
  String? get paymentMethodId => _$this._paymentMethodId;
  set paymentMethodId(String? paymentMethodId) =>
      _$this._paymentMethodId = paymentMethodId;

  GCreateOrderInputBuilder();

  GCreateOrderInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idempotencyKey = $v.idempotencyKey;
      _serviceIds = $v.serviceIds.toBuilder();
      _slotId = $v.slotId;
      _paymentMethodId = $v.paymentMethodId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateOrderInput other) {
    _$v = other as _$GCreateOrderInput;
  }

  @override
  void update(void Function(GCreateOrderInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateOrderInput build() => _build();

  _$GCreateOrderInput _build() {
    _$GCreateOrderInput _$result;
    try {
      _$result =
          _$v ??
          _$GCreateOrderInput._(
            idempotencyKey: BuiltValueNullFieldError.checkNotNull(
              idempotencyKey,
              r'GCreateOrderInput',
              'idempotencyKey',
            ),
            serviceIds: serviceIds.build(),
            slotId: BuiltValueNullFieldError.checkNotNull(
              slotId,
              r'GCreateOrderInput',
              'slotId',
            ),
            paymentMethodId: BuiltValueNullFieldError.checkNotNull(
              paymentMethodId,
              r'GCreateOrderInput',
              'paymentMethodId',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'serviceIds';
        serviceIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GCreateOrderInput',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
