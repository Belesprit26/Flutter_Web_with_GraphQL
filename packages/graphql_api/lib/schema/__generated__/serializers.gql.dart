// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;
import 'package:graphql_api/operations/__generated__/catalog.data.gql.dart'
    show
        GAvailableSlotsData,
        GAvailableSlotsData_availableSlots,
        GPaymentMethodsData,
        GPaymentMethodsData_paymentMethods,
        GServicesData,
        GServicesData_services;
import 'package:graphql_api/operations/__generated__/catalog.req.gql.dart'
    show GAvailableSlotsReq, GPaymentMethodsReq, GServicesReq;
import 'package:graphql_api/operations/__generated__/catalog.var.gql.dart'
    show GAvailableSlotsVars, GPaymentMethodsVars, GServicesVars;
import 'package:graphql_api/operations/__generated__/order.data.gql.dart'
    show
        GCreateOrderData,
        GCreateOrderData_createOrder,
        GCreateOrderData_createOrder_order,
        GCreateOrderData_createOrder_order_card,
        GCreateOrderData_createOrder_order_items,
        GCreateOrderData_createOrder_order_slot,
        GCreateOrderData_createOrder_order_timeline,
        GOrderDetailsData,
        GOrderDetailsData_order,
        GOrderDetailsData_order_card,
        GOrderDetailsData_order_items,
        GOrderDetailsData_order_slot,
        GOrderDetailsData_order_timeline,
        GOrderFieldsData,
        GOrderFieldsData_card,
        GOrderFieldsData_items,
        GOrderFieldsData_slot,
        GOrderFieldsData_timeline,
        GOrderUpdatedData,
        GOrderUpdatedData_orderUpdated,
        GOrderUpdatedData_orderUpdated_card,
        GOrderUpdatedData_orderUpdated_items,
        GOrderUpdatedData_orderUpdated_slot,
        GOrderUpdatedData_orderUpdated_timeline;
import 'package:graphql_api/operations/__generated__/order.req.gql.dart'
    show GCreateOrderReq, GOrderDetailsReq, GOrderFieldsReq, GOrderUpdatedReq;
import 'package:graphql_api/operations/__generated__/order.var.gql.dart'
    show
        GCreateOrderVars,
        GOrderDetailsVars,
        GOrderFieldsVars,
        GOrderUpdatedVars;
import 'package:graphql_api/schema/__generated__/schema.schema.gql.dart'
    show GCardBrand, GCreateOrderInput, GOrderEventType, GOrderStatus;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GAvailableSlotsData,
  GAvailableSlotsData_availableSlots,
  GAvailableSlotsReq,
  GAvailableSlotsVars,
  GCardBrand,
  GCreateOrderData,
  GCreateOrderData_createOrder,
  GCreateOrderData_createOrder_order,
  GCreateOrderData_createOrder_order_card,
  GCreateOrderData_createOrder_order_items,
  GCreateOrderData_createOrder_order_slot,
  GCreateOrderData_createOrder_order_timeline,
  GCreateOrderInput,
  GCreateOrderReq,
  GCreateOrderVars,
  GOrderDetailsData,
  GOrderDetailsData_order,
  GOrderDetailsData_order_card,
  GOrderDetailsData_order_items,
  GOrderDetailsData_order_slot,
  GOrderDetailsData_order_timeline,
  GOrderDetailsReq,
  GOrderDetailsVars,
  GOrderEventType,
  GOrderFieldsData,
  GOrderFieldsData_card,
  GOrderFieldsData_items,
  GOrderFieldsData_slot,
  GOrderFieldsData_timeline,
  GOrderFieldsReq,
  GOrderFieldsVars,
  GOrderStatus,
  GOrderUpdatedData,
  GOrderUpdatedData_orderUpdated,
  GOrderUpdatedData_orderUpdated_card,
  GOrderUpdatedData_orderUpdated_items,
  GOrderUpdatedData_orderUpdated_slot,
  GOrderUpdatedData_orderUpdated_timeline,
  GOrderUpdatedReq,
  GOrderUpdatedVars,
  GPaymentMethodsData,
  GPaymentMethodsData_paymentMethods,
  GPaymentMethodsReq,
  GPaymentMethodsVars,
  GServicesData,
  GServicesData_services,
  GServicesReq,
  GServicesVars,
])
final Serializers serializers = _serializersBuilder.build();
