// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:graphql_api/operations/__generated__/catalog.ast.gql.dart'
    as _i5;
import 'package:graphql_api/operations/__generated__/catalog.data.gql.dart'
    as _i2;
import 'package:graphql_api/operations/__generated__/catalog.var.gql.dart'
    as _i3;
import 'package:graphql_api/schema/__generated__/serializers.gql.dart' as _i6;

part 'catalog.req.gql.g.dart';

abstract class GServicesReq
    implements
        Built<GServicesReq, GServicesReqBuilder>,
        _i1.OperationRequest<_i2.GServicesData, _i3.GServicesVars> {
  GServicesReq._();

  factory GServicesReq([void Function(GServicesReqBuilder b) updates]) =
      _$GServicesReq;

  static void _initializeBuilder(GServicesReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'Services',
    )
    ..executeOnListen = true;

  @override
  _i3.GServicesVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GServicesData? Function(
    _i2.GServicesData?,
    _i2.GServicesData?,
  )? get updateResult;
  @override
  _i2.GServicesData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GServicesData? parseData(Map<String, dynamic> json) =>
      _i2.GServicesData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GServicesData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GServicesData, _i3.GServicesVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GServicesReq> get serializer => _$gServicesReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GServicesReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GServicesReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GServicesReq.serializer,
        json,
      );
}

abstract class GAvailableSlotsReq
    implements
        Built<GAvailableSlotsReq, GAvailableSlotsReqBuilder>,
        _i1.OperationRequest<_i2.GAvailableSlotsData, _i3.GAvailableSlotsVars> {
  GAvailableSlotsReq._();

  factory GAvailableSlotsReq(
          [void Function(GAvailableSlotsReqBuilder b) updates]) =
      _$GAvailableSlotsReq;

  static void _initializeBuilder(GAvailableSlotsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'AvailableSlots',
    )
    ..executeOnListen = true;

  @override
  _i3.GAvailableSlotsVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GAvailableSlotsData? Function(
    _i2.GAvailableSlotsData?,
    _i2.GAvailableSlotsData?,
  )? get updateResult;
  @override
  _i2.GAvailableSlotsData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GAvailableSlotsData? parseData(Map<String, dynamic> json) =>
      _i2.GAvailableSlotsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GAvailableSlotsData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GAvailableSlotsData, _i3.GAvailableSlotsVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GAvailableSlotsReq> get serializer =>
      _$gAvailableSlotsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GAvailableSlotsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAvailableSlotsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GAvailableSlotsReq.serializer,
        json,
      );
}

abstract class GPaymentMethodsReq
    implements
        Built<GPaymentMethodsReq, GPaymentMethodsReqBuilder>,
        _i1.OperationRequest<_i2.GPaymentMethodsData, _i3.GPaymentMethodsVars> {
  GPaymentMethodsReq._();

  factory GPaymentMethodsReq(
          [void Function(GPaymentMethodsReqBuilder b) updates]) =
      _$GPaymentMethodsReq;

  static void _initializeBuilder(GPaymentMethodsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'PaymentMethods',
    )
    ..executeOnListen = true;

  @override
  _i3.GPaymentMethodsVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
        context: context ?? const _i4.Context(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GPaymentMethodsData? Function(
    _i2.GPaymentMethodsData?,
    _i2.GPaymentMethodsData?,
  )? get updateResult;
  @override
  _i2.GPaymentMethodsData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GPaymentMethodsData? parseData(Map<String, dynamic> json) =>
      _i2.GPaymentMethodsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GPaymentMethodsData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GPaymentMethodsData, _i3.GPaymentMethodsVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GPaymentMethodsReq> get serializer =>
      _$gPaymentMethodsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GPaymentMethodsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPaymentMethodsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GPaymentMethodsReq.serializer,
        json,
      );
}
