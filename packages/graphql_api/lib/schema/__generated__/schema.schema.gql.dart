// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:graphql_api/schema/__generated__/serializers.gql.dart' as _i1;

part 'schema.schema.gql.g.dart';

class GCardBrand extends EnumClass {
  const GCardBrand._(String name) : super(name);

  static const GCardBrand VISA = _$gCardBrandVISA;

  static const GCardBrand MASTERCARD = _$gCardBrandMASTERCARD;

  static Serializer<GCardBrand> get serializer => _$gCardBrandSerializer;

  static BuiltSet<GCardBrand> get values => _$gCardBrandValues;

  static GCardBrand valueOf(String name) => _$gCardBrandValueOf(name);
}

abstract class GCreateOrderInput
    implements Built<GCreateOrderInput, GCreateOrderInputBuilder> {
  GCreateOrderInput._();

  factory GCreateOrderInput(
          [void Function(GCreateOrderInputBuilder b) updates]) =
      _$GCreateOrderInput;

  String get idempotencyKey;
  BuiltList<String> get serviceIds;
  String get slotId;
  String get paymentMethodId;
  static Serializer<GCreateOrderInput> get serializer =>
      _$gCreateOrderInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateOrderInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateOrderInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateOrderInput.serializer,
        json,
      );
}

class GOrderStatus extends EnumClass {
  const GOrderStatus._(String name) : super(name);

  static const GOrderStatus HOLD_PENDING = _$gOrderStatusHOLD_PENDING;

  static const GOrderStatus HOLD_PLACED = _$gOrderStatusHOLD_PLACED;

  static const GOrderStatus HOLD_FAILED = _$gOrderStatusHOLD_FAILED;

  static Serializer<GOrderStatus> get serializer => _$gOrderStatusSerializer;

  static BuiltSet<GOrderStatus> get values => _$gOrderStatusValues;

  static GOrderStatus valueOf(String name) => _$gOrderStatusValueOf(name);
}

class GOrderEventType extends EnumClass {
  const GOrderEventType._(String name) : super(name);

  static const GOrderEventType CREATED = _$gOrderEventTypeCREATED;

  static const GOrderEventType HOLD_REQUESTED = _$gOrderEventTypeHOLD_REQUESTED;

  static const GOrderEventType HOLD_PLACED = _$gOrderEventTypeHOLD_PLACED;

  static const GOrderEventType HOLD_FAILED = _$gOrderEventTypeHOLD_FAILED;

  static Serializer<GOrderEventType> get serializer =>
      _$gOrderEventTypeSerializer;

  static BuiltSet<GOrderEventType> get values => _$gOrderEventTypeValues;

  static GOrderEventType valueOf(String name) => _$gOrderEventTypeValueOf(name);
}

const Map<String, Set<String>> possibleTypesMap = {};
