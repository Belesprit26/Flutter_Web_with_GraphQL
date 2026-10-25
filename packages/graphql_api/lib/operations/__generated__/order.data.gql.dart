// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:graphql_api/schema/__generated__/schema.schema.gql.dart' as _i2;
import 'package:graphql_api/schema/__generated__/serializers.gql.dart' as _i1;

part 'order.data.gql.g.dart';

abstract class GOrderDetailsData
    implements Built<GOrderDetailsData, GOrderDetailsDataBuilder> {
  GOrderDetailsData._();

  factory GOrderDetailsData(
          [void Function(GOrderDetailsDataBuilder b) updates]) =
      _$GOrderDetailsData;

  static void _initializeBuilder(GOrderDetailsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GOrderDetailsData_order? get order;
  static Serializer<GOrderDetailsData> get serializer =>
      _$gOrderDetailsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderDetailsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderDetailsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderDetailsData.serializer,
        json,
      );
}

abstract class GOrderDetailsData_order
    implements
        Built<GOrderDetailsData_order, GOrderDetailsData_orderBuilder>,
        GOrderFields {
  GOrderDetailsData_order._();

  factory GOrderDetailsData_order(
          [void Function(GOrderDetailsData_orderBuilder b) updates]) =
      _$GOrderDetailsData_order;

  static void _initializeBuilder(GOrderDetailsData_orderBuilder b) =>
      b..G__typename = 'Order';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  _i2.GOrderStatus get status;
  @override
  int get totalCents;
  @override
  String get currency;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  BuiltList<GOrderDetailsData_order_items> get items;
  @override
  GOrderDetailsData_order_slot get slot;
  @override
  GOrderDetailsData_order_card get card;
  @override
  BuiltList<GOrderDetailsData_order_timeline> get timeline;
  static Serializer<GOrderDetailsData_order> get serializer =>
      _$gOrderDetailsDataOrderSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderDetailsData_order.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderDetailsData_order? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderDetailsData_order.serializer,
        json,
      );
}

abstract class GOrderDetailsData_order_items
    implements
        Built<GOrderDetailsData_order_items,
            GOrderDetailsData_order_itemsBuilder>,
        GOrderFields_items {
  GOrderDetailsData_order_items._();

  factory GOrderDetailsData_order_items(
          [void Function(GOrderDetailsData_order_itemsBuilder b) updates]) =
      _$GOrderDetailsData_order_items;

  static void _initializeBuilder(GOrderDetailsData_order_itemsBuilder b) =>
      b..G__typename = 'OrderItem';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get serviceId;
  @override
  String get name;
  @override
  int get priceCents;
  static Serializer<GOrderDetailsData_order_items> get serializer =>
      _$gOrderDetailsDataOrderItemsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderDetailsData_order_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderDetailsData_order_items? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderDetailsData_order_items.serializer,
        json,
      );
}

abstract class GOrderDetailsData_order_slot
    implements
        Built<GOrderDetailsData_order_slot,
            GOrderDetailsData_order_slotBuilder>,
        GOrderFields_slot {
  GOrderDetailsData_order_slot._();

  factory GOrderDetailsData_order_slot(
          [void Function(GOrderDetailsData_order_slotBuilder b) updates]) =
      _$GOrderDetailsData_order_slot;

  static void _initializeBuilder(GOrderDetailsData_order_slotBuilder b) =>
      b..G__typename = 'BookedSlot';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get slotId;
  @override
  String get startsAt;
  @override
  String get endsAt;
  static Serializer<GOrderDetailsData_order_slot> get serializer =>
      _$gOrderDetailsDataOrderSlotSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderDetailsData_order_slot.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderDetailsData_order_slot? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderDetailsData_order_slot.serializer,
        json,
      );
}

abstract class GOrderDetailsData_order_card
    implements
        Built<GOrderDetailsData_order_card,
            GOrderDetailsData_order_cardBuilder>,
        GOrderFields_card {
  GOrderDetailsData_order_card._();

  factory GOrderDetailsData_order_card(
          [void Function(GOrderDetailsData_order_cardBuilder b) updates]) =
      _$GOrderDetailsData_order_card;

  static void _initializeBuilder(GOrderDetailsData_order_cardBuilder b) =>
      b..G__typename = 'CardSnapshot';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get paymentMethodId;
  @override
  _i2.GCardBrand get brand;
  @override
  String get last4;
  static Serializer<GOrderDetailsData_order_card> get serializer =>
      _$gOrderDetailsDataOrderCardSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderDetailsData_order_card.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderDetailsData_order_card? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderDetailsData_order_card.serializer,
        json,
      );
}

abstract class GOrderDetailsData_order_timeline
    implements
        Built<GOrderDetailsData_order_timeline,
            GOrderDetailsData_order_timelineBuilder>,
        GOrderFields_timeline {
  GOrderDetailsData_order_timeline._();

  factory GOrderDetailsData_order_timeline(
          [void Function(GOrderDetailsData_order_timelineBuilder b) updates]) =
      _$GOrderDetailsData_order_timeline;

  static void _initializeBuilder(GOrderDetailsData_order_timelineBuilder b) =>
      b..G__typename = 'OrderEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  _i2.GOrderEventType get type;
  @override
  String get at;
  @override
  String? get message;
  static Serializer<GOrderDetailsData_order_timeline> get serializer =>
      _$gOrderDetailsDataOrderTimelineSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderDetailsData_order_timeline.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderDetailsData_order_timeline? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderDetailsData_order_timeline.serializer,
        json,
      );
}

abstract class GCreateOrderData
    implements Built<GCreateOrderData, GCreateOrderDataBuilder> {
  GCreateOrderData._();

  factory GCreateOrderData([void Function(GCreateOrderDataBuilder b) updates]) =
      _$GCreateOrderData;

  static void _initializeBuilder(GCreateOrderDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCreateOrderData_createOrder get createOrder;
  static Serializer<GCreateOrderData> get serializer =>
      _$gCreateOrderDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateOrderData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateOrderData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateOrderData.serializer,
        json,
      );
}

abstract class GCreateOrderData_createOrder
    implements
        Built<GCreateOrderData_createOrder,
            GCreateOrderData_createOrderBuilder> {
  GCreateOrderData_createOrder._();

  factory GCreateOrderData_createOrder(
          [void Function(GCreateOrderData_createOrderBuilder b) updates]) =
      _$GCreateOrderData_createOrder;

  static void _initializeBuilder(GCreateOrderData_createOrderBuilder b) =>
      b..G__typename = 'CreateOrderPayload';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get replayed;
  GCreateOrderData_createOrder_order get order;
  static Serializer<GCreateOrderData_createOrder> get serializer =>
      _$gCreateOrderDataCreateOrderSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateOrderData_createOrder.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateOrderData_createOrder? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateOrderData_createOrder.serializer,
        json,
      );
}

abstract class GCreateOrderData_createOrder_order
    implements
        Built<GCreateOrderData_createOrder_order,
            GCreateOrderData_createOrder_orderBuilder>,
        GOrderFields {
  GCreateOrderData_createOrder_order._();

  factory GCreateOrderData_createOrder_order(
      [void Function(GCreateOrderData_createOrder_orderBuilder b)
          updates]) = _$GCreateOrderData_createOrder_order;

  static void _initializeBuilder(GCreateOrderData_createOrder_orderBuilder b) =>
      b..G__typename = 'Order';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  _i2.GOrderStatus get status;
  @override
  int get totalCents;
  @override
  String get currency;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  BuiltList<GCreateOrderData_createOrder_order_items> get items;
  @override
  GCreateOrderData_createOrder_order_slot get slot;
  @override
  GCreateOrderData_createOrder_order_card get card;
  @override
  BuiltList<GCreateOrderData_createOrder_order_timeline> get timeline;
  static Serializer<GCreateOrderData_createOrder_order> get serializer =>
      _$gCreateOrderDataCreateOrderOrderSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateOrderData_createOrder_order.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateOrderData_createOrder_order? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateOrderData_createOrder_order.serializer,
        json,
      );
}

abstract class GCreateOrderData_createOrder_order_items
    implements
        Built<GCreateOrderData_createOrder_order_items,
            GCreateOrderData_createOrder_order_itemsBuilder>,
        GOrderFields_items {
  GCreateOrderData_createOrder_order_items._();

  factory GCreateOrderData_createOrder_order_items(
      [void Function(GCreateOrderData_createOrder_order_itemsBuilder b)
          updates]) = _$GCreateOrderData_createOrder_order_items;

  static void _initializeBuilder(
          GCreateOrderData_createOrder_order_itemsBuilder b) =>
      b..G__typename = 'OrderItem';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get serviceId;
  @override
  String get name;
  @override
  int get priceCents;
  static Serializer<GCreateOrderData_createOrder_order_items> get serializer =>
      _$gCreateOrderDataCreateOrderOrderItemsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateOrderData_createOrder_order_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateOrderData_createOrder_order_items? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateOrderData_createOrder_order_items.serializer,
        json,
      );
}

abstract class GCreateOrderData_createOrder_order_slot
    implements
        Built<GCreateOrderData_createOrder_order_slot,
            GCreateOrderData_createOrder_order_slotBuilder>,
        GOrderFields_slot {
  GCreateOrderData_createOrder_order_slot._();

  factory GCreateOrderData_createOrder_order_slot(
      [void Function(GCreateOrderData_createOrder_order_slotBuilder b)
          updates]) = _$GCreateOrderData_createOrder_order_slot;

  static void _initializeBuilder(
          GCreateOrderData_createOrder_order_slotBuilder b) =>
      b..G__typename = 'BookedSlot';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get slotId;
  @override
  String get startsAt;
  @override
  String get endsAt;
  static Serializer<GCreateOrderData_createOrder_order_slot> get serializer =>
      _$gCreateOrderDataCreateOrderOrderSlotSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateOrderData_createOrder_order_slot.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateOrderData_createOrder_order_slot? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateOrderData_createOrder_order_slot.serializer,
        json,
      );
}

abstract class GCreateOrderData_createOrder_order_card
    implements
        Built<GCreateOrderData_createOrder_order_card,
            GCreateOrderData_createOrder_order_cardBuilder>,
        GOrderFields_card {
  GCreateOrderData_createOrder_order_card._();

  factory GCreateOrderData_createOrder_order_card(
      [void Function(GCreateOrderData_createOrder_order_cardBuilder b)
          updates]) = _$GCreateOrderData_createOrder_order_card;

  static void _initializeBuilder(
          GCreateOrderData_createOrder_order_cardBuilder b) =>
      b..G__typename = 'CardSnapshot';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get paymentMethodId;
  @override
  _i2.GCardBrand get brand;
  @override
  String get last4;
  static Serializer<GCreateOrderData_createOrder_order_card> get serializer =>
      _$gCreateOrderDataCreateOrderOrderCardSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateOrderData_createOrder_order_card.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateOrderData_createOrder_order_card? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateOrderData_createOrder_order_card.serializer,
        json,
      );
}

abstract class GCreateOrderData_createOrder_order_timeline
    implements
        Built<GCreateOrderData_createOrder_order_timeline,
            GCreateOrderData_createOrder_order_timelineBuilder>,
        GOrderFields_timeline {
  GCreateOrderData_createOrder_order_timeline._();

  factory GCreateOrderData_createOrder_order_timeline(
      [void Function(GCreateOrderData_createOrder_order_timelineBuilder b)
          updates]) = _$GCreateOrderData_createOrder_order_timeline;

  static void _initializeBuilder(
          GCreateOrderData_createOrder_order_timelineBuilder b) =>
      b..G__typename = 'OrderEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  _i2.GOrderEventType get type;
  @override
  String get at;
  @override
  String? get message;
  static Serializer<GCreateOrderData_createOrder_order_timeline>
      get serializer => _$gCreateOrderDataCreateOrderOrderTimelineSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateOrderData_createOrder_order_timeline.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateOrderData_createOrder_order_timeline? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateOrderData_createOrder_order_timeline.serializer,
        json,
      );
}

abstract class GOrderUpdatedData
    implements Built<GOrderUpdatedData, GOrderUpdatedDataBuilder> {
  GOrderUpdatedData._();

  factory GOrderUpdatedData(
          [void Function(GOrderUpdatedDataBuilder b) updates]) =
      _$GOrderUpdatedData;

  static void _initializeBuilder(GOrderUpdatedDataBuilder b) =>
      b..G__typename = 'Subscription';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GOrderUpdatedData_orderUpdated get orderUpdated;
  static Serializer<GOrderUpdatedData> get serializer =>
      _$gOrderUpdatedDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderUpdatedData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderUpdatedData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderUpdatedData.serializer,
        json,
      );
}

abstract class GOrderUpdatedData_orderUpdated
    implements
        Built<GOrderUpdatedData_orderUpdated,
            GOrderUpdatedData_orderUpdatedBuilder>,
        GOrderFields {
  GOrderUpdatedData_orderUpdated._();

  factory GOrderUpdatedData_orderUpdated(
          [void Function(GOrderUpdatedData_orderUpdatedBuilder b) updates]) =
      _$GOrderUpdatedData_orderUpdated;

  static void _initializeBuilder(GOrderUpdatedData_orderUpdatedBuilder b) =>
      b..G__typename = 'Order';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  _i2.GOrderStatus get status;
  @override
  int get totalCents;
  @override
  String get currency;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  BuiltList<GOrderUpdatedData_orderUpdated_items> get items;
  @override
  GOrderUpdatedData_orderUpdated_slot get slot;
  @override
  GOrderUpdatedData_orderUpdated_card get card;
  @override
  BuiltList<GOrderUpdatedData_orderUpdated_timeline> get timeline;
  static Serializer<GOrderUpdatedData_orderUpdated> get serializer =>
      _$gOrderUpdatedDataOrderUpdatedSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderUpdatedData_orderUpdated.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderUpdatedData_orderUpdated? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderUpdatedData_orderUpdated.serializer,
        json,
      );
}

abstract class GOrderUpdatedData_orderUpdated_items
    implements
        Built<GOrderUpdatedData_orderUpdated_items,
            GOrderUpdatedData_orderUpdated_itemsBuilder>,
        GOrderFields_items {
  GOrderUpdatedData_orderUpdated_items._();

  factory GOrderUpdatedData_orderUpdated_items(
      [void Function(GOrderUpdatedData_orderUpdated_itemsBuilder b)
          updates]) = _$GOrderUpdatedData_orderUpdated_items;

  static void _initializeBuilder(
          GOrderUpdatedData_orderUpdated_itemsBuilder b) =>
      b..G__typename = 'OrderItem';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get serviceId;
  @override
  String get name;
  @override
  int get priceCents;
  static Serializer<GOrderUpdatedData_orderUpdated_items> get serializer =>
      _$gOrderUpdatedDataOrderUpdatedItemsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderUpdatedData_orderUpdated_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderUpdatedData_orderUpdated_items? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderUpdatedData_orderUpdated_items.serializer,
        json,
      );
}

abstract class GOrderUpdatedData_orderUpdated_slot
    implements
        Built<GOrderUpdatedData_orderUpdated_slot,
            GOrderUpdatedData_orderUpdated_slotBuilder>,
        GOrderFields_slot {
  GOrderUpdatedData_orderUpdated_slot._();

  factory GOrderUpdatedData_orderUpdated_slot(
      [void Function(GOrderUpdatedData_orderUpdated_slotBuilder b)
          updates]) = _$GOrderUpdatedData_orderUpdated_slot;

  static void _initializeBuilder(
          GOrderUpdatedData_orderUpdated_slotBuilder b) =>
      b..G__typename = 'BookedSlot';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get slotId;
  @override
  String get startsAt;
  @override
  String get endsAt;
  static Serializer<GOrderUpdatedData_orderUpdated_slot> get serializer =>
      _$gOrderUpdatedDataOrderUpdatedSlotSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderUpdatedData_orderUpdated_slot.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderUpdatedData_orderUpdated_slot? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderUpdatedData_orderUpdated_slot.serializer,
        json,
      );
}

abstract class GOrderUpdatedData_orderUpdated_card
    implements
        Built<GOrderUpdatedData_orderUpdated_card,
            GOrderUpdatedData_orderUpdated_cardBuilder>,
        GOrderFields_card {
  GOrderUpdatedData_orderUpdated_card._();

  factory GOrderUpdatedData_orderUpdated_card(
      [void Function(GOrderUpdatedData_orderUpdated_cardBuilder b)
          updates]) = _$GOrderUpdatedData_orderUpdated_card;

  static void _initializeBuilder(
          GOrderUpdatedData_orderUpdated_cardBuilder b) =>
      b..G__typename = 'CardSnapshot';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get paymentMethodId;
  @override
  _i2.GCardBrand get brand;
  @override
  String get last4;
  static Serializer<GOrderUpdatedData_orderUpdated_card> get serializer =>
      _$gOrderUpdatedDataOrderUpdatedCardSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderUpdatedData_orderUpdated_card.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderUpdatedData_orderUpdated_card? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderUpdatedData_orderUpdated_card.serializer,
        json,
      );
}

abstract class GOrderUpdatedData_orderUpdated_timeline
    implements
        Built<GOrderUpdatedData_orderUpdated_timeline,
            GOrderUpdatedData_orderUpdated_timelineBuilder>,
        GOrderFields_timeline {
  GOrderUpdatedData_orderUpdated_timeline._();

  factory GOrderUpdatedData_orderUpdated_timeline(
      [void Function(GOrderUpdatedData_orderUpdated_timelineBuilder b)
          updates]) = _$GOrderUpdatedData_orderUpdated_timeline;

  static void _initializeBuilder(
          GOrderUpdatedData_orderUpdated_timelineBuilder b) =>
      b..G__typename = 'OrderEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  _i2.GOrderEventType get type;
  @override
  String get at;
  @override
  String? get message;
  static Serializer<GOrderUpdatedData_orderUpdated_timeline> get serializer =>
      _$gOrderUpdatedDataOrderUpdatedTimelineSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderUpdatedData_orderUpdated_timeline.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderUpdatedData_orderUpdated_timeline? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderUpdatedData_orderUpdated_timeline.serializer,
        json,
      );
}

abstract class GOrderFields {
  String get G__typename;
  String get id;
  _i2.GOrderStatus get status;
  int get totalCents;
  String get currency;
  String get createdAt;
  String get updatedAt;
  BuiltList<GOrderFields_items> get items;
  GOrderFields_slot get slot;
  GOrderFields_card get card;
  BuiltList<GOrderFields_timeline> get timeline;
  Map<String, dynamic> toJson();
}

abstract class GOrderFields_items {
  String get G__typename;
  String get serviceId;
  String get name;
  int get priceCents;
  Map<String, dynamic> toJson();
}

abstract class GOrderFields_slot {
  String get G__typename;
  String get slotId;
  String get startsAt;
  String get endsAt;
  Map<String, dynamic> toJson();
}

abstract class GOrderFields_card {
  String get G__typename;
  String get paymentMethodId;
  _i2.GCardBrand get brand;
  String get last4;
  Map<String, dynamic> toJson();
}

abstract class GOrderFields_timeline {
  String get G__typename;
  String get id;
  _i2.GOrderEventType get type;
  String get at;
  String? get message;
  Map<String, dynamic> toJson();
}

abstract class GOrderFieldsData
    implements Built<GOrderFieldsData, GOrderFieldsDataBuilder>, GOrderFields {
  GOrderFieldsData._();

  factory GOrderFieldsData([void Function(GOrderFieldsDataBuilder b) updates]) =
      _$GOrderFieldsData;

  static void _initializeBuilder(GOrderFieldsDataBuilder b) =>
      b..G__typename = 'Order';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  _i2.GOrderStatus get status;
  @override
  int get totalCents;
  @override
  String get currency;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  BuiltList<GOrderFieldsData_items> get items;
  @override
  GOrderFieldsData_slot get slot;
  @override
  GOrderFieldsData_card get card;
  @override
  BuiltList<GOrderFieldsData_timeline> get timeline;
  static Serializer<GOrderFieldsData> get serializer =>
      _$gOrderFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderFieldsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderFieldsData.serializer,
        json,
      );
}

abstract class GOrderFieldsData_items
    implements
        Built<GOrderFieldsData_items, GOrderFieldsData_itemsBuilder>,
        GOrderFields_items {
  GOrderFieldsData_items._();

  factory GOrderFieldsData_items(
          [void Function(GOrderFieldsData_itemsBuilder b) updates]) =
      _$GOrderFieldsData_items;

  static void _initializeBuilder(GOrderFieldsData_itemsBuilder b) =>
      b..G__typename = 'OrderItem';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get serviceId;
  @override
  String get name;
  @override
  int get priceCents;
  static Serializer<GOrderFieldsData_items> get serializer =>
      _$gOrderFieldsDataItemsSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderFieldsData_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderFieldsData_items? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderFieldsData_items.serializer,
        json,
      );
}

abstract class GOrderFieldsData_slot
    implements
        Built<GOrderFieldsData_slot, GOrderFieldsData_slotBuilder>,
        GOrderFields_slot {
  GOrderFieldsData_slot._();

  factory GOrderFieldsData_slot(
          [void Function(GOrderFieldsData_slotBuilder b) updates]) =
      _$GOrderFieldsData_slot;

  static void _initializeBuilder(GOrderFieldsData_slotBuilder b) =>
      b..G__typename = 'BookedSlot';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get slotId;
  @override
  String get startsAt;
  @override
  String get endsAt;
  static Serializer<GOrderFieldsData_slot> get serializer =>
      _$gOrderFieldsDataSlotSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderFieldsData_slot.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderFieldsData_slot? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderFieldsData_slot.serializer,
        json,
      );
}

abstract class GOrderFieldsData_card
    implements
        Built<GOrderFieldsData_card, GOrderFieldsData_cardBuilder>,
        GOrderFields_card {
  GOrderFieldsData_card._();

  factory GOrderFieldsData_card(
          [void Function(GOrderFieldsData_cardBuilder b) updates]) =
      _$GOrderFieldsData_card;

  static void _initializeBuilder(GOrderFieldsData_cardBuilder b) =>
      b..G__typename = 'CardSnapshot';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get paymentMethodId;
  @override
  _i2.GCardBrand get brand;
  @override
  String get last4;
  static Serializer<GOrderFieldsData_card> get serializer =>
      _$gOrderFieldsDataCardSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderFieldsData_card.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderFieldsData_card? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderFieldsData_card.serializer,
        json,
      );
}

abstract class GOrderFieldsData_timeline
    implements
        Built<GOrderFieldsData_timeline, GOrderFieldsData_timelineBuilder>,
        GOrderFields_timeline {
  GOrderFieldsData_timeline._();

  factory GOrderFieldsData_timeline(
          [void Function(GOrderFieldsData_timelineBuilder b) updates]) =
      _$GOrderFieldsData_timeline;

  static void _initializeBuilder(GOrderFieldsData_timelineBuilder b) =>
      b..G__typename = 'OrderEvent';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  _i2.GOrderEventType get type;
  @override
  String get at;
  @override
  String? get message;
  static Serializer<GOrderFieldsData_timeline> get serializer =>
      _$gOrderFieldsDataTimelineSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderFieldsData_timeline.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderFieldsData_timeline? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderFieldsData_timeline.serializer,
        json,
      );
}
