// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql/ast.dart' as _i7;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:graphql_api/operations/__generated__/order.ast.gql.dart' as _i5;
import 'package:graphql_api/operations/__generated__/order.data.gql.dart'
    as _i2;
import 'package:graphql_api/operations/__generated__/order.var.gql.dart' as _i3;
import 'package:graphql_api/schema/__generated__/serializers.gql.dart' as _i6;

part 'order.req.gql.g.dart';

abstract class GOrderDetailsReq
    implements
        Built<GOrderDetailsReq, GOrderDetailsReqBuilder>,
        _i1.OperationRequest<_i2.GOrderDetailsData, _i3.GOrderDetailsVars> {
  GOrderDetailsReq._();

  factory GOrderDetailsReq([void Function(GOrderDetailsReqBuilder b) updates]) =
      _$GOrderDetailsReq;

  static void _initializeBuilder(GOrderDetailsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'OrderDetails',
    )
    ..executeOnListen = true;

  @override
  _i3.GOrderDetailsVars get vars;
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
  _i2.GOrderDetailsData? Function(
    _i2.GOrderDetailsData?,
    _i2.GOrderDetailsData?,
  )? get updateResult;
  @override
  _i2.GOrderDetailsData? get optimisticResponse;
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
  _i2.GOrderDetailsData? parseData(Map<String, dynamic> json) =>
      _i2.GOrderDetailsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GOrderDetailsData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GOrderDetailsData, _i3.GOrderDetailsVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GOrderDetailsReq> get serializer =>
      _$gOrderDetailsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GOrderDetailsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderDetailsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GOrderDetailsReq.serializer,
        json,
      );
}

abstract class GCreateOrderReq
    implements
        Built<GCreateOrderReq, GCreateOrderReqBuilder>,
        _i1.OperationRequest<_i2.GCreateOrderData, _i3.GCreateOrderVars> {
  GCreateOrderReq._();

  factory GCreateOrderReq([void Function(GCreateOrderReqBuilder b) updates]) =
      _$GCreateOrderReq;

  static void _initializeBuilder(GCreateOrderReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'CreateOrder',
    )
    ..executeOnListen = true;

  @override
  _i3.GCreateOrderVars get vars;
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
  _i2.GCreateOrderData? Function(
    _i2.GCreateOrderData?,
    _i2.GCreateOrderData?,
  )? get updateResult;
  @override
  _i2.GCreateOrderData? get optimisticResponse;
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
  _i2.GCreateOrderData? parseData(Map<String, dynamic> json) =>
      _i2.GCreateOrderData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GCreateOrderData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GCreateOrderData, _i3.GCreateOrderVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GCreateOrderReq> get serializer =>
      _$gCreateOrderReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GCreateOrderReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateOrderReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GCreateOrderReq.serializer,
        json,
      );
}

abstract class GOrderUpdatedReq
    implements
        Built<GOrderUpdatedReq, GOrderUpdatedReqBuilder>,
        _i1.OperationRequest<_i2.GOrderUpdatedData, _i3.GOrderUpdatedVars> {
  GOrderUpdatedReq._();

  factory GOrderUpdatedReq([void Function(GOrderUpdatedReqBuilder b) updates]) =
      _$GOrderUpdatedReq;

  static void _initializeBuilder(GOrderUpdatedReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'OrderUpdated',
    )
    ..executeOnListen = true;

  @override
  _i3.GOrderUpdatedVars get vars;
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
  _i2.GOrderUpdatedData? Function(
    _i2.GOrderUpdatedData?,
    _i2.GOrderUpdatedData?,
  )? get updateResult;
  @override
  _i2.GOrderUpdatedData? get optimisticResponse;
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
  _i2.GOrderUpdatedData? parseData(Map<String, dynamic> json) =>
      _i2.GOrderUpdatedData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GOrderUpdatedData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GOrderUpdatedData, _i3.GOrderUpdatedVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GOrderUpdatedReq> get serializer =>
      _$gOrderUpdatedReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GOrderUpdatedReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderUpdatedReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GOrderUpdatedReq.serializer,
        json,
      );
}

abstract class GOrderFieldsReq
    implements
        Built<GOrderFieldsReq, GOrderFieldsReqBuilder>,
        _i1.FragmentRequest<_i2.GOrderFieldsData, _i3.GOrderFieldsVars> {
  GOrderFieldsReq._();

  factory GOrderFieldsReq([void Function(GOrderFieldsReqBuilder b) updates]) =
      _$GOrderFieldsReq;

  static void _initializeBuilder(GOrderFieldsReqBuilder b) => b
    ..document = _i5.document
    ..fragmentName = 'OrderFields';

  @override
  _i3.GOrderFieldsVars get vars;
  @override
  _i7.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GOrderFieldsData? parseData(Map<String, dynamic> json) =>
      _i2.GOrderFieldsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GOrderFieldsData data) => data.toJson();

  static Serializer<GOrderFieldsReq> get serializer =>
      _$gOrderFieldsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GOrderFieldsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderFieldsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GOrderFieldsReq.serializer,
        json,
      );
}
