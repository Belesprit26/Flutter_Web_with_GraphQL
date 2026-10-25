// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:graphql_api/schema/__generated__/schema.schema.gql.dart' as _i2;
import 'package:graphql_api/schema/__generated__/serializers.gql.dart' as _i1;

part 'catalog.data.gql.g.dart';

abstract class GServicesData
    implements Built<GServicesData, GServicesDataBuilder> {
  GServicesData._();

  factory GServicesData([void Function(GServicesDataBuilder b) updates]) =
      _$GServicesData;

  static void _initializeBuilder(GServicesDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GServicesData_services> get services;
  static Serializer<GServicesData> get serializer => _$gServicesDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GServicesData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GServicesData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GServicesData.serializer,
        json,
      );
}

abstract class GServicesData_services
    implements Built<GServicesData_services, GServicesData_servicesBuilder> {
  GServicesData_services._();

  factory GServicesData_services(
          [void Function(GServicesData_servicesBuilder b) updates]) =
      _$GServicesData_services;

  static void _initializeBuilder(GServicesData_servicesBuilder b) =>
      b..G__typename = 'Service';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  String get description;
  int get priceCents;
  int get durationMinutes;
  static Serializer<GServicesData_services> get serializer =>
      _$gServicesDataServicesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GServicesData_services.serializer,
        this,
      ) as Map<String, dynamic>);

  static GServicesData_services? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GServicesData_services.serializer,
        json,
      );
}

abstract class GAvailableSlotsData
    implements Built<GAvailableSlotsData, GAvailableSlotsDataBuilder> {
  GAvailableSlotsData._();

  factory GAvailableSlotsData(
          [void Function(GAvailableSlotsDataBuilder b) updates]) =
      _$GAvailableSlotsData;

  static void _initializeBuilder(GAvailableSlotsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GAvailableSlotsData_availableSlots> get availableSlots;
  static Serializer<GAvailableSlotsData> get serializer =>
      _$gAvailableSlotsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAvailableSlotsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAvailableSlotsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAvailableSlotsData.serializer,
        json,
      );
}

abstract class GAvailableSlotsData_availableSlots
    implements
        Built<GAvailableSlotsData_availableSlots,
            GAvailableSlotsData_availableSlotsBuilder> {
  GAvailableSlotsData_availableSlots._();

  factory GAvailableSlotsData_availableSlots(
      [void Function(GAvailableSlotsData_availableSlotsBuilder b)
          updates]) = _$GAvailableSlotsData_availableSlots;

  static void _initializeBuilder(GAvailableSlotsData_availableSlotsBuilder b) =>
      b..G__typename = 'Slot';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get startsAt;
  String get endsAt;
  bool get available;
  static Serializer<GAvailableSlotsData_availableSlots> get serializer =>
      _$gAvailableSlotsDataAvailableSlotsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAvailableSlotsData_availableSlots.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAvailableSlotsData_availableSlots? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAvailableSlotsData_availableSlots.serializer,
        json,
      );
}

abstract class GPaymentMethodsData
    implements Built<GPaymentMethodsData, GPaymentMethodsDataBuilder> {
  GPaymentMethodsData._();

  factory GPaymentMethodsData(
          [void Function(GPaymentMethodsDataBuilder b) updates]) =
      _$GPaymentMethodsData;

  static void _initializeBuilder(GPaymentMethodsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GPaymentMethodsData_paymentMethods> get paymentMethods;
  static Serializer<GPaymentMethodsData> get serializer =>
      _$gPaymentMethodsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPaymentMethodsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPaymentMethodsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPaymentMethodsData.serializer,
        json,
      );
}

abstract class GPaymentMethodsData_paymentMethods
    implements
        Built<GPaymentMethodsData_paymentMethods,
            GPaymentMethodsData_paymentMethodsBuilder> {
  GPaymentMethodsData_paymentMethods._();

  factory GPaymentMethodsData_paymentMethods(
      [void Function(GPaymentMethodsData_paymentMethodsBuilder b)
          updates]) = _$GPaymentMethodsData_paymentMethods;

  static void _initializeBuilder(GPaymentMethodsData_paymentMethodsBuilder b) =>
      b..G__typename = 'PaymentMethod';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  _i2.GCardBrand get brand;
  String get last4;
  int get expiryMonth;
  int get expiryYear;
  String get label;
  static Serializer<GPaymentMethodsData_paymentMethods> get serializer =>
      _$gPaymentMethodsDataPaymentMethodsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPaymentMethodsData_paymentMethods.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPaymentMethodsData_paymentMethods? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPaymentMethodsData_paymentMethods.serializer,
        json,
      );
}
