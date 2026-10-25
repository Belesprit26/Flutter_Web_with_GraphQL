// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:graphql_api/schema/__generated__/serializers.gql.dart' as _i1;

part 'catalog.var.gql.g.dart';

abstract class GServicesVars
    implements Built<GServicesVars, GServicesVarsBuilder> {
  GServicesVars._();

  factory GServicesVars([void Function(GServicesVarsBuilder b) updates]) =
      _$GServicesVars;

  static Serializer<GServicesVars> get serializer => _$gServicesVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GServicesVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GServicesVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GServicesVars.serializer,
        json,
      );
}

abstract class GAvailableSlotsVars
    implements Built<GAvailableSlotsVars, GAvailableSlotsVarsBuilder> {
  GAvailableSlotsVars._();

  factory GAvailableSlotsVars(
          [void Function(GAvailableSlotsVarsBuilder b) updates]) =
      _$GAvailableSlotsVars;

  int get days;
  static Serializer<GAvailableSlotsVars> get serializer =>
      _$gAvailableSlotsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAvailableSlotsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAvailableSlotsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAvailableSlotsVars.serializer,
        json,
      );
}

abstract class GPaymentMethodsVars
    implements Built<GPaymentMethodsVars, GPaymentMethodsVarsBuilder> {
  GPaymentMethodsVars._();

  factory GPaymentMethodsVars(
          [void Function(GPaymentMethodsVarsBuilder b) updates]) =
      _$GPaymentMethodsVars;

  static Serializer<GPaymentMethodsVars> get serializer =>
      _$gPaymentMethodsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPaymentMethodsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPaymentMethodsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPaymentMethodsVars.serializer,
        json,
      );
}
