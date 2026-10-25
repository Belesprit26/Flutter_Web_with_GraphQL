// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GServicesData> _$gServicesDataSerializer =
    _$GServicesDataSerializer();
Serializer<GServicesData_services> _$gServicesDataServicesSerializer =
    _$GServicesData_servicesSerializer();
Serializer<GAvailableSlotsData> _$gAvailableSlotsDataSerializer =
    _$GAvailableSlotsDataSerializer();
Serializer<GAvailableSlotsData_availableSlots>
_$gAvailableSlotsDataAvailableSlotsSerializer =
    _$GAvailableSlotsData_availableSlotsSerializer();
Serializer<GPaymentMethodsData> _$gPaymentMethodsDataSerializer =
    _$GPaymentMethodsDataSerializer();
Serializer<GPaymentMethodsData_paymentMethods>
_$gPaymentMethodsDataPaymentMethodsSerializer =
    _$GPaymentMethodsData_paymentMethodsSerializer();

class _$GServicesDataSerializer implements StructuredSerializer<GServicesData> {
  @override
  final Iterable<Type> types = const [GServicesData, _$GServicesData];
  @override
  final String wireName = 'GServicesData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GServicesData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'services',
      serializers.serialize(
        object.services,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GServicesData_services),
        ]),
      ),
    ];

    return result;
  }

  @override
  GServicesData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GServicesDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'services':
          result.services.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GServicesData_services),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GServicesData_servicesSerializer
    implements StructuredSerializer<GServicesData_services> {
  @override
  final Iterable<Type> types = const [
    GServicesData_services,
    _$GServicesData_services,
  ];
  @override
  final String wireName = 'GServicesData_services';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GServicesData_services object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'description',
      serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      ),
      'priceCents',
      serializers.serialize(
        object.priceCents,
        specifiedType: const FullType(int),
      ),
      'durationMinutes',
      serializers.serialize(
        object.durationMinutes,
        specifiedType: const FullType(int),
      ),
    ];

    return result;
  }

  @override
  GServicesData_services deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GServicesData_servicesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'name':
          result.name =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'priceCents':
          result.priceCents =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'durationMinutes':
          result.durationMinutes =
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

class _$GAvailableSlotsDataSerializer
    implements StructuredSerializer<GAvailableSlotsData> {
  @override
  final Iterable<Type> types = const [
    GAvailableSlotsData,
    _$GAvailableSlotsData,
  ];
  @override
  final String wireName = 'GAvailableSlotsData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GAvailableSlotsData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'availableSlots',
      serializers.serialize(
        object.availableSlots,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GAvailableSlotsData_availableSlots),
        ]),
      ),
    ];

    return result;
  }

  @override
  GAvailableSlotsData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GAvailableSlotsDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'availableSlots':
          result.availableSlots.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GAvailableSlotsData_availableSlots),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GAvailableSlotsData_availableSlotsSerializer
    implements StructuredSerializer<GAvailableSlotsData_availableSlots> {
  @override
  final Iterable<Type> types = const [
    GAvailableSlotsData_availableSlots,
    _$GAvailableSlotsData_availableSlots,
  ];
  @override
  final String wireName = 'GAvailableSlotsData_availableSlots';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GAvailableSlotsData_availableSlots object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'startsAt',
      serializers.serialize(
        object.startsAt,
        specifiedType: const FullType(String),
      ),
      'endsAt',
      serializers.serialize(
        object.endsAt,
        specifiedType: const FullType(String),
      ),
      'available',
      serializers.serialize(
        object.available,
        specifiedType: const FullType(bool),
      ),
    ];

    return result;
  }

  @override
  GAvailableSlotsData_availableSlots deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GAvailableSlotsData_availableSlotsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'startsAt':
          result.startsAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'endsAt':
          result.endsAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'available':
          result.available =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GPaymentMethodsDataSerializer
    implements StructuredSerializer<GPaymentMethodsData> {
  @override
  final Iterable<Type> types = const [
    GPaymentMethodsData,
    _$GPaymentMethodsData,
  ];
  @override
  final String wireName = 'GPaymentMethodsData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GPaymentMethodsData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'paymentMethods',
      serializers.serialize(
        object.paymentMethods,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GPaymentMethodsData_paymentMethods),
        ]),
      ),
    ];

    return result;
  }

  @override
  GPaymentMethodsData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GPaymentMethodsDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'paymentMethods':
          result.paymentMethods.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GPaymentMethodsData_paymentMethods),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GPaymentMethodsData_paymentMethodsSerializer
    implements StructuredSerializer<GPaymentMethodsData_paymentMethods> {
  @override
  final Iterable<Type> types = const [
    GPaymentMethodsData_paymentMethods,
    _$GPaymentMethodsData_paymentMethods,
  ];
  @override
  final String wireName = 'GPaymentMethodsData_paymentMethods';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GPaymentMethodsData_paymentMethods object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'brand',
      serializers.serialize(
        object.brand,
        specifiedType: const FullType(_i2.GCardBrand),
      ),
      'last4',
      serializers.serialize(
        object.last4,
        specifiedType: const FullType(String),
      ),
      'expiryMonth',
      serializers.serialize(
        object.expiryMonth,
        specifiedType: const FullType(int),
      ),
      'expiryYear',
      serializers.serialize(
        object.expiryYear,
        specifiedType: const FullType(int),
      ),
      'label',
      serializers.serialize(
        object.label,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  GPaymentMethodsData_paymentMethods deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GPaymentMethodsData_paymentMethodsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'brand':
          result.brand =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GCardBrand),
                  )!
                  as _i2.GCardBrand;
          break;
        case 'last4':
          result.last4 =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'expiryMonth':
          result.expiryMonth =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'expiryYear':
          result.expiryYear =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'label':
          result.label =
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

class _$GServicesData extends GServicesData {
  @override
  final String G__typename;
  @override
  final BuiltList<GServicesData_services> services;

  factory _$GServicesData([void Function(GServicesDataBuilder)? updates]) =>
      (GServicesDataBuilder()..update(updates))._build();

  _$GServicesData._({required this.G__typename, required this.services})
    : super._();
  @override
  GServicesData rebuild(void Function(GServicesDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GServicesDataBuilder toBuilder() => GServicesDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GServicesData &&
        G__typename == other.G__typename &&
        services == other.services;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, services.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GServicesData')
          ..add('G__typename', G__typename)
          ..add('services', services))
        .toString();
  }
}

class GServicesDataBuilder
    implements Builder<GServicesData, GServicesDataBuilder> {
  _$GServicesData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GServicesData_services>? _services;
  ListBuilder<GServicesData_services> get services =>
      _$this._services ??= ListBuilder<GServicesData_services>();
  set services(ListBuilder<GServicesData_services>? services) =>
      _$this._services = services;

  GServicesDataBuilder() {
    GServicesData._initializeBuilder(this);
  }

  GServicesDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _services = $v.services.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GServicesData other) {
    _$v = other as _$GServicesData;
  }

  @override
  void update(void Function(GServicesDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GServicesData build() => _build();

  _$GServicesData _build() {
    _$GServicesData _$result;
    try {
      _$result =
          _$v ??
          _$GServicesData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GServicesData',
              'G__typename',
            ),
            services: services.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'services';
        services.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GServicesData',
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

class _$GServicesData_services extends GServicesData_services {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final int priceCents;
  @override
  final int durationMinutes;

  factory _$GServicesData_services([
    void Function(GServicesData_servicesBuilder)? updates,
  ]) => (GServicesData_servicesBuilder()..update(updates))._build();

  _$GServicesData_services._({
    required this.G__typename,
    required this.id,
    required this.name,
    required this.description,
    required this.priceCents,
    required this.durationMinutes,
  }) : super._();
  @override
  GServicesData_services rebuild(
    void Function(GServicesData_servicesBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GServicesData_servicesBuilder toBuilder() =>
      GServicesData_servicesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GServicesData_services &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        priceCents == other.priceCents &&
        durationMinutes == other.durationMinutes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, priceCents.hashCode);
    _$hash = $jc(_$hash, durationMinutes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GServicesData_services')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('priceCents', priceCents)
          ..add('durationMinutes', durationMinutes))
        .toString();
  }
}

class GServicesData_servicesBuilder
    implements Builder<GServicesData_services, GServicesData_servicesBuilder> {
  _$GServicesData_services? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _priceCents;
  int? get priceCents => _$this._priceCents;
  set priceCents(int? priceCents) => _$this._priceCents = priceCents;

  int? _durationMinutes;
  int? get durationMinutes => _$this._durationMinutes;
  set durationMinutes(int? durationMinutes) =>
      _$this._durationMinutes = durationMinutes;

  GServicesData_servicesBuilder() {
    GServicesData_services._initializeBuilder(this);
  }

  GServicesData_servicesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _priceCents = $v.priceCents;
      _durationMinutes = $v.durationMinutes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GServicesData_services other) {
    _$v = other as _$GServicesData_services;
  }

  @override
  void update(void Function(GServicesData_servicesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GServicesData_services build() => _build();

  _$GServicesData_services _build() {
    final _$result =
        _$v ??
        _$GServicesData_services._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GServicesData_services',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GServicesData_services',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GServicesData_services',
            'name',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'GServicesData_services',
            'description',
          ),
          priceCents: BuiltValueNullFieldError.checkNotNull(
            priceCents,
            r'GServicesData_services',
            'priceCents',
          ),
          durationMinutes: BuiltValueNullFieldError.checkNotNull(
            durationMinutes,
            r'GServicesData_services',
            'durationMinutes',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GAvailableSlotsData extends GAvailableSlotsData {
  @override
  final String G__typename;
  @override
  final BuiltList<GAvailableSlotsData_availableSlots> availableSlots;

  factory _$GAvailableSlotsData([
    void Function(GAvailableSlotsDataBuilder)? updates,
  ]) => (GAvailableSlotsDataBuilder()..update(updates))._build();

  _$GAvailableSlotsData._({
    required this.G__typename,
    required this.availableSlots,
  }) : super._();
  @override
  GAvailableSlotsData rebuild(
    void Function(GAvailableSlotsDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GAvailableSlotsDataBuilder toBuilder() =>
      GAvailableSlotsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAvailableSlotsData &&
        G__typename == other.G__typename &&
        availableSlots == other.availableSlots;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, availableSlots.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAvailableSlotsData')
          ..add('G__typename', G__typename)
          ..add('availableSlots', availableSlots))
        .toString();
  }
}

class GAvailableSlotsDataBuilder
    implements Builder<GAvailableSlotsData, GAvailableSlotsDataBuilder> {
  _$GAvailableSlotsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GAvailableSlotsData_availableSlots>? _availableSlots;
  ListBuilder<GAvailableSlotsData_availableSlots> get availableSlots =>
      _$this._availableSlots ??=
          ListBuilder<GAvailableSlotsData_availableSlots>();
  set availableSlots(
    ListBuilder<GAvailableSlotsData_availableSlots>? availableSlots,
  ) => _$this._availableSlots = availableSlots;

  GAvailableSlotsDataBuilder() {
    GAvailableSlotsData._initializeBuilder(this);
  }

  GAvailableSlotsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _availableSlots = $v.availableSlots.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAvailableSlotsData other) {
    _$v = other as _$GAvailableSlotsData;
  }

  @override
  void update(void Function(GAvailableSlotsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAvailableSlotsData build() => _build();

  _$GAvailableSlotsData _build() {
    _$GAvailableSlotsData _$result;
    try {
      _$result =
          _$v ??
          _$GAvailableSlotsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GAvailableSlotsData',
              'G__typename',
            ),
            availableSlots: availableSlots.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'availableSlots';
        availableSlots.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GAvailableSlotsData',
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

class _$GAvailableSlotsData_availableSlots
    extends GAvailableSlotsData_availableSlots {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String startsAt;
  @override
  final String endsAt;
  @override
  final bool available;

  factory _$GAvailableSlotsData_availableSlots([
    void Function(GAvailableSlotsData_availableSlotsBuilder)? updates,
  ]) => (GAvailableSlotsData_availableSlotsBuilder()..update(updates))._build();

  _$GAvailableSlotsData_availableSlots._({
    required this.G__typename,
    required this.id,
    required this.startsAt,
    required this.endsAt,
    required this.available,
  }) : super._();
  @override
  GAvailableSlotsData_availableSlots rebuild(
    void Function(GAvailableSlotsData_availableSlotsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GAvailableSlotsData_availableSlotsBuilder toBuilder() =>
      GAvailableSlotsData_availableSlotsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAvailableSlotsData_availableSlots &&
        G__typename == other.G__typename &&
        id == other.id &&
        startsAt == other.startsAt &&
        endsAt == other.endsAt &&
        available == other.available;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, startsAt.hashCode);
    _$hash = $jc(_$hash, endsAt.hashCode);
    _$hash = $jc(_$hash, available.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAvailableSlotsData_availableSlots')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('startsAt', startsAt)
          ..add('endsAt', endsAt)
          ..add('available', available))
        .toString();
  }
}

class GAvailableSlotsData_availableSlotsBuilder
    implements
        Builder<
          GAvailableSlotsData_availableSlots,
          GAvailableSlotsData_availableSlotsBuilder
        > {
  _$GAvailableSlotsData_availableSlots? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _startsAt;
  String? get startsAt => _$this._startsAt;
  set startsAt(String? startsAt) => _$this._startsAt = startsAt;

  String? _endsAt;
  String? get endsAt => _$this._endsAt;
  set endsAt(String? endsAt) => _$this._endsAt = endsAt;

  bool? _available;
  bool? get available => _$this._available;
  set available(bool? available) => _$this._available = available;

  GAvailableSlotsData_availableSlotsBuilder() {
    GAvailableSlotsData_availableSlots._initializeBuilder(this);
  }

  GAvailableSlotsData_availableSlotsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _startsAt = $v.startsAt;
      _endsAt = $v.endsAt;
      _available = $v.available;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAvailableSlotsData_availableSlots other) {
    _$v = other as _$GAvailableSlotsData_availableSlots;
  }

  @override
  void update(
    void Function(GAvailableSlotsData_availableSlotsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GAvailableSlotsData_availableSlots build() => _build();

  _$GAvailableSlotsData_availableSlots _build() {
    final _$result =
        _$v ??
        _$GAvailableSlotsData_availableSlots._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GAvailableSlotsData_availableSlots',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GAvailableSlotsData_availableSlots',
            'id',
          ),
          startsAt: BuiltValueNullFieldError.checkNotNull(
            startsAt,
            r'GAvailableSlotsData_availableSlots',
            'startsAt',
          ),
          endsAt: BuiltValueNullFieldError.checkNotNull(
            endsAt,
            r'GAvailableSlotsData_availableSlots',
            'endsAt',
          ),
          available: BuiltValueNullFieldError.checkNotNull(
            available,
            r'GAvailableSlotsData_availableSlots',
            'available',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GPaymentMethodsData extends GPaymentMethodsData {
  @override
  final String G__typename;
  @override
  final BuiltList<GPaymentMethodsData_paymentMethods> paymentMethods;

  factory _$GPaymentMethodsData([
    void Function(GPaymentMethodsDataBuilder)? updates,
  ]) => (GPaymentMethodsDataBuilder()..update(updates))._build();

  _$GPaymentMethodsData._({
    required this.G__typename,
    required this.paymentMethods,
  }) : super._();
  @override
  GPaymentMethodsData rebuild(
    void Function(GPaymentMethodsDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GPaymentMethodsDataBuilder toBuilder() =>
      GPaymentMethodsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPaymentMethodsData &&
        G__typename == other.G__typename &&
        paymentMethods == other.paymentMethods;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, paymentMethods.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPaymentMethodsData')
          ..add('G__typename', G__typename)
          ..add('paymentMethods', paymentMethods))
        .toString();
  }
}

class GPaymentMethodsDataBuilder
    implements Builder<GPaymentMethodsData, GPaymentMethodsDataBuilder> {
  _$GPaymentMethodsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GPaymentMethodsData_paymentMethods>? _paymentMethods;
  ListBuilder<GPaymentMethodsData_paymentMethods> get paymentMethods =>
      _$this._paymentMethods ??=
          ListBuilder<GPaymentMethodsData_paymentMethods>();
  set paymentMethods(
    ListBuilder<GPaymentMethodsData_paymentMethods>? paymentMethods,
  ) => _$this._paymentMethods = paymentMethods;

  GPaymentMethodsDataBuilder() {
    GPaymentMethodsData._initializeBuilder(this);
  }

  GPaymentMethodsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _paymentMethods = $v.paymentMethods.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPaymentMethodsData other) {
    _$v = other as _$GPaymentMethodsData;
  }

  @override
  void update(void Function(GPaymentMethodsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPaymentMethodsData build() => _build();

  _$GPaymentMethodsData _build() {
    _$GPaymentMethodsData _$result;
    try {
      _$result =
          _$v ??
          _$GPaymentMethodsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GPaymentMethodsData',
              'G__typename',
            ),
            paymentMethods: paymentMethods.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'paymentMethods';
        paymentMethods.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GPaymentMethodsData',
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

class _$GPaymentMethodsData_paymentMethods
    extends GPaymentMethodsData_paymentMethods {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GCardBrand brand;
  @override
  final String last4;
  @override
  final int expiryMonth;
  @override
  final int expiryYear;
  @override
  final String label;

  factory _$GPaymentMethodsData_paymentMethods([
    void Function(GPaymentMethodsData_paymentMethodsBuilder)? updates,
  ]) => (GPaymentMethodsData_paymentMethodsBuilder()..update(updates))._build();

  _$GPaymentMethodsData_paymentMethods._({
    required this.G__typename,
    required this.id,
    required this.brand,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    required this.label,
  }) : super._();
  @override
  GPaymentMethodsData_paymentMethods rebuild(
    void Function(GPaymentMethodsData_paymentMethodsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GPaymentMethodsData_paymentMethodsBuilder toBuilder() =>
      GPaymentMethodsData_paymentMethodsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPaymentMethodsData_paymentMethods &&
        G__typename == other.G__typename &&
        id == other.id &&
        brand == other.brand &&
        last4 == other.last4 &&
        expiryMonth == other.expiryMonth &&
        expiryYear == other.expiryYear &&
        label == other.label;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, last4.hashCode);
    _$hash = $jc(_$hash, expiryMonth.hashCode);
    _$hash = $jc(_$hash, expiryYear.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPaymentMethodsData_paymentMethods')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('brand', brand)
          ..add('last4', last4)
          ..add('expiryMonth', expiryMonth)
          ..add('expiryYear', expiryYear)
          ..add('label', label))
        .toString();
  }
}

class GPaymentMethodsData_paymentMethodsBuilder
    implements
        Builder<
          GPaymentMethodsData_paymentMethods,
          GPaymentMethodsData_paymentMethodsBuilder
        > {
  _$GPaymentMethodsData_paymentMethods? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GCardBrand? _brand;
  _i2.GCardBrand? get brand => _$this._brand;
  set brand(_i2.GCardBrand? brand) => _$this._brand = brand;

  String? _last4;
  String? get last4 => _$this._last4;
  set last4(String? last4) => _$this._last4 = last4;

  int? _expiryMonth;
  int? get expiryMonth => _$this._expiryMonth;
  set expiryMonth(int? expiryMonth) => _$this._expiryMonth = expiryMonth;

  int? _expiryYear;
  int? get expiryYear => _$this._expiryYear;
  set expiryYear(int? expiryYear) => _$this._expiryYear = expiryYear;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  GPaymentMethodsData_paymentMethodsBuilder() {
    GPaymentMethodsData_paymentMethods._initializeBuilder(this);
  }

  GPaymentMethodsData_paymentMethodsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _brand = $v.brand;
      _last4 = $v.last4;
      _expiryMonth = $v.expiryMonth;
      _expiryYear = $v.expiryYear;
      _label = $v.label;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPaymentMethodsData_paymentMethods other) {
    _$v = other as _$GPaymentMethodsData_paymentMethods;
  }

  @override
  void update(
    void Function(GPaymentMethodsData_paymentMethodsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GPaymentMethodsData_paymentMethods build() => _build();

  _$GPaymentMethodsData_paymentMethods _build() {
    final _$result =
        _$v ??
        _$GPaymentMethodsData_paymentMethods._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GPaymentMethodsData_paymentMethods',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GPaymentMethodsData_paymentMethods',
            'id',
          ),
          brand: BuiltValueNullFieldError.checkNotNull(
            brand,
            r'GPaymentMethodsData_paymentMethods',
            'brand',
          ),
          last4: BuiltValueNullFieldError.checkNotNull(
            last4,
            r'GPaymentMethodsData_paymentMethods',
            'last4',
          ),
          expiryMonth: BuiltValueNullFieldError.checkNotNull(
            expiryMonth,
            r'GPaymentMethodsData_paymentMethods',
            'expiryMonth',
          ),
          expiryYear: BuiltValueNullFieldError.checkNotNull(
            expiryYear,
            r'GPaymentMethodsData_paymentMethods',
            'expiryYear',
          ),
          label: BuiltValueNullFieldError.checkNotNull(
            label,
            r'GPaymentMethodsData_paymentMethods',
            'label',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
