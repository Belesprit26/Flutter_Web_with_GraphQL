// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GOrderDetailsVars> _$gOrderDetailsVarsSerializer =
    _$GOrderDetailsVarsSerializer();
Serializer<GCreateOrderVars> _$gCreateOrderVarsSerializer =
    _$GCreateOrderVarsSerializer();
Serializer<GOrderUpdatedVars> _$gOrderUpdatedVarsSerializer =
    _$GOrderUpdatedVarsSerializer();
Serializer<GOrderFieldsVars> _$gOrderFieldsVarsSerializer =
    _$GOrderFieldsVarsSerializer();

class _$GOrderDetailsVarsSerializer
    implements StructuredSerializer<GOrderDetailsVars> {
  @override
  final Iterable<Type> types = const [GOrderDetailsVars, _$GOrderDetailsVars];
  @override
  final String wireName = 'GOrderDetailsVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderDetailsVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GOrderDetailsVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderDetailsVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
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

class _$GCreateOrderVarsSerializer
    implements StructuredSerializer<GCreateOrderVars> {
  @override
  final Iterable<Type> types = const [GCreateOrderVars, _$GCreateOrderVars];
  @override
  final String wireName = 'GCreateOrderVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateOrderVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'input',
      serializers.serialize(
        object.input,
        specifiedType: const FullType(_i2.GCreateOrderInput),
      ),
    ];

    return result;
  }

  @override
  GCreateOrderVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateOrderVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GCreateOrderInput),
                )!
                as _i2.GCreateOrderInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GOrderUpdatedVarsSerializer
    implements StructuredSerializer<GOrderUpdatedVars> {
  @override
  final Iterable<Type> types = const [GOrderUpdatedVars, _$GOrderUpdatedVars];
  @override
  final String wireName = 'GOrderUpdatedVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderUpdatedVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GOrderUpdatedVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderUpdatedVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
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

class _$GOrderFieldsVarsSerializer
    implements StructuredSerializer<GOrderFieldsVars> {
  @override
  final Iterable<Type> types = const [GOrderFieldsVars, _$GOrderFieldsVars];
  @override
  final String wireName = 'GOrderFieldsVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderFieldsVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return <Object?>[];
  }

  @override
  GOrderFieldsVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return GOrderFieldsVarsBuilder().build();
  }
}

class _$GOrderDetailsVars extends GOrderDetailsVars {
  @override
  final String id;

  factory _$GOrderDetailsVars([
    void Function(GOrderDetailsVarsBuilder)? updates,
  ]) => (GOrderDetailsVarsBuilder()..update(updates))._build();

  _$GOrderDetailsVars._({required this.id}) : super._();
  @override
  GOrderDetailsVars rebuild(void Function(GOrderDetailsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GOrderDetailsVarsBuilder toBuilder() =>
      GOrderDetailsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderDetailsVars && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GOrderDetailsVars',
    )..add('id', id)).toString();
  }
}

class GOrderDetailsVarsBuilder
    implements Builder<GOrderDetailsVars, GOrderDetailsVarsBuilder> {
  _$GOrderDetailsVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GOrderDetailsVarsBuilder();

  GOrderDetailsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderDetailsVars other) {
    _$v = other as _$GOrderDetailsVars;
  }

  @override
  void update(void Function(GOrderDetailsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderDetailsVars build() => _build();

  _$GOrderDetailsVars _build() {
    final _$result =
        _$v ??
        _$GOrderDetailsVars._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GOrderDetailsVars',
            'id',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateOrderVars extends GCreateOrderVars {
  @override
  final _i2.GCreateOrderInput input;

  factory _$GCreateOrderVars([
    void Function(GCreateOrderVarsBuilder)? updates,
  ]) => (GCreateOrderVarsBuilder()..update(updates))._build();

  _$GCreateOrderVars._({required this.input}) : super._();
  @override
  GCreateOrderVars rebuild(void Function(GCreateOrderVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateOrderVarsBuilder toBuilder() =>
      GCreateOrderVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateOrderVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GCreateOrderVars',
    )..add('input', input)).toString();
  }
}

class GCreateOrderVarsBuilder
    implements Builder<GCreateOrderVars, GCreateOrderVarsBuilder> {
  _$GCreateOrderVars? _$v;

  _i2.GCreateOrderInputBuilder? _input;
  _i2.GCreateOrderInputBuilder get input =>
      _$this._input ??= _i2.GCreateOrderInputBuilder();
  set input(_i2.GCreateOrderInputBuilder? input) => _$this._input = input;

  GCreateOrderVarsBuilder();

  GCreateOrderVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateOrderVars other) {
    _$v = other as _$GCreateOrderVars;
  }

  @override
  void update(void Function(GCreateOrderVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateOrderVars build() => _build();

  _$GCreateOrderVars _build() {
    _$GCreateOrderVars _$result;
    try {
      _$result = _$v ?? _$GCreateOrderVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GCreateOrderVars',
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

class _$GOrderUpdatedVars extends GOrderUpdatedVars {
  @override
  final String id;

  factory _$GOrderUpdatedVars([
    void Function(GOrderUpdatedVarsBuilder)? updates,
  ]) => (GOrderUpdatedVarsBuilder()..update(updates))._build();

  _$GOrderUpdatedVars._({required this.id}) : super._();
  @override
  GOrderUpdatedVars rebuild(void Function(GOrderUpdatedVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GOrderUpdatedVarsBuilder toBuilder() =>
      GOrderUpdatedVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderUpdatedVars && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GOrderUpdatedVars',
    )..add('id', id)).toString();
  }
}

class GOrderUpdatedVarsBuilder
    implements Builder<GOrderUpdatedVars, GOrderUpdatedVarsBuilder> {
  _$GOrderUpdatedVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GOrderUpdatedVarsBuilder();

  GOrderUpdatedVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderUpdatedVars other) {
    _$v = other as _$GOrderUpdatedVars;
  }

  @override
  void update(void Function(GOrderUpdatedVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderUpdatedVars build() => _build();

  _$GOrderUpdatedVars _build() {
    final _$result =
        _$v ??
        _$GOrderUpdatedVars._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GOrderUpdatedVars',
            'id',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GOrderFieldsVars extends GOrderFieldsVars {
  factory _$GOrderFieldsVars([
    void Function(GOrderFieldsVarsBuilder)? updates,
  ]) => (GOrderFieldsVarsBuilder()..update(updates))._build();

  _$GOrderFieldsVars._() : super._();
  @override
  GOrderFieldsVars rebuild(void Function(GOrderFieldsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GOrderFieldsVarsBuilder toBuilder() =>
      GOrderFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderFieldsVars;
  }

  @override
  int get hashCode {
    return 781934132;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GOrderFieldsVars').toString();
  }
}

class GOrderFieldsVarsBuilder
    implements Builder<GOrderFieldsVars, GOrderFieldsVarsBuilder> {
  _$GOrderFieldsVars? _$v;

  GOrderFieldsVarsBuilder();

  @override
  void replace(GOrderFieldsVars other) {
    _$v = other as _$GOrderFieldsVars;
  }

  @override
  void update(void Function(GOrderFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderFieldsVars build() => _build();

  _$GOrderFieldsVars _build() {
    final _$result = _$v ?? _$GOrderFieldsVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
