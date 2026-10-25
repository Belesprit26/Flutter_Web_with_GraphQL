// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GOrderDetailsData> _$gOrderDetailsDataSerializer =
    _$GOrderDetailsDataSerializer();
Serializer<GOrderDetailsData_order> _$gOrderDetailsDataOrderSerializer =
    _$GOrderDetailsData_orderSerializer();
Serializer<GOrderDetailsData_order_items>
_$gOrderDetailsDataOrderItemsSerializer =
    _$GOrderDetailsData_order_itemsSerializer();
Serializer<GOrderDetailsData_order_slot>
_$gOrderDetailsDataOrderSlotSerializer =
    _$GOrderDetailsData_order_slotSerializer();
Serializer<GOrderDetailsData_order_card>
_$gOrderDetailsDataOrderCardSerializer =
    _$GOrderDetailsData_order_cardSerializer();
Serializer<GOrderDetailsData_order_timeline>
_$gOrderDetailsDataOrderTimelineSerializer =
    _$GOrderDetailsData_order_timelineSerializer();
Serializer<GCreateOrderData> _$gCreateOrderDataSerializer =
    _$GCreateOrderDataSerializer();
Serializer<GCreateOrderData_createOrder>
_$gCreateOrderDataCreateOrderSerializer =
    _$GCreateOrderData_createOrderSerializer();
Serializer<GCreateOrderData_createOrder_order>
_$gCreateOrderDataCreateOrderOrderSerializer =
    _$GCreateOrderData_createOrder_orderSerializer();
Serializer<GCreateOrderData_createOrder_order_items>
_$gCreateOrderDataCreateOrderOrderItemsSerializer =
    _$GCreateOrderData_createOrder_order_itemsSerializer();
Serializer<GCreateOrderData_createOrder_order_slot>
_$gCreateOrderDataCreateOrderOrderSlotSerializer =
    _$GCreateOrderData_createOrder_order_slotSerializer();
Serializer<GCreateOrderData_createOrder_order_card>
_$gCreateOrderDataCreateOrderOrderCardSerializer =
    _$GCreateOrderData_createOrder_order_cardSerializer();
Serializer<GCreateOrderData_createOrder_order_timeline>
_$gCreateOrderDataCreateOrderOrderTimelineSerializer =
    _$GCreateOrderData_createOrder_order_timelineSerializer();
Serializer<GOrderUpdatedData> _$gOrderUpdatedDataSerializer =
    _$GOrderUpdatedDataSerializer();
Serializer<GOrderUpdatedData_orderUpdated>
_$gOrderUpdatedDataOrderUpdatedSerializer =
    _$GOrderUpdatedData_orderUpdatedSerializer();
Serializer<GOrderUpdatedData_orderUpdated_items>
_$gOrderUpdatedDataOrderUpdatedItemsSerializer =
    _$GOrderUpdatedData_orderUpdated_itemsSerializer();
Serializer<GOrderUpdatedData_orderUpdated_slot>
_$gOrderUpdatedDataOrderUpdatedSlotSerializer =
    _$GOrderUpdatedData_orderUpdated_slotSerializer();
Serializer<GOrderUpdatedData_orderUpdated_card>
_$gOrderUpdatedDataOrderUpdatedCardSerializer =
    _$GOrderUpdatedData_orderUpdated_cardSerializer();
Serializer<GOrderUpdatedData_orderUpdated_timeline>
_$gOrderUpdatedDataOrderUpdatedTimelineSerializer =
    _$GOrderUpdatedData_orderUpdated_timelineSerializer();
Serializer<GOrderFieldsData> _$gOrderFieldsDataSerializer =
    _$GOrderFieldsDataSerializer();
Serializer<GOrderFieldsData_items> _$gOrderFieldsDataItemsSerializer =
    _$GOrderFieldsData_itemsSerializer();
Serializer<GOrderFieldsData_slot> _$gOrderFieldsDataSlotSerializer =
    _$GOrderFieldsData_slotSerializer();
Serializer<GOrderFieldsData_card> _$gOrderFieldsDataCardSerializer =
    _$GOrderFieldsData_cardSerializer();
Serializer<GOrderFieldsData_timeline> _$gOrderFieldsDataTimelineSerializer =
    _$GOrderFieldsData_timelineSerializer();

class _$GOrderDetailsDataSerializer
    implements StructuredSerializer<GOrderDetailsData> {
  @override
  final Iterable<Type> types = const [GOrderDetailsData, _$GOrderDetailsData];
  @override
  final String wireName = 'GOrderDetailsData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderDetailsData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.order;
    if (value != null) {
      result
        ..add('order')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(GOrderDetailsData_order),
          ),
        );
    }
    return result;
  }

  @override
  GOrderDetailsData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderDetailsDataBuilder();

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
        case 'order':
          result.order.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GOrderDetailsData_order),
                )!
                as GOrderDetailsData_order,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GOrderDetailsData_orderSerializer
    implements StructuredSerializer<GOrderDetailsData_order> {
  @override
  final Iterable<Type> types = const [
    GOrderDetailsData_order,
    _$GOrderDetailsData_order,
  ];
  @override
  final String wireName = 'GOrderDetailsData_order';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderDetailsData_order object, {
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
      'status',
      serializers.serialize(
        object.status,
        specifiedType: const FullType(_i2.GOrderStatus),
      ),
      'totalCents',
      serializers.serialize(
        object.totalCents,
        specifiedType: const FullType(int),
      ),
      'currency',
      serializers.serialize(
        object.currency,
        specifiedType: const FullType(String),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(String),
      ),
      'updatedAt',
      serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(String),
      ),
      'items',
      serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GOrderDetailsData_order_items),
        ]),
      ),
      'slot',
      serializers.serialize(
        object.slot,
        specifiedType: const FullType(GOrderDetailsData_order_slot),
      ),
      'card',
      serializers.serialize(
        object.card,
        specifiedType: const FullType(GOrderDetailsData_order_card),
      ),
      'timeline',
      serializers.serialize(
        object.timeline,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GOrderDetailsData_order_timeline),
        ]),
      ),
    ];

    return result;
  }

  @override
  GOrderDetailsData_order deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderDetailsData_orderBuilder();

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
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GOrderStatus),
                  )!
                  as _i2.GOrderStatus;
          break;
        case 'totalCents':
          result.totalCents =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'currency':
          result.currency =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'createdAt':
          result.createdAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'updatedAt':
          result.updatedAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'items':
          result.items.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GOrderDetailsData_order_items),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'slot':
          result.slot.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GOrderDetailsData_order_slot),
                )!
                as GOrderDetailsData_order_slot,
          );
          break;
        case 'card':
          result.card.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GOrderDetailsData_order_card),
                )!
                as GOrderDetailsData_order_card,
          );
          break;
        case 'timeline':
          result.timeline.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GOrderDetailsData_order_timeline),
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

class _$GOrderDetailsData_order_itemsSerializer
    implements StructuredSerializer<GOrderDetailsData_order_items> {
  @override
  final Iterable<Type> types = const [
    GOrderDetailsData_order_items,
    _$GOrderDetailsData_order_items,
  ];
  @override
  final String wireName = 'GOrderDetailsData_order_items';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderDetailsData_order_items object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'serviceId',
      serializers.serialize(
        object.serviceId,
        specifiedType: const FullType(String),
      ),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'priceCents',
      serializers.serialize(
        object.priceCents,
        specifiedType: const FullType(int),
      ),
    ];

    return result;
  }

  @override
  GOrderDetailsData_order_items deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderDetailsData_order_itemsBuilder();

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
        case 'serviceId':
          result.serviceId =
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
        case 'priceCents':
          result.priceCents =
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

class _$GOrderDetailsData_order_slotSerializer
    implements StructuredSerializer<GOrderDetailsData_order_slot> {
  @override
  final Iterable<Type> types = const [
    GOrderDetailsData_order_slot,
    _$GOrderDetailsData_order_slot,
  ];
  @override
  final String wireName = 'GOrderDetailsData_order_slot';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderDetailsData_order_slot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'slotId',
      serializers.serialize(
        object.slotId,
        specifiedType: const FullType(String),
      ),
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
    ];

    return result;
  }

  @override
  GOrderDetailsData_order_slot deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderDetailsData_order_slotBuilder();

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
        case 'slotId':
          result.slotId =
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
      }
    }

    return result.build();
  }
}

class _$GOrderDetailsData_order_cardSerializer
    implements StructuredSerializer<GOrderDetailsData_order_card> {
  @override
  final Iterable<Type> types = const [
    GOrderDetailsData_order_card,
    _$GOrderDetailsData_order_card,
  ];
  @override
  final String wireName = 'GOrderDetailsData_order_card';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderDetailsData_order_card object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'paymentMethodId',
      serializers.serialize(
        object.paymentMethodId,
        specifiedType: const FullType(String),
      ),
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
    ];

    return result;
  }

  @override
  GOrderDetailsData_order_card deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderDetailsData_order_cardBuilder();

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
        case 'paymentMethodId':
          result.paymentMethodId =
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
      }
    }

    return result.build();
  }
}

class _$GOrderDetailsData_order_timelineSerializer
    implements StructuredSerializer<GOrderDetailsData_order_timeline> {
  @override
  final Iterable<Type> types = const [
    GOrderDetailsData_order_timeline,
    _$GOrderDetailsData_order_timeline,
  ];
  @override
  final String wireName = 'GOrderDetailsData_order_timeline';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderDetailsData_order_timeline object, {
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
      'type',
      serializers.serialize(
        object.type,
        specifiedType: const FullType(_i2.GOrderEventType),
      ),
      'at',
      serializers.serialize(object.at, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GOrderDetailsData_order_timeline deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderDetailsData_order_timelineBuilder();

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
        case 'type':
          result.type =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GOrderEventType),
                  )!
                  as _i2.GOrderEventType;
          break;
        case 'at':
          result.at =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'message':
          result.message =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateOrderDataSerializer
    implements StructuredSerializer<GCreateOrderData> {
  @override
  final Iterable<Type> types = const [GCreateOrderData, _$GCreateOrderData];
  @override
  final String wireName = 'GCreateOrderData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateOrderData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'createOrder',
      serializers.serialize(
        object.createOrder,
        specifiedType: const FullType(GCreateOrderData_createOrder),
      ),
    ];

    return result;
  }

  @override
  GCreateOrderData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateOrderDataBuilder();

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
        case 'createOrder':
          result.createOrder.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GCreateOrderData_createOrder),
                )!
                as GCreateOrderData_createOrder,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateOrderData_createOrderSerializer
    implements StructuredSerializer<GCreateOrderData_createOrder> {
  @override
  final Iterable<Type> types = const [
    GCreateOrderData_createOrder,
    _$GCreateOrderData_createOrder,
  ];
  @override
  final String wireName = 'GCreateOrderData_createOrder';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateOrderData_createOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'replayed',
      serializers.serialize(
        object.replayed,
        specifiedType: const FullType(bool),
      ),
      'order',
      serializers.serialize(
        object.order,
        specifiedType: const FullType(GCreateOrderData_createOrder_order),
      ),
    ];

    return result;
  }

  @override
  GCreateOrderData_createOrder deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateOrderData_createOrderBuilder();

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
        case 'replayed':
          result.replayed =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'order':
          result.order.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GCreateOrderData_createOrder_order,
                  ),
                )!
                as GCreateOrderData_createOrder_order,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateOrderData_createOrder_orderSerializer
    implements StructuredSerializer<GCreateOrderData_createOrder_order> {
  @override
  final Iterable<Type> types = const [
    GCreateOrderData_createOrder_order,
    _$GCreateOrderData_createOrder_order,
  ];
  @override
  final String wireName = 'GCreateOrderData_createOrder_order';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateOrderData_createOrder_order object, {
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
      'status',
      serializers.serialize(
        object.status,
        specifiedType: const FullType(_i2.GOrderStatus),
      ),
      'totalCents',
      serializers.serialize(
        object.totalCents,
        specifiedType: const FullType(int),
      ),
      'currency',
      serializers.serialize(
        object.currency,
        specifiedType: const FullType(String),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(String),
      ),
      'updatedAt',
      serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(String),
      ),
      'items',
      serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GCreateOrderData_createOrder_order_items),
        ]),
      ),
      'slot',
      serializers.serialize(
        object.slot,
        specifiedType: const FullType(GCreateOrderData_createOrder_order_slot),
      ),
      'card',
      serializers.serialize(
        object.card,
        specifiedType: const FullType(GCreateOrderData_createOrder_order_card),
      ),
      'timeline',
      serializers.serialize(
        object.timeline,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GCreateOrderData_createOrder_order_timeline),
        ]),
      ),
    ];

    return result;
  }

  @override
  GCreateOrderData_createOrder_order deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateOrderData_createOrder_orderBuilder();

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
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GOrderStatus),
                  )!
                  as _i2.GOrderStatus;
          break;
        case 'totalCents':
          result.totalCents =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'currency':
          result.currency =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'createdAt':
          result.createdAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'updatedAt':
          result.updatedAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'items':
          result.items.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GCreateOrderData_createOrder_order_items),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'slot':
          result.slot.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GCreateOrderData_createOrder_order_slot,
                  ),
                )!
                as GCreateOrderData_createOrder_order_slot,
          );
          break;
        case 'card':
          result.card.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GCreateOrderData_createOrder_order_card,
                  ),
                )!
                as GCreateOrderData_createOrder_order_card,
          );
          break;
        case 'timeline':
          result.timeline.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GCreateOrderData_createOrder_order_timeline),
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

class _$GCreateOrderData_createOrder_order_itemsSerializer
    implements StructuredSerializer<GCreateOrderData_createOrder_order_items> {
  @override
  final Iterable<Type> types = const [
    GCreateOrderData_createOrder_order_items,
    _$GCreateOrderData_createOrder_order_items,
  ];
  @override
  final String wireName = 'GCreateOrderData_createOrder_order_items';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateOrderData_createOrder_order_items object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'serviceId',
      serializers.serialize(
        object.serviceId,
        specifiedType: const FullType(String),
      ),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'priceCents',
      serializers.serialize(
        object.priceCents,
        specifiedType: const FullType(int),
      ),
    ];

    return result;
  }

  @override
  GCreateOrderData_createOrder_order_items deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateOrderData_createOrder_order_itemsBuilder();

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
        case 'serviceId':
          result.serviceId =
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
        case 'priceCents':
          result.priceCents =
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

class _$GCreateOrderData_createOrder_order_slotSerializer
    implements StructuredSerializer<GCreateOrderData_createOrder_order_slot> {
  @override
  final Iterable<Type> types = const [
    GCreateOrderData_createOrder_order_slot,
    _$GCreateOrderData_createOrder_order_slot,
  ];
  @override
  final String wireName = 'GCreateOrderData_createOrder_order_slot';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateOrderData_createOrder_order_slot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'slotId',
      serializers.serialize(
        object.slotId,
        specifiedType: const FullType(String),
      ),
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
    ];

    return result;
  }

  @override
  GCreateOrderData_createOrder_order_slot deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateOrderData_createOrder_order_slotBuilder();

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
        case 'slotId':
          result.slotId =
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
      }
    }

    return result.build();
  }
}

class _$GCreateOrderData_createOrder_order_cardSerializer
    implements StructuredSerializer<GCreateOrderData_createOrder_order_card> {
  @override
  final Iterable<Type> types = const [
    GCreateOrderData_createOrder_order_card,
    _$GCreateOrderData_createOrder_order_card,
  ];
  @override
  final String wireName = 'GCreateOrderData_createOrder_order_card';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateOrderData_createOrder_order_card object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'paymentMethodId',
      serializers.serialize(
        object.paymentMethodId,
        specifiedType: const FullType(String),
      ),
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
    ];

    return result;
  }

  @override
  GCreateOrderData_createOrder_order_card deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateOrderData_createOrder_order_cardBuilder();

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
        case 'paymentMethodId':
          result.paymentMethodId =
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
      }
    }

    return result.build();
  }
}

class _$GCreateOrderData_createOrder_order_timelineSerializer
    implements
        StructuredSerializer<GCreateOrderData_createOrder_order_timeline> {
  @override
  final Iterable<Type> types = const [
    GCreateOrderData_createOrder_order_timeline,
    _$GCreateOrderData_createOrder_order_timeline,
  ];
  @override
  final String wireName = 'GCreateOrderData_createOrder_order_timeline';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateOrderData_createOrder_order_timeline object, {
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
      'type',
      serializers.serialize(
        object.type,
        specifiedType: const FullType(_i2.GOrderEventType),
      ),
      'at',
      serializers.serialize(object.at, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GCreateOrderData_createOrder_order_timeline deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateOrderData_createOrder_order_timelineBuilder();

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
        case 'type':
          result.type =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GOrderEventType),
                  )!
                  as _i2.GOrderEventType;
          break;
        case 'at':
          result.at =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'message':
          result.message =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GOrderUpdatedDataSerializer
    implements StructuredSerializer<GOrderUpdatedData> {
  @override
  final Iterable<Type> types = const [GOrderUpdatedData, _$GOrderUpdatedData];
  @override
  final String wireName = 'GOrderUpdatedData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderUpdatedData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'orderUpdated',
      serializers.serialize(
        object.orderUpdated,
        specifiedType: const FullType(GOrderUpdatedData_orderUpdated),
      ),
    ];

    return result;
  }

  @override
  GOrderUpdatedData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderUpdatedDataBuilder();

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
        case 'orderUpdated':
          result.orderUpdated.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GOrderUpdatedData_orderUpdated),
                )!
                as GOrderUpdatedData_orderUpdated,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GOrderUpdatedData_orderUpdatedSerializer
    implements StructuredSerializer<GOrderUpdatedData_orderUpdated> {
  @override
  final Iterable<Type> types = const [
    GOrderUpdatedData_orderUpdated,
    _$GOrderUpdatedData_orderUpdated,
  ];
  @override
  final String wireName = 'GOrderUpdatedData_orderUpdated';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderUpdatedData_orderUpdated object, {
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
      'status',
      serializers.serialize(
        object.status,
        specifiedType: const FullType(_i2.GOrderStatus),
      ),
      'totalCents',
      serializers.serialize(
        object.totalCents,
        specifiedType: const FullType(int),
      ),
      'currency',
      serializers.serialize(
        object.currency,
        specifiedType: const FullType(String),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(String),
      ),
      'updatedAt',
      serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(String),
      ),
      'items',
      serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GOrderUpdatedData_orderUpdated_items),
        ]),
      ),
      'slot',
      serializers.serialize(
        object.slot,
        specifiedType: const FullType(GOrderUpdatedData_orderUpdated_slot),
      ),
      'card',
      serializers.serialize(
        object.card,
        specifiedType: const FullType(GOrderUpdatedData_orderUpdated_card),
      ),
      'timeline',
      serializers.serialize(
        object.timeline,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GOrderUpdatedData_orderUpdated_timeline),
        ]),
      ),
    ];

    return result;
  }

  @override
  GOrderUpdatedData_orderUpdated deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderUpdatedData_orderUpdatedBuilder();

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
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GOrderStatus),
                  )!
                  as _i2.GOrderStatus;
          break;
        case 'totalCents':
          result.totalCents =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'currency':
          result.currency =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'createdAt':
          result.createdAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'updatedAt':
          result.updatedAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'items':
          result.items.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GOrderUpdatedData_orderUpdated_items),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'slot':
          result.slot.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GOrderUpdatedData_orderUpdated_slot,
                  ),
                )!
                as GOrderUpdatedData_orderUpdated_slot,
          );
          break;
        case 'card':
          result.card.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GOrderUpdatedData_orderUpdated_card,
                  ),
                )!
                as GOrderUpdatedData_orderUpdated_card,
          );
          break;
        case 'timeline':
          result.timeline.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GOrderUpdatedData_orderUpdated_timeline),
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

class _$GOrderUpdatedData_orderUpdated_itemsSerializer
    implements StructuredSerializer<GOrderUpdatedData_orderUpdated_items> {
  @override
  final Iterable<Type> types = const [
    GOrderUpdatedData_orderUpdated_items,
    _$GOrderUpdatedData_orderUpdated_items,
  ];
  @override
  final String wireName = 'GOrderUpdatedData_orderUpdated_items';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderUpdatedData_orderUpdated_items object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'serviceId',
      serializers.serialize(
        object.serviceId,
        specifiedType: const FullType(String),
      ),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'priceCents',
      serializers.serialize(
        object.priceCents,
        specifiedType: const FullType(int),
      ),
    ];

    return result;
  }

  @override
  GOrderUpdatedData_orderUpdated_items deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderUpdatedData_orderUpdated_itemsBuilder();

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
        case 'serviceId':
          result.serviceId =
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
        case 'priceCents':
          result.priceCents =
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

class _$GOrderUpdatedData_orderUpdated_slotSerializer
    implements StructuredSerializer<GOrderUpdatedData_orderUpdated_slot> {
  @override
  final Iterable<Type> types = const [
    GOrderUpdatedData_orderUpdated_slot,
    _$GOrderUpdatedData_orderUpdated_slot,
  ];
  @override
  final String wireName = 'GOrderUpdatedData_orderUpdated_slot';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderUpdatedData_orderUpdated_slot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'slotId',
      serializers.serialize(
        object.slotId,
        specifiedType: const FullType(String),
      ),
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
    ];

    return result;
  }

  @override
  GOrderUpdatedData_orderUpdated_slot deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderUpdatedData_orderUpdated_slotBuilder();

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
        case 'slotId':
          result.slotId =
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
      }
    }

    return result.build();
  }
}

class _$GOrderUpdatedData_orderUpdated_cardSerializer
    implements StructuredSerializer<GOrderUpdatedData_orderUpdated_card> {
  @override
  final Iterable<Type> types = const [
    GOrderUpdatedData_orderUpdated_card,
    _$GOrderUpdatedData_orderUpdated_card,
  ];
  @override
  final String wireName = 'GOrderUpdatedData_orderUpdated_card';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderUpdatedData_orderUpdated_card object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'paymentMethodId',
      serializers.serialize(
        object.paymentMethodId,
        specifiedType: const FullType(String),
      ),
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
    ];

    return result;
  }

  @override
  GOrderUpdatedData_orderUpdated_card deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderUpdatedData_orderUpdated_cardBuilder();

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
        case 'paymentMethodId':
          result.paymentMethodId =
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
      }
    }

    return result.build();
  }
}

class _$GOrderUpdatedData_orderUpdated_timelineSerializer
    implements StructuredSerializer<GOrderUpdatedData_orderUpdated_timeline> {
  @override
  final Iterable<Type> types = const [
    GOrderUpdatedData_orderUpdated_timeline,
    _$GOrderUpdatedData_orderUpdated_timeline,
  ];
  @override
  final String wireName = 'GOrderUpdatedData_orderUpdated_timeline';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderUpdatedData_orderUpdated_timeline object, {
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
      'type',
      serializers.serialize(
        object.type,
        specifiedType: const FullType(_i2.GOrderEventType),
      ),
      'at',
      serializers.serialize(object.at, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GOrderUpdatedData_orderUpdated_timeline deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderUpdatedData_orderUpdated_timelineBuilder();

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
        case 'type':
          result.type =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GOrderEventType),
                  )!
                  as _i2.GOrderEventType;
          break;
        case 'at':
          result.at =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'message':
          result.message =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GOrderFieldsDataSerializer
    implements StructuredSerializer<GOrderFieldsData> {
  @override
  final Iterable<Type> types = const [GOrderFieldsData, _$GOrderFieldsData];
  @override
  final String wireName = 'GOrderFieldsData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderFieldsData object, {
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
      'status',
      serializers.serialize(
        object.status,
        specifiedType: const FullType(_i2.GOrderStatus),
      ),
      'totalCents',
      serializers.serialize(
        object.totalCents,
        specifiedType: const FullType(int),
      ),
      'currency',
      serializers.serialize(
        object.currency,
        specifiedType: const FullType(String),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(String),
      ),
      'updatedAt',
      serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(String),
      ),
      'items',
      serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GOrderFieldsData_items),
        ]),
      ),
      'slot',
      serializers.serialize(
        object.slot,
        specifiedType: const FullType(GOrderFieldsData_slot),
      ),
      'card',
      serializers.serialize(
        object.card,
        specifiedType: const FullType(GOrderFieldsData_card),
      ),
      'timeline',
      serializers.serialize(
        object.timeline,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GOrderFieldsData_timeline),
        ]),
      ),
    ];

    return result;
  }

  @override
  GOrderFieldsData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderFieldsDataBuilder();

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
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GOrderStatus),
                  )!
                  as _i2.GOrderStatus;
          break;
        case 'totalCents':
          result.totalCents =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'currency':
          result.currency =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'createdAt':
          result.createdAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'updatedAt':
          result.updatedAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'items':
          result.items.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GOrderFieldsData_items),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'slot':
          result.slot.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GOrderFieldsData_slot),
                )!
                as GOrderFieldsData_slot,
          );
          break;
        case 'card':
          result.card.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GOrderFieldsData_card),
                )!
                as GOrderFieldsData_card,
          );
          break;
        case 'timeline':
          result.timeline.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GOrderFieldsData_timeline),
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

class _$GOrderFieldsData_itemsSerializer
    implements StructuredSerializer<GOrderFieldsData_items> {
  @override
  final Iterable<Type> types = const [
    GOrderFieldsData_items,
    _$GOrderFieldsData_items,
  ];
  @override
  final String wireName = 'GOrderFieldsData_items';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderFieldsData_items object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'serviceId',
      serializers.serialize(
        object.serviceId,
        specifiedType: const FullType(String),
      ),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'priceCents',
      serializers.serialize(
        object.priceCents,
        specifiedType: const FullType(int),
      ),
    ];

    return result;
  }

  @override
  GOrderFieldsData_items deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderFieldsData_itemsBuilder();

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
        case 'serviceId':
          result.serviceId =
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
        case 'priceCents':
          result.priceCents =
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

class _$GOrderFieldsData_slotSerializer
    implements StructuredSerializer<GOrderFieldsData_slot> {
  @override
  final Iterable<Type> types = const [
    GOrderFieldsData_slot,
    _$GOrderFieldsData_slot,
  ];
  @override
  final String wireName = 'GOrderFieldsData_slot';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderFieldsData_slot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'slotId',
      serializers.serialize(
        object.slotId,
        specifiedType: const FullType(String),
      ),
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
    ];

    return result;
  }

  @override
  GOrderFieldsData_slot deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderFieldsData_slotBuilder();

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
        case 'slotId':
          result.slotId =
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
      }
    }

    return result.build();
  }
}

class _$GOrderFieldsData_cardSerializer
    implements StructuredSerializer<GOrderFieldsData_card> {
  @override
  final Iterable<Type> types = const [
    GOrderFieldsData_card,
    _$GOrderFieldsData_card,
  ];
  @override
  final String wireName = 'GOrderFieldsData_card';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderFieldsData_card object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'paymentMethodId',
      serializers.serialize(
        object.paymentMethodId,
        specifiedType: const FullType(String),
      ),
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
    ];

    return result;
  }

  @override
  GOrderFieldsData_card deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderFieldsData_cardBuilder();

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
        case 'paymentMethodId':
          result.paymentMethodId =
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
      }
    }

    return result.build();
  }
}

class _$GOrderFieldsData_timelineSerializer
    implements StructuredSerializer<GOrderFieldsData_timeline> {
  @override
  final Iterable<Type> types = const [
    GOrderFieldsData_timeline,
    _$GOrderFieldsData_timeline,
  ];
  @override
  final String wireName = 'GOrderFieldsData_timeline';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GOrderFieldsData_timeline object, {
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
      'type',
      serializers.serialize(
        object.type,
        specifiedType: const FullType(_i2.GOrderEventType),
      ),
      'at',
      serializers.serialize(object.at, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GOrderFieldsData_timeline deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GOrderFieldsData_timelineBuilder();

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
        case 'type':
          result.type =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GOrderEventType),
                  )!
                  as _i2.GOrderEventType;
          break;
        case 'at':
          result.at =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'message':
          result.message =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GOrderDetailsData extends GOrderDetailsData {
  @override
  final String G__typename;
  @override
  final GOrderDetailsData_order? order;

  factory _$GOrderDetailsData([
    void Function(GOrderDetailsDataBuilder)? updates,
  ]) => (GOrderDetailsDataBuilder()..update(updates))._build();

  _$GOrderDetailsData._({required this.G__typename, this.order}) : super._();
  @override
  GOrderDetailsData rebuild(void Function(GOrderDetailsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GOrderDetailsDataBuilder toBuilder() =>
      GOrderDetailsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderDetailsData &&
        G__typename == other.G__typename &&
        order == other.order;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, order.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderDetailsData')
          ..add('G__typename', G__typename)
          ..add('order', order))
        .toString();
  }
}

class GOrderDetailsDataBuilder
    implements Builder<GOrderDetailsData, GOrderDetailsDataBuilder> {
  _$GOrderDetailsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GOrderDetailsData_orderBuilder? _order;
  GOrderDetailsData_orderBuilder get order =>
      _$this._order ??= GOrderDetailsData_orderBuilder();
  set order(GOrderDetailsData_orderBuilder? order) => _$this._order = order;

  GOrderDetailsDataBuilder() {
    GOrderDetailsData._initializeBuilder(this);
  }

  GOrderDetailsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _order = $v.order?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderDetailsData other) {
    _$v = other as _$GOrderDetailsData;
  }

  @override
  void update(void Function(GOrderDetailsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderDetailsData build() => _build();

  _$GOrderDetailsData _build() {
    _$GOrderDetailsData _$result;
    try {
      _$result =
          _$v ??
          _$GOrderDetailsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GOrderDetailsData',
              'G__typename',
            ),
            order: _order?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'order';
        _order?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GOrderDetailsData',
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

class _$GOrderDetailsData_order extends GOrderDetailsData_order {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GOrderStatus status;
  @override
  final int totalCents;
  @override
  final String currency;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final BuiltList<GOrderDetailsData_order_items> items;
  @override
  final GOrderDetailsData_order_slot slot;
  @override
  final GOrderDetailsData_order_card card;
  @override
  final BuiltList<GOrderDetailsData_order_timeline> timeline;

  factory _$GOrderDetailsData_order([
    void Function(GOrderDetailsData_orderBuilder)? updates,
  ]) => (GOrderDetailsData_orderBuilder()..update(updates))._build();

  _$GOrderDetailsData_order._({
    required this.G__typename,
    required this.id,
    required this.status,
    required this.totalCents,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.slot,
    required this.card,
    required this.timeline,
  }) : super._();
  @override
  GOrderDetailsData_order rebuild(
    void Function(GOrderDetailsData_orderBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderDetailsData_orderBuilder toBuilder() =>
      GOrderDetailsData_orderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderDetailsData_order &&
        G__typename == other.G__typename &&
        id == other.id &&
        status == other.status &&
        totalCents == other.totalCents &&
        currency == other.currency &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        items == other.items &&
        slot == other.slot &&
        card == other.card &&
        timeline == other.timeline;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, totalCents.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, slot.hashCode);
    _$hash = $jc(_$hash, card.hashCode);
    _$hash = $jc(_$hash, timeline.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderDetailsData_order')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('status', status)
          ..add('totalCents', totalCents)
          ..add('currency', currency)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('items', items)
          ..add('slot', slot)
          ..add('card', card)
          ..add('timeline', timeline))
        .toString();
  }
}

class GOrderDetailsData_orderBuilder
    implements
        Builder<GOrderDetailsData_order, GOrderDetailsData_orderBuilder> {
  _$GOrderDetailsData_order? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GOrderStatus? _status;
  _i2.GOrderStatus? get status => _$this._status;
  set status(_i2.GOrderStatus? status) => _$this._status = status;

  int? _totalCents;
  int? get totalCents => _$this._totalCents;
  set totalCents(int? totalCents) => _$this._totalCents = totalCents;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  ListBuilder<GOrderDetailsData_order_items>? _items;
  ListBuilder<GOrderDetailsData_order_items> get items =>
      _$this._items ??= ListBuilder<GOrderDetailsData_order_items>();
  set items(ListBuilder<GOrderDetailsData_order_items>? items) =>
      _$this._items = items;

  GOrderDetailsData_order_slotBuilder? _slot;
  GOrderDetailsData_order_slotBuilder get slot =>
      _$this._slot ??= GOrderDetailsData_order_slotBuilder();
  set slot(GOrderDetailsData_order_slotBuilder? slot) => _$this._slot = slot;

  GOrderDetailsData_order_cardBuilder? _card;
  GOrderDetailsData_order_cardBuilder get card =>
      _$this._card ??= GOrderDetailsData_order_cardBuilder();
  set card(GOrderDetailsData_order_cardBuilder? card) => _$this._card = card;

  ListBuilder<GOrderDetailsData_order_timeline>? _timeline;
  ListBuilder<GOrderDetailsData_order_timeline> get timeline =>
      _$this._timeline ??= ListBuilder<GOrderDetailsData_order_timeline>();
  set timeline(ListBuilder<GOrderDetailsData_order_timeline>? timeline) =>
      _$this._timeline = timeline;

  GOrderDetailsData_orderBuilder() {
    GOrderDetailsData_order._initializeBuilder(this);
  }

  GOrderDetailsData_orderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _status = $v.status;
      _totalCents = $v.totalCents;
      _currency = $v.currency;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _items = $v.items.toBuilder();
      _slot = $v.slot.toBuilder();
      _card = $v.card.toBuilder();
      _timeline = $v.timeline.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderDetailsData_order other) {
    _$v = other as _$GOrderDetailsData_order;
  }

  @override
  void update(void Function(GOrderDetailsData_orderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderDetailsData_order build() => _build();

  _$GOrderDetailsData_order _build() {
    _$GOrderDetailsData_order _$result;
    try {
      _$result =
          _$v ??
          _$GOrderDetailsData_order._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GOrderDetailsData_order',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GOrderDetailsData_order',
              'id',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GOrderDetailsData_order',
              'status',
            ),
            totalCents: BuiltValueNullFieldError.checkNotNull(
              totalCents,
              r'GOrderDetailsData_order',
              'totalCents',
            ),
            currency: BuiltValueNullFieldError.checkNotNull(
              currency,
              r'GOrderDetailsData_order',
              'currency',
            ),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'GOrderDetailsData_order',
              'createdAt',
            ),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt,
              r'GOrderDetailsData_order',
              'updatedAt',
            ),
            items: items.build(),
            slot: slot.build(),
            card: card.build(),
            timeline: timeline.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
        _$failedField = 'slot';
        slot.build();
        _$failedField = 'card';
        card.build();
        _$failedField = 'timeline';
        timeline.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GOrderDetailsData_order',
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

class _$GOrderDetailsData_order_items extends GOrderDetailsData_order_items {
  @override
  final String G__typename;
  @override
  final String serviceId;
  @override
  final String name;
  @override
  final int priceCents;

  factory _$GOrderDetailsData_order_items([
    void Function(GOrderDetailsData_order_itemsBuilder)? updates,
  ]) => (GOrderDetailsData_order_itemsBuilder()..update(updates))._build();

  _$GOrderDetailsData_order_items._({
    required this.G__typename,
    required this.serviceId,
    required this.name,
    required this.priceCents,
  }) : super._();
  @override
  GOrderDetailsData_order_items rebuild(
    void Function(GOrderDetailsData_order_itemsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderDetailsData_order_itemsBuilder toBuilder() =>
      GOrderDetailsData_order_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderDetailsData_order_items &&
        G__typename == other.G__typename &&
        serviceId == other.serviceId &&
        name == other.name &&
        priceCents == other.priceCents;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, serviceId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, priceCents.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderDetailsData_order_items')
          ..add('G__typename', G__typename)
          ..add('serviceId', serviceId)
          ..add('name', name)
          ..add('priceCents', priceCents))
        .toString();
  }
}

class GOrderDetailsData_order_itemsBuilder
    implements
        Builder<
          GOrderDetailsData_order_items,
          GOrderDetailsData_order_itemsBuilder
        > {
  _$GOrderDetailsData_order_items? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _serviceId;
  String? get serviceId => _$this._serviceId;
  set serviceId(String? serviceId) => _$this._serviceId = serviceId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _priceCents;
  int? get priceCents => _$this._priceCents;
  set priceCents(int? priceCents) => _$this._priceCents = priceCents;

  GOrderDetailsData_order_itemsBuilder() {
    GOrderDetailsData_order_items._initializeBuilder(this);
  }

  GOrderDetailsData_order_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _serviceId = $v.serviceId;
      _name = $v.name;
      _priceCents = $v.priceCents;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderDetailsData_order_items other) {
    _$v = other as _$GOrderDetailsData_order_items;
  }

  @override
  void update(void Function(GOrderDetailsData_order_itemsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderDetailsData_order_items build() => _build();

  _$GOrderDetailsData_order_items _build() {
    final _$result =
        _$v ??
        _$GOrderDetailsData_order_items._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GOrderDetailsData_order_items',
            'G__typename',
          ),
          serviceId: BuiltValueNullFieldError.checkNotNull(
            serviceId,
            r'GOrderDetailsData_order_items',
            'serviceId',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GOrderDetailsData_order_items',
            'name',
          ),
          priceCents: BuiltValueNullFieldError.checkNotNull(
            priceCents,
            r'GOrderDetailsData_order_items',
            'priceCents',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GOrderDetailsData_order_slot extends GOrderDetailsData_order_slot {
  @override
  final String G__typename;
  @override
  final String slotId;
  @override
  final String startsAt;
  @override
  final String endsAt;

  factory _$GOrderDetailsData_order_slot([
    void Function(GOrderDetailsData_order_slotBuilder)? updates,
  ]) => (GOrderDetailsData_order_slotBuilder()..update(updates))._build();

  _$GOrderDetailsData_order_slot._({
    required this.G__typename,
    required this.slotId,
    required this.startsAt,
    required this.endsAt,
  }) : super._();
  @override
  GOrderDetailsData_order_slot rebuild(
    void Function(GOrderDetailsData_order_slotBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderDetailsData_order_slotBuilder toBuilder() =>
      GOrderDetailsData_order_slotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderDetailsData_order_slot &&
        G__typename == other.G__typename &&
        slotId == other.slotId &&
        startsAt == other.startsAt &&
        endsAt == other.endsAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, slotId.hashCode);
    _$hash = $jc(_$hash, startsAt.hashCode);
    _$hash = $jc(_$hash, endsAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderDetailsData_order_slot')
          ..add('G__typename', G__typename)
          ..add('slotId', slotId)
          ..add('startsAt', startsAt)
          ..add('endsAt', endsAt))
        .toString();
  }
}

class GOrderDetailsData_order_slotBuilder
    implements
        Builder<
          GOrderDetailsData_order_slot,
          GOrderDetailsData_order_slotBuilder
        > {
  _$GOrderDetailsData_order_slot? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _slotId;
  String? get slotId => _$this._slotId;
  set slotId(String? slotId) => _$this._slotId = slotId;

  String? _startsAt;
  String? get startsAt => _$this._startsAt;
  set startsAt(String? startsAt) => _$this._startsAt = startsAt;

  String? _endsAt;
  String? get endsAt => _$this._endsAt;
  set endsAt(String? endsAt) => _$this._endsAt = endsAt;

  GOrderDetailsData_order_slotBuilder() {
    GOrderDetailsData_order_slot._initializeBuilder(this);
  }

  GOrderDetailsData_order_slotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _slotId = $v.slotId;
      _startsAt = $v.startsAt;
      _endsAt = $v.endsAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderDetailsData_order_slot other) {
    _$v = other as _$GOrderDetailsData_order_slot;
  }

  @override
  void update(void Function(GOrderDetailsData_order_slotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderDetailsData_order_slot build() => _build();

  _$GOrderDetailsData_order_slot _build() {
    final _$result =
        _$v ??
        _$GOrderDetailsData_order_slot._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GOrderDetailsData_order_slot',
            'G__typename',
          ),
          slotId: BuiltValueNullFieldError.checkNotNull(
            slotId,
            r'GOrderDetailsData_order_slot',
            'slotId',
          ),
          startsAt: BuiltValueNullFieldError.checkNotNull(
            startsAt,
            r'GOrderDetailsData_order_slot',
            'startsAt',
          ),
          endsAt: BuiltValueNullFieldError.checkNotNull(
            endsAt,
            r'GOrderDetailsData_order_slot',
            'endsAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GOrderDetailsData_order_card extends GOrderDetailsData_order_card {
  @override
  final String G__typename;
  @override
  final String paymentMethodId;
  @override
  final _i2.GCardBrand brand;
  @override
  final String last4;

  factory _$GOrderDetailsData_order_card([
    void Function(GOrderDetailsData_order_cardBuilder)? updates,
  ]) => (GOrderDetailsData_order_cardBuilder()..update(updates))._build();

  _$GOrderDetailsData_order_card._({
    required this.G__typename,
    required this.paymentMethodId,
    required this.brand,
    required this.last4,
  }) : super._();
  @override
  GOrderDetailsData_order_card rebuild(
    void Function(GOrderDetailsData_order_cardBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderDetailsData_order_cardBuilder toBuilder() =>
      GOrderDetailsData_order_cardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderDetailsData_order_card &&
        G__typename == other.G__typename &&
        paymentMethodId == other.paymentMethodId &&
        brand == other.brand &&
        last4 == other.last4;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, paymentMethodId.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, last4.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderDetailsData_order_card')
          ..add('G__typename', G__typename)
          ..add('paymentMethodId', paymentMethodId)
          ..add('brand', brand)
          ..add('last4', last4))
        .toString();
  }
}

class GOrderDetailsData_order_cardBuilder
    implements
        Builder<
          GOrderDetailsData_order_card,
          GOrderDetailsData_order_cardBuilder
        > {
  _$GOrderDetailsData_order_card? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _paymentMethodId;
  String? get paymentMethodId => _$this._paymentMethodId;
  set paymentMethodId(String? paymentMethodId) =>
      _$this._paymentMethodId = paymentMethodId;

  _i2.GCardBrand? _brand;
  _i2.GCardBrand? get brand => _$this._brand;
  set brand(_i2.GCardBrand? brand) => _$this._brand = brand;

  String? _last4;
  String? get last4 => _$this._last4;
  set last4(String? last4) => _$this._last4 = last4;

  GOrderDetailsData_order_cardBuilder() {
    GOrderDetailsData_order_card._initializeBuilder(this);
  }

  GOrderDetailsData_order_cardBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _paymentMethodId = $v.paymentMethodId;
      _brand = $v.brand;
      _last4 = $v.last4;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderDetailsData_order_card other) {
    _$v = other as _$GOrderDetailsData_order_card;
  }

  @override
  void update(void Function(GOrderDetailsData_order_cardBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderDetailsData_order_card build() => _build();

  _$GOrderDetailsData_order_card _build() {
    final _$result =
        _$v ??
        _$GOrderDetailsData_order_card._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GOrderDetailsData_order_card',
            'G__typename',
          ),
          paymentMethodId: BuiltValueNullFieldError.checkNotNull(
            paymentMethodId,
            r'GOrderDetailsData_order_card',
            'paymentMethodId',
          ),
          brand: BuiltValueNullFieldError.checkNotNull(
            brand,
            r'GOrderDetailsData_order_card',
            'brand',
          ),
          last4: BuiltValueNullFieldError.checkNotNull(
            last4,
            r'GOrderDetailsData_order_card',
            'last4',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GOrderDetailsData_order_timeline
    extends GOrderDetailsData_order_timeline {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GOrderEventType type;
  @override
  final String at;
  @override
  final String? message;

  factory _$GOrderDetailsData_order_timeline([
    void Function(GOrderDetailsData_order_timelineBuilder)? updates,
  ]) => (GOrderDetailsData_order_timelineBuilder()..update(updates))._build();

  _$GOrderDetailsData_order_timeline._({
    required this.G__typename,
    required this.id,
    required this.type,
    required this.at,
    this.message,
  }) : super._();
  @override
  GOrderDetailsData_order_timeline rebuild(
    void Function(GOrderDetailsData_order_timelineBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderDetailsData_order_timelineBuilder toBuilder() =>
      GOrderDetailsData_order_timelineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderDetailsData_order_timeline &&
        G__typename == other.G__typename &&
        id == other.id &&
        type == other.type &&
        at == other.at &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, at.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderDetailsData_order_timeline')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('type', type)
          ..add('at', at)
          ..add('message', message))
        .toString();
  }
}

class GOrderDetailsData_order_timelineBuilder
    implements
        Builder<
          GOrderDetailsData_order_timeline,
          GOrderDetailsData_order_timelineBuilder
        > {
  _$GOrderDetailsData_order_timeline? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GOrderEventType? _type;
  _i2.GOrderEventType? get type => _$this._type;
  set type(_i2.GOrderEventType? type) => _$this._type = type;

  String? _at;
  String? get at => _$this._at;
  set at(String? at) => _$this._at = at;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GOrderDetailsData_order_timelineBuilder() {
    GOrderDetailsData_order_timeline._initializeBuilder(this);
  }

  GOrderDetailsData_order_timelineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _type = $v.type;
      _at = $v.at;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderDetailsData_order_timeline other) {
    _$v = other as _$GOrderDetailsData_order_timeline;
  }

  @override
  void update(void Function(GOrderDetailsData_order_timelineBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderDetailsData_order_timeline build() => _build();

  _$GOrderDetailsData_order_timeline _build() {
    final _$result =
        _$v ??
        _$GOrderDetailsData_order_timeline._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GOrderDetailsData_order_timeline',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GOrderDetailsData_order_timeline',
            'id',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'GOrderDetailsData_order_timeline',
            'type',
          ),
          at: BuiltValueNullFieldError.checkNotNull(
            at,
            r'GOrderDetailsData_order_timeline',
            'at',
          ),
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateOrderData extends GCreateOrderData {
  @override
  final String G__typename;
  @override
  final GCreateOrderData_createOrder createOrder;

  factory _$GCreateOrderData([
    void Function(GCreateOrderDataBuilder)? updates,
  ]) => (GCreateOrderDataBuilder()..update(updates))._build();

  _$GCreateOrderData._({required this.G__typename, required this.createOrder})
    : super._();
  @override
  GCreateOrderData rebuild(void Function(GCreateOrderDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateOrderDataBuilder toBuilder() =>
      GCreateOrderDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateOrderData &&
        G__typename == other.G__typename &&
        createOrder == other.createOrder;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createOrder.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateOrderData')
          ..add('G__typename', G__typename)
          ..add('createOrder', createOrder))
        .toString();
  }
}

class GCreateOrderDataBuilder
    implements Builder<GCreateOrderData, GCreateOrderDataBuilder> {
  _$GCreateOrderData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreateOrderData_createOrderBuilder? _createOrder;
  GCreateOrderData_createOrderBuilder get createOrder =>
      _$this._createOrder ??= GCreateOrderData_createOrderBuilder();
  set createOrder(GCreateOrderData_createOrderBuilder? createOrder) =>
      _$this._createOrder = createOrder;

  GCreateOrderDataBuilder() {
    GCreateOrderData._initializeBuilder(this);
  }

  GCreateOrderDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createOrder = $v.createOrder.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateOrderData other) {
    _$v = other as _$GCreateOrderData;
  }

  @override
  void update(void Function(GCreateOrderDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateOrderData build() => _build();

  _$GCreateOrderData _build() {
    _$GCreateOrderData _$result;
    try {
      _$result =
          _$v ??
          _$GCreateOrderData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GCreateOrderData',
              'G__typename',
            ),
            createOrder: createOrder.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createOrder';
        createOrder.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GCreateOrderData',
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

class _$GCreateOrderData_createOrder extends GCreateOrderData_createOrder {
  @override
  final String G__typename;
  @override
  final bool replayed;
  @override
  final GCreateOrderData_createOrder_order order;

  factory _$GCreateOrderData_createOrder([
    void Function(GCreateOrderData_createOrderBuilder)? updates,
  ]) => (GCreateOrderData_createOrderBuilder()..update(updates))._build();

  _$GCreateOrderData_createOrder._({
    required this.G__typename,
    required this.replayed,
    required this.order,
  }) : super._();
  @override
  GCreateOrderData_createOrder rebuild(
    void Function(GCreateOrderData_createOrderBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateOrderData_createOrderBuilder toBuilder() =>
      GCreateOrderData_createOrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateOrderData_createOrder &&
        G__typename == other.G__typename &&
        replayed == other.replayed &&
        order == other.order;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, replayed.hashCode);
    _$hash = $jc(_$hash, order.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateOrderData_createOrder')
          ..add('G__typename', G__typename)
          ..add('replayed', replayed)
          ..add('order', order))
        .toString();
  }
}

class GCreateOrderData_createOrderBuilder
    implements
        Builder<
          GCreateOrderData_createOrder,
          GCreateOrderData_createOrderBuilder
        > {
  _$GCreateOrderData_createOrder? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _replayed;
  bool? get replayed => _$this._replayed;
  set replayed(bool? replayed) => _$this._replayed = replayed;

  GCreateOrderData_createOrder_orderBuilder? _order;
  GCreateOrderData_createOrder_orderBuilder get order =>
      _$this._order ??= GCreateOrderData_createOrder_orderBuilder();
  set order(GCreateOrderData_createOrder_orderBuilder? order) =>
      _$this._order = order;

  GCreateOrderData_createOrderBuilder() {
    GCreateOrderData_createOrder._initializeBuilder(this);
  }

  GCreateOrderData_createOrderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _replayed = $v.replayed;
      _order = $v.order.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateOrderData_createOrder other) {
    _$v = other as _$GCreateOrderData_createOrder;
  }

  @override
  void update(void Function(GCreateOrderData_createOrderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateOrderData_createOrder build() => _build();

  _$GCreateOrderData_createOrder _build() {
    _$GCreateOrderData_createOrder _$result;
    try {
      _$result =
          _$v ??
          _$GCreateOrderData_createOrder._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GCreateOrderData_createOrder',
              'G__typename',
            ),
            replayed: BuiltValueNullFieldError.checkNotNull(
              replayed,
              r'GCreateOrderData_createOrder',
              'replayed',
            ),
            order: order.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'order';
        order.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GCreateOrderData_createOrder',
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

class _$GCreateOrderData_createOrder_order
    extends GCreateOrderData_createOrder_order {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GOrderStatus status;
  @override
  final int totalCents;
  @override
  final String currency;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final BuiltList<GCreateOrderData_createOrder_order_items> items;
  @override
  final GCreateOrderData_createOrder_order_slot slot;
  @override
  final GCreateOrderData_createOrder_order_card card;
  @override
  final BuiltList<GCreateOrderData_createOrder_order_timeline> timeline;

  factory _$GCreateOrderData_createOrder_order([
    void Function(GCreateOrderData_createOrder_orderBuilder)? updates,
  ]) => (GCreateOrderData_createOrder_orderBuilder()..update(updates))._build();

  _$GCreateOrderData_createOrder_order._({
    required this.G__typename,
    required this.id,
    required this.status,
    required this.totalCents,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.slot,
    required this.card,
    required this.timeline,
  }) : super._();
  @override
  GCreateOrderData_createOrder_order rebuild(
    void Function(GCreateOrderData_createOrder_orderBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateOrderData_createOrder_orderBuilder toBuilder() =>
      GCreateOrderData_createOrder_orderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateOrderData_createOrder_order &&
        G__typename == other.G__typename &&
        id == other.id &&
        status == other.status &&
        totalCents == other.totalCents &&
        currency == other.currency &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        items == other.items &&
        slot == other.slot &&
        card == other.card &&
        timeline == other.timeline;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, totalCents.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, slot.hashCode);
    _$hash = $jc(_$hash, card.hashCode);
    _$hash = $jc(_$hash, timeline.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateOrderData_createOrder_order')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('status', status)
          ..add('totalCents', totalCents)
          ..add('currency', currency)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('items', items)
          ..add('slot', slot)
          ..add('card', card)
          ..add('timeline', timeline))
        .toString();
  }
}

class GCreateOrderData_createOrder_orderBuilder
    implements
        Builder<
          GCreateOrderData_createOrder_order,
          GCreateOrderData_createOrder_orderBuilder
        > {
  _$GCreateOrderData_createOrder_order? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GOrderStatus? _status;
  _i2.GOrderStatus? get status => _$this._status;
  set status(_i2.GOrderStatus? status) => _$this._status = status;

  int? _totalCents;
  int? get totalCents => _$this._totalCents;
  set totalCents(int? totalCents) => _$this._totalCents = totalCents;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  ListBuilder<GCreateOrderData_createOrder_order_items>? _items;
  ListBuilder<GCreateOrderData_createOrder_order_items> get items =>
      _$this._items ??= ListBuilder<GCreateOrderData_createOrder_order_items>();
  set items(ListBuilder<GCreateOrderData_createOrder_order_items>? items) =>
      _$this._items = items;

  GCreateOrderData_createOrder_order_slotBuilder? _slot;
  GCreateOrderData_createOrder_order_slotBuilder get slot =>
      _$this._slot ??= GCreateOrderData_createOrder_order_slotBuilder();
  set slot(GCreateOrderData_createOrder_order_slotBuilder? slot) =>
      _$this._slot = slot;

  GCreateOrderData_createOrder_order_cardBuilder? _card;
  GCreateOrderData_createOrder_order_cardBuilder get card =>
      _$this._card ??= GCreateOrderData_createOrder_order_cardBuilder();
  set card(GCreateOrderData_createOrder_order_cardBuilder? card) =>
      _$this._card = card;

  ListBuilder<GCreateOrderData_createOrder_order_timeline>? _timeline;
  ListBuilder<GCreateOrderData_createOrder_order_timeline> get timeline =>
      _$this._timeline ??=
          ListBuilder<GCreateOrderData_createOrder_order_timeline>();
  set timeline(
    ListBuilder<GCreateOrderData_createOrder_order_timeline>? timeline,
  ) => _$this._timeline = timeline;

  GCreateOrderData_createOrder_orderBuilder() {
    GCreateOrderData_createOrder_order._initializeBuilder(this);
  }

  GCreateOrderData_createOrder_orderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _status = $v.status;
      _totalCents = $v.totalCents;
      _currency = $v.currency;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _items = $v.items.toBuilder();
      _slot = $v.slot.toBuilder();
      _card = $v.card.toBuilder();
      _timeline = $v.timeline.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateOrderData_createOrder_order other) {
    _$v = other as _$GCreateOrderData_createOrder_order;
  }

  @override
  void update(
    void Function(GCreateOrderData_createOrder_orderBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GCreateOrderData_createOrder_order build() => _build();

  _$GCreateOrderData_createOrder_order _build() {
    _$GCreateOrderData_createOrder_order _$result;
    try {
      _$result =
          _$v ??
          _$GCreateOrderData_createOrder_order._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GCreateOrderData_createOrder_order',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GCreateOrderData_createOrder_order',
              'id',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GCreateOrderData_createOrder_order',
              'status',
            ),
            totalCents: BuiltValueNullFieldError.checkNotNull(
              totalCents,
              r'GCreateOrderData_createOrder_order',
              'totalCents',
            ),
            currency: BuiltValueNullFieldError.checkNotNull(
              currency,
              r'GCreateOrderData_createOrder_order',
              'currency',
            ),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'GCreateOrderData_createOrder_order',
              'createdAt',
            ),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt,
              r'GCreateOrderData_createOrder_order',
              'updatedAt',
            ),
            items: items.build(),
            slot: slot.build(),
            card: card.build(),
            timeline: timeline.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
        _$failedField = 'slot';
        slot.build();
        _$failedField = 'card';
        card.build();
        _$failedField = 'timeline';
        timeline.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GCreateOrderData_createOrder_order',
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

class _$GCreateOrderData_createOrder_order_items
    extends GCreateOrderData_createOrder_order_items {
  @override
  final String G__typename;
  @override
  final String serviceId;
  @override
  final String name;
  @override
  final int priceCents;

  factory _$GCreateOrderData_createOrder_order_items([
    void Function(GCreateOrderData_createOrder_order_itemsBuilder)? updates,
  ]) => (GCreateOrderData_createOrder_order_itemsBuilder()..update(updates))
      ._build();

  _$GCreateOrderData_createOrder_order_items._({
    required this.G__typename,
    required this.serviceId,
    required this.name,
    required this.priceCents,
  }) : super._();
  @override
  GCreateOrderData_createOrder_order_items rebuild(
    void Function(GCreateOrderData_createOrder_order_itemsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateOrderData_createOrder_order_itemsBuilder toBuilder() =>
      GCreateOrderData_createOrder_order_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateOrderData_createOrder_order_items &&
        G__typename == other.G__typename &&
        serviceId == other.serviceId &&
        name == other.name &&
        priceCents == other.priceCents;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, serviceId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, priceCents.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GCreateOrderData_createOrder_order_items',
          )
          ..add('G__typename', G__typename)
          ..add('serviceId', serviceId)
          ..add('name', name)
          ..add('priceCents', priceCents))
        .toString();
  }
}

class GCreateOrderData_createOrder_order_itemsBuilder
    implements
        Builder<
          GCreateOrderData_createOrder_order_items,
          GCreateOrderData_createOrder_order_itemsBuilder
        > {
  _$GCreateOrderData_createOrder_order_items? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _serviceId;
  String? get serviceId => _$this._serviceId;
  set serviceId(String? serviceId) => _$this._serviceId = serviceId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _priceCents;
  int? get priceCents => _$this._priceCents;
  set priceCents(int? priceCents) => _$this._priceCents = priceCents;

  GCreateOrderData_createOrder_order_itemsBuilder() {
    GCreateOrderData_createOrder_order_items._initializeBuilder(this);
  }

  GCreateOrderData_createOrder_order_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _serviceId = $v.serviceId;
      _name = $v.name;
      _priceCents = $v.priceCents;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateOrderData_createOrder_order_items other) {
    _$v = other as _$GCreateOrderData_createOrder_order_items;
  }

  @override
  void update(
    void Function(GCreateOrderData_createOrder_order_itemsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GCreateOrderData_createOrder_order_items build() => _build();

  _$GCreateOrderData_createOrder_order_items _build() {
    final _$result =
        _$v ??
        _$GCreateOrderData_createOrder_order_items._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GCreateOrderData_createOrder_order_items',
            'G__typename',
          ),
          serviceId: BuiltValueNullFieldError.checkNotNull(
            serviceId,
            r'GCreateOrderData_createOrder_order_items',
            'serviceId',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GCreateOrderData_createOrder_order_items',
            'name',
          ),
          priceCents: BuiltValueNullFieldError.checkNotNull(
            priceCents,
            r'GCreateOrderData_createOrder_order_items',
            'priceCents',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateOrderData_createOrder_order_slot
    extends GCreateOrderData_createOrder_order_slot {
  @override
  final String G__typename;
  @override
  final String slotId;
  @override
  final String startsAt;
  @override
  final String endsAt;

  factory _$GCreateOrderData_createOrder_order_slot([
    void Function(GCreateOrderData_createOrder_order_slotBuilder)? updates,
  ]) => (GCreateOrderData_createOrder_order_slotBuilder()..update(updates))
      ._build();

  _$GCreateOrderData_createOrder_order_slot._({
    required this.G__typename,
    required this.slotId,
    required this.startsAt,
    required this.endsAt,
  }) : super._();
  @override
  GCreateOrderData_createOrder_order_slot rebuild(
    void Function(GCreateOrderData_createOrder_order_slotBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateOrderData_createOrder_order_slotBuilder toBuilder() =>
      GCreateOrderData_createOrder_order_slotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateOrderData_createOrder_order_slot &&
        G__typename == other.G__typename &&
        slotId == other.slotId &&
        startsAt == other.startsAt &&
        endsAt == other.endsAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, slotId.hashCode);
    _$hash = $jc(_$hash, startsAt.hashCode);
    _$hash = $jc(_$hash, endsAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GCreateOrderData_createOrder_order_slot',
          )
          ..add('G__typename', G__typename)
          ..add('slotId', slotId)
          ..add('startsAt', startsAt)
          ..add('endsAt', endsAt))
        .toString();
  }
}

class GCreateOrderData_createOrder_order_slotBuilder
    implements
        Builder<
          GCreateOrderData_createOrder_order_slot,
          GCreateOrderData_createOrder_order_slotBuilder
        > {
  _$GCreateOrderData_createOrder_order_slot? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _slotId;
  String? get slotId => _$this._slotId;
  set slotId(String? slotId) => _$this._slotId = slotId;

  String? _startsAt;
  String? get startsAt => _$this._startsAt;
  set startsAt(String? startsAt) => _$this._startsAt = startsAt;

  String? _endsAt;
  String? get endsAt => _$this._endsAt;
  set endsAt(String? endsAt) => _$this._endsAt = endsAt;

  GCreateOrderData_createOrder_order_slotBuilder() {
    GCreateOrderData_createOrder_order_slot._initializeBuilder(this);
  }

  GCreateOrderData_createOrder_order_slotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _slotId = $v.slotId;
      _startsAt = $v.startsAt;
      _endsAt = $v.endsAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateOrderData_createOrder_order_slot other) {
    _$v = other as _$GCreateOrderData_createOrder_order_slot;
  }

  @override
  void update(
    void Function(GCreateOrderData_createOrder_order_slotBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GCreateOrderData_createOrder_order_slot build() => _build();

  _$GCreateOrderData_createOrder_order_slot _build() {
    final _$result =
        _$v ??
        _$GCreateOrderData_createOrder_order_slot._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GCreateOrderData_createOrder_order_slot',
            'G__typename',
          ),
          slotId: BuiltValueNullFieldError.checkNotNull(
            slotId,
            r'GCreateOrderData_createOrder_order_slot',
            'slotId',
          ),
          startsAt: BuiltValueNullFieldError.checkNotNull(
            startsAt,
            r'GCreateOrderData_createOrder_order_slot',
            'startsAt',
          ),
          endsAt: BuiltValueNullFieldError.checkNotNull(
            endsAt,
            r'GCreateOrderData_createOrder_order_slot',
            'endsAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateOrderData_createOrder_order_card
    extends GCreateOrderData_createOrder_order_card {
  @override
  final String G__typename;
  @override
  final String paymentMethodId;
  @override
  final _i2.GCardBrand brand;
  @override
  final String last4;

  factory _$GCreateOrderData_createOrder_order_card([
    void Function(GCreateOrderData_createOrder_order_cardBuilder)? updates,
  ]) => (GCreateOrderData_createOrder_order_cardBuilder()..update(updates))
      ._build();

  _$GCreateOrderData_createOrder_order_card._({
    required this.G__typename,
    required this.paymentMethodId,
    required this.brand,
    required this.last4,
  }) : super._();
  @override
  GCreateOrderData_createOrder_order_card rebuild(
    void Function(GCreateOrderData_createOrder_order_cardBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateOrderData_createOrder_order_cardBuilder toBuilder() =>
      GCreateOrderData_createOrder_order_cardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateOrderData_createOrder_order_card &&
        G__typename == other.G__typename &&
        paymentMethodId == other.paymentMethodId &&
        brand == other.brand &&
        last4 == other.last4;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, paymentMethodId.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, last4.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GCreateOrderData_createOrder_order_card',
          )
          ..add('G__typename', G__typename)
          ..add('paymentMethodId', paymentMethodId)
          ..add('brand', brand)
          ..add('last4', last4))
        .toString();
  }
}

class GCreateOrderData_createOrder_order_cardBuilder
    implements
        Builder<
          GCreateOrderData_createOrder_order_card,
          GCreateOrderData_createOrder_order_cardBuilder
        > {
  _$GCreateOrderData_createOrder_order_card? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _paymentMethodId;
  String? get paymentMethodId => _$this._paymentMethodId;
  set paymentMethodId(String? paymentMethodId) =>
      _$this._paymentMethodId = paymentMethodId;

  _i2.GCardBrand? _brand;
  _i2.GCardBrand? get brand => _$this._brand;
  set brand(_i2.GCardBrand? brand) => _$this._brand = brand;

  String? _last4;
  String? get last4 => _$this._last4;
  set last4(String? last4) => _$this._last4 = last4;

  GCreateOrderData_createOrder_order_cardBuilder() {
    GCreateOrderData_createOrder_order_card._initializeBuilder(this);
  }

  GCreateOrderData_createOrder_order_cardBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _paymentMethodId = $v.paymentMethodId;
      _brand = $v.brand;
      _last4 = $v.last4;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateOrderData_createOrder_order_card other) {
    _$v = other as _$GCreateOrderData_createOrder_order_card;
  }

  @override
  void update(
    void Function(GCreateOrderData_createOrder_order_cardBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GCreateOrderData_createOrder_order_card build() => _build();

  _$GCreateOrderData_createOrder_order_card _build() {
    final _$result =
        _$v ??
        _$GCreateOrderData_createOrder_order_card._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GCreateOrderData_createOrder_order_card',
            'G__typename',
          ),
          paymentMethodId: BuiltValueNullFieldError.checkNotNull(
            paymentMethodId,
            r'GCreateOrderData_createOrder_order_card',
            'paymentMethodId',
          ),
          brand: BuiltValueNullFieldError.checkNotNull(
            brand,
            r'GCreateOrderData_createOrder_order_card',
            'brand',
          ),
          last4: BuiltValueNullFieldError.checkNotNull(
            last4,
            r'GCreateOrderData_createOrder_order_card',
            'last4',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateOrderData_createOrder_order_timeline
    extends GCreateOrderData_createOrder_order_timeline {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GOrderEventType type;
  @override
  final String at;
  @override
  final String? message;

  factory _$GCreateOrderData_createOrder_order_timeline([
    void Function(GCreateOrderData_createOrder_order_timelineBuilder)? updates,
  ]) => (GCreateOrderData_createOrder_order_timelineBuilder()..update(updates))
      ._build();

  _$GCreateOrderData_createOrder_order_timeline._({
    required this.G__typename,
    required this.id,
    required this.type,
    required this.at,
    this.message,
  }) : super._();
  @override
  GCreateOrderData_createOrder_order_timeline rebuild(
    void Function(GCreateOrderData_createOrder_order_timelineBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateOrderData_createOrder_order_timelineBuilder toBuilder() =>
      GCreateOrderData_createOrder_order_timelineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateOrderData_createOrder_order_timeline &&
        G__typename == other.G__typename &&
        id == other.id &&
        type == other.type &&
        at == other.at &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, at.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GCreateOrderData_createOrder_order_timeline',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('type', type)
          ..add('at', at)
          ..add('message', message))
        .toString();
  }
}

class GCreateOrderData_createOrder_order_timelineBuilder
    implements
        Builder<
          GCreateOrderData_createOrder_order_timeline,
          GCreateOrderData_createOrder_order_timelineBuilder
        > {
  _$GCreateOrderData_createOrder_order_timeline? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GOrderEventType? _type;
  _i2.GOrderEventType? get type => _$this._type;
  set type(_i2.GOrderEventType? type) => _$this._type = type;

  String? _at;
  String? get at => _$this._at;
  set at(String? at) => _$this._at = at;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GCreateOrderData_createOrder_order_timelineBuilder() {
    GCreateOrderData_createOrder_order_timeline._initializeBuilder(this);
  }

  GCreateOrderData_createOrder_order_timelineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _type = $v.type;
      _at = $v.at;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateOrderData_createOrder_order_timeline other) {
    _$v = other as _$GCreateOrderData_createOrder_order_timeline;
  }

  @override
  void update(
    void Function(GCreateOrderData_createOrder_order_timelineBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GCreateOrderData_createOrder_order_timeline build() => _build();

  _$GCreateOrderData_createOrder_order_timeline _build() {
    final _$result =
        _$v ??
        _$GCreateOrderData_createOrder_order_timeline._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GCreateOrderData_createOrder_order_timeline',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GCreateOrderData_createOrder_order_timeline',
            'id',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'GCreateOrderData_createOrder_order_timeline',
            'type',
          ),
          at: BuiltValueNullFieldError.checkNotNull(
            at,
            r'GCreateOrderData_createOrder_order_timeline',
            'at',
          ),
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GOrderUpdatedData extends GOrderUpdatedData {
  @override
  final String G__typename;
  @override
  final GOrderUpdatedData_orderUpdated orderUpdated;

  factory _$GOrderUpdatedData([
    void Function(GOrderUpdatedDataBuilder)? updates,
  ]) => (GOrderUpdatedDataBuilder()..update(updates))._build();

  _$GOrderUpdatedData._({required this.G__typename, required this.orderUpdated})
    : super._();
  @override
  GOrderUpdatedData rebuild(void Function(GOrderUpdatedDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GOrderUpdatedDataBuilder toBuilder() =>
      GOrderUpdatedDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderUpdatedData &&
        G__typename == other.G__typename &&
        orderUpdated == other.orderUpdated;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, orderUpdated.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderUpdatedData')
          ..add('G__typename', G__typename)
          ..add('orderUpdated', orderUpdated))
        .toString();
  }
}

class GOrderUpdatedDataBuilder
    implements Builder<GOrderUpdatedData, GOrderUpdatedDataBuilder> {
  _$GOrderUpdatedData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GOrderUpdatedData_orderUpdatedBuilder? _orderUpdated;
  GOrderUpdatedData_orderUpdatedBuilder get orderUpdated =>
      _$this._orderUpdated ??= GOrderUpdatedData_orderUpdatedBuilder();
  set orderUpdated(GOrderUpdatedData_orderUpdatedBuilder? orderUpdated) =>
      _$this._orderUpdated = orderUpdated;

  GOrderUpdatedDataBuilder() {
    GOrderUpdatedData._initializeBuilder(this);
  }

  GOrderUpdatedDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _orderUpdated = $v.orderUpdated.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderUpdatedData other) {
    _$v = other as _$GOrderUpdatedData;
  }

  @override
  void update(void Function(GOrderUpdatedDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderUpdatedData build() => _build();

  _$GOrderUpdatedData _build() {
    _$GOrderUpdatedData _$result;
    try {
      _$result =
          _$v ??
          _$GOrderUpdatedData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GOrderUpdatedData',
              'G__typename',
            ),
            orderUpdated: orderUpdated.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'orderUpdated';
        orderUpdated.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GOrderUpdatedData',
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

class _$GOrderUpdatedData_orderUpdated extends GOrderUpdatedData_orderUpdated {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GOrderStatus status;
  @override
  final int totalCents;
  @override
  final String currency;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final BuiltList<GOrderUpdatedData_orderUpdated_items> items;
  @override
  final GOrderUpdatedData_orderUpdated_slot slot;
  @override
  final GOrderUpdatedData_orderUpdated_card card;
  @override
  final BuiltList<GOrderUpdatedData_orderUpdated_timeline> timeline;

  factory _$GOrderUpdatedData_orderUpdated([
    void Function(GOrderUpdatedData_orderUpdatedBuilder)? updates,
  ]) => (GOrderUpdatedData_orderUpdatedBuilder()..update(updates))._build();

  _$GOrderUpdatedData_orderUpdated._({
    required this.G__typename,
    required this.id,
    required this.status,
    required this.totalCents,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.slot,
    required this.card,
    required this.timeline,
  }) : super._();
  @override
  GOrderUpdatedData_orderUpdated rebuild(
    void Function(GOrderUpdatedData_orderUpdatedBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderUpdatedData_orderUpdatedBuilder toBuilder() =>
      GOrderUpdatedData_orderUpdatedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderUpdatedData_orderUpdated &&
        G__typename == other.G__typename &&
        id == other.id &&
        status == other.status &&
        totalCents == other.totalCents &&
        currency == other.currency &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        items == other.items &&
        slot == other.slot &&
        card == other.card &&
        timeline == other.timeline;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, totalCents.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, slot.hashCode);
    _$hash = $jc(_$hash, card.hashCode);
    _$hash = $jc(_$hash, timeline.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderUpdatedData_orderUpdated')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('status', status)
          ..add('totalCents', totalCents)
          ..add('currency', currency)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('items', items)
          ..add('slot', slot)
          ..add('card', card)
          ..add('timeline', timeline))
        .toString();
  }
}

class GOrderUpdatedData_orderUpdatedBuilder
    implements
        Builder<
          GOrderUpdatedData_orderUpdated,
          GOrderUpdatedData_orderUpdatedBuilder
        > {
  _$GOrderUpdatedData_orderUpdated? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GOrderStatus? _status;
  _i2.GOrderStatus? get status => _$this._status;
  set status(_i2.GOrderStatus? status) => _$this._status = status;

  int? _totalCents;
  int? get totalCents => _$this._totalCents;
  set totalCents(int? totalCents) => _$this._totalCents = totalCents;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  ListBuilder<GOrderUpdatedData_orderUpdated_items>? _items;
  ListBuilder<GOrderUpdatedData_orderUpdated_items> get items =>
      _$this._items ??= ListBuilder<GOrderUpdatedData_orderUpdated_items>();
  set items(ListBuilder<GOrderUpdatedData_orderUpdated_items>? items) =>
      _$this._items = items;

  GOrderUpdatedData_orderUpdated_slotBuilder? _slot;
  GOrderUpdatedData_orderUpdated_slotBuilder get slot =>
      _$this._slot ??= GOrderUpdatedData_orderUpdated_slotBuilder();
  set slot(GOrderUpdatedData_orderUpdated_slotBuilder? slot) =>
      _$this._slot = slot;

  GOrderUpdatedData_orderUpdated_cardBuilder? _card;
  GOrderUpdatedData_orderUpdated_cardBuilder get card =>
      _$this._card ??= GOrderUpdatedData_orderUpdated_cardBuilder();
  set card(GOrderUpdatedData_orderUpdated_cardBuilder? card) =>
      _$this._card = card;

  ListBuilder<GOrderUpdatedData_orderUpdated_timeline>? _timeline;
  ListBuilder<GOrderUpdatedData_orderUpdated_timeline> get timeline =>
      _$this._timeline ??=
          ListBuilder<GOrderUpdatedData_orderUpdated_timeline>();
  set timeline(
    ListBuilder<GOrderUpdatedData_orderUpdated_timeline>? timeline,
  ) => _$this._timeline = timeline;

  GOrderUpdatedData_orderUpdatedBuilder() {
    GOrderUpdatedData_orderUpdated._initializeBuilder(this);
  }

  GOrderUpdatedData_orderUpdatedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _status = $v.status;
      _totalCents = $v.totalCents;
      _currency = $v.currency;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _items = $v.items.toBuilder();
      _slot = $v.slot.toBuilder();
      _card = $v.card.toBuilder();
      _timeline = $v.timeline.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderUpdatedData_orderUpdated other) {
    _$v = other as _$GOrderUpdatedData_orderUpdated;
  }

  @override
  void update(void Function(GOrderUpdatedData_orderUpdatedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderUpdatedData_orderUpdated build() => _build();

  _$GOrderUpdatedData_orderUpdated _build() {
    _$GOrderUpdatedData_orderUpdated _$result;
    try {
      _$result =
          _$v ??
          _$GOrderUpdatedData_orderUpdated._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GOrderUpdatedData_orderUpdated',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GOrderUpdatedData_orderUpdated',
              'id',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GOrderUpdatedData_orderUpdated',
              'status',
            ),
            totalCents: BuiltValueNullFieldError.checkNotNull(
              totalCents,
              r'GOrderUpdatedData_orderUpdated',
              'totalCents',
            ),
            currency: BuiltValueNullFieldError.checkNotNull(
              currency,
              r'GOrderUpdatedData_orderUpdated',
              'currency',
            ),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'GOrderUpdatedData_orderUpdated',
              'createdAt',
            ),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt,
              r'GOrderUpdatedData_orderUpdated',
              'updatedAt',
            ),
            items: items.build(),
            slot: slot.build(),
            card: card.build(),
            timeline: timeline.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
        _$failedField = 'slot';
        slot.build();
        _$failedField = 'card';
        card.build();
        _$failedField = 'timeline';
        timeline.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GOrderUpdatedData_orderUpdated',
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

class _$GOrderUpdatedData_orderUpdated_items
    extends GOrderUpdatedData_orderUpdated_items {
  @override
  final String G__typename;
  @override
  final String serviceId;
  @override
  final String name;
  @override
  final int priceCents;

  factory _$GOrderUpdatedData_orderUpdated_items([
    void Function(GOrderUpdatedData_orderUpdated_itemsBuilder)? updates,
  ]) =>
      (GOrderUpdatedData_orderUpdated_itemsBuilder()..update(updates))._build();

  _$GOrderUpdatedData_orderUpdated_items._({
    required this.G__typename,
    required this.serviceId,
    required this.name,
    required this.priceCents,
  }) : super._();
  @override
  GOrderUpdatedData_orderUpdated_items rebuild(
    void Function(GOrderUpdatedData_orderUpdated_itemsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderUpdatedData_orderUpdated_itemsBuilder toBuilder() =>
      GOrderUpdatedData_orderUpdated_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderUpdatedData_orderUpdated_items &&
        G__typename == other.G__typename &&
        serviceId == other.serviceId &&
        name == other.name &&
        priceCents == other.priceCents;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, serviceId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, priceCents.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderUpdatedData_orderUpdated_items')
          ..add('G__typename', G__typename)
          ..add('serviceId', serviceId)
          ..add('name', name)
          ..add('priceCents', priceCents))
        .toString();
  }
}

class GOrderUpdatedData_orderUpdated_itemsBuilder
    implements
        Builder<
          GOrderUpdatedData_orderUpdated_items,
          GOrderUpdatedData_orderUpdated_itemsBuilder
        > {
  _$GOrderUpdatedData_orderUpdated_items? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _serviceId;
  String? get serviceId => _$this._serviceId;
  set serviceId(String? serviceId) => _$this._serviceId = serviceId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _priceCents;
  int? get priceCents => _$this._priceCents;
  set priceCents(int? priceCents) => _$this._priceCents = priceCents;

  GOrderUpdatedData_orderUpdated_itemsBuilder() {
    GOrderUpdatedData_orderUpdated_items._initializeBuilder(this);
  }

  GOrderUpdatedData_orderUpdated_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _serviceId = $v.serviceId;
      _name = $v.name;
      _priceCents = $v.priceCents;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderUpdatedData_orderUpdated_items other) {
    _$v = other as _$GOrderUpdatedData_orderUpdated_items;
  }

  @override
  void update(
    void Function(GOrderUpdatedData_orderUpdated_itemsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GOrderUpdatedData_orderUpdated_items build() => _build();

  _$GOrderUpdatedData_orderUpdated_items _build() {
    final _$result =
        _$v ??
        _$GOrderUpdatedData_orderUpdated_items._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GOrderUpdatedData_orderUpdated_items',
            'G__typename',
          ),
          serviceId: BuiltValueNullFieldError.checkNotNull(
            serviceId,
            r'GOrderUpdatedData_orderUpdated_items',
            'serviceId',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GOrderUpdatedData_orderUpdated_items',
            'name',
          ),
          priceCents: BuiltValueNullFieldError.checkNotNull(
            priceCents,
            r'GOrderUpdatedData_orderUpdated_items',
            'priceCents',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GOrderUpdatedData_orderUpdated_slot
    extends GOrderUpdatedData_orderUpdated_slot {
  @override
  final String G__typename;
  @override
  final String slotId;
  @override
  final String startsAt;
  @override
  final String endsAt;

  factory _$GOrderUpdatedData_orderUpdated_slot([
    void Function(GOrderUpdatedData_orderUpdated_slotBuilder)? updates,
  ]) =>
      (GOrderUpdatedData_orderUpdated_slotBuilder()..update(updates))._build();

  _$GOrderUpdatedData_orderUpdated_slot._({
    required this.G__typename,
    required this.slotId,
    required this.startsAt,
    required this.endsAt,
  }) : super._();
  @override
  GOrderUpdatedData_orderUpdated_slot rebuild(
    void Function(GOrderUpdatedData_orderUpdated_slotBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderUpdatedData_orderUpdated_slotBuilder toBuilder() =>
      GOrderUpdatedData_orderUpdated_slotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderUpdatedData_orderUpdated_slot &&
        G__typename == other.G__typename &&
        slotId == other.slotId &&
        startsAt == other.startsAt &&
        endsAt == other.endsAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, slotId.hashCode);
    _$hash = $jc(_$hash, startsAt.hashCode);
    _$hash = $jc(_$hash, endsAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderUpdatedData_orderUpdated_slot')
          ..add('G__typename', G__typename)
          ..add('slotId', slotId)
          ..add('startsAt', startsAt)
          ..add('endsAt', endsAt))
        .toString();
  }
}

class GOrderUpdatedData_orderUpdated_slotBuilder
    implements
        Builder<
          GOrderUpdatedData_orderUpdated_slot,
          GOrderUpdatedData_orderUpdated_slotBuilder
        > {
  _$GOrderUpdatedData_orderUpdated_slot? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _slotId;
  String? get slotId => _$this._slotId;
  set slotId(String? slotId) => _$this._slotId = slotId;

  String? _startsAt;
  String? get startsAt => _$this._startsAt;
  set startsAt(String? startsAt) => _$this._startsAt = startsAt;

  String? _endsAt;
  String? get endsAt => _$this._endsAt;
  set endsAt(String? endsAt) => _$this._endsAt = endsAt;

  GOrderUpdatedData_orderUpdated_slotBuilder() {
    GOrderUpdatedData_orderUpdated_slot._initializeBuilder(this);
  }

  GOrderUpdatedData_orderUpdated_slotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _slotId = $v.slotId;
      _startsAt = $v.startsAt;
      _endsAt = $v.endsAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderUpdatedData_orderUpdated_slot other) {
    _$v = other as _$GOrderUpdatedData_orderUpdated_slot;
  }

  @override
  void update(
    void Function(GOrderUpdatedData_orderUpdated_slotBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GOrderUpdatedData_orderUpdated_slot build() => _build();

  _$GOrderUpdatedData_orderUpdated_slot _build() {
    final _$result =
        _$v ??
        _$GOrderUpdatedData_orderUpdated_slot._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GOrderUpdatedData_orderUpdated_slot',
            'G__typename',
          ),
          slotId: BuiltValueNullFieldError.checkNotNull(
            slotId,
            r'GOrderUpdatedData_orderUpdated_slot',
            'slotId',
          ),
          startsAt: BuiltValueNullFieldError.checkNotNull(
            startsAt,
            r'GOrderUpdatedData_orderUpdated_slot',
            'startsAt',
          ),
          endsAt: BuiltValueNullFieldError.checkNotNull(
            endsAt,
            r'GOrderUpdatedData_orderUpdated_slot',
            'endsAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GOrderUpdatedData_orderUpdated_card
    extends GOrderUpdatedData_orderUpdated_card {
  @override
  final String G__typename;
  @override
  final String paymentMethodId;
  @override
  final _i2.GCardBrand brand;
  @override
  final String last4;

  factory _$GOrderUpdatedData_orderUpdated_card([
    void Function(GOrderUpdatedData_orderUpdated_cardBuilder)? updates,
  ]) =>
      (GOrderUpdatedData_orderUpdated_cardBuilder()..update(updates))._build();

  _$GOrderUpdatedData_orderUpdated_card._({
    required this.G__typename,
    required this.paymentMethodId,
    required this.brand,
    required this.last4,
  }) : super._();
  @override
  GOrderUpdatedData_orderUpdated_card rebuild(
    void Function(GOrderUpdatedData_orderUpdated_cardBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderUpdatedData_orderUpdated_cardBuilder toBuilder() =>
      GOrderUpdatedData_orderUpdated_cardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderUpdatedData_orderUpdated_card &&
        G__typename == other.G__typename &&
        paymentMethodId == other.paymentMethodId &&
        brand == other.brand &&
        last4 == other.last4;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, paymentMethodId.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, last4.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderUpdatedData_orderUpdated_card')
          ..add('G__typename', G__typename)
          ..add('paymentMethodId', paymentMethodId)
          ..add('brand', brand)
          ..add('last4', last4))
        .toString();
  }
}

class GOrderUpdatedData_orderUpdated_cardBuilder
    implements
        Builder<
          GOrderUpdatedData_orderUpdated_card,
          GOrderUpdatedData_orderUpdated_cardBuilder
        > {
  _$GOrderUpdatedData_orderUpdated_card? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _paymentMethodId;
  String? get paymentMethodId => _$this._paymentMethodId;
  set paymentMethodId(String? paymentMethodId) =>
      _$this._paymentMethodId = paymentMethodId;

  _i2.GCardBrand? _brand;
  _i2.GCardBrand? get brand => _$this._brand;
  set brand(_i2.GCardBrand? brand) => _$this._brand = brand;

  String? _last4;
  String? get last4 => _$this._last4;
  set last4(String? last4) => _$this._last4 = last4;

  GOrderUpdatedData_orderUpdated_cardBuilder() {
    GOrderUpdatedData_orderUpdated_card._initializeBuilder(this);
  }

  GOrderUpdatedData_orderUpdated_cardBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _paymentMethodId = $v.paymentMethodId;
      _brand = $v.brand;
      _last4 = $v.last4;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderUpdatedData_orderUpdated_card other) {
    _$v = other as _$GOrderUpdatedData_orderUpdated_card;
  }

  @override
  void update(
    void Function(GOrderUpdatedData_orderUpdated_cardBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GOrderUpdatedData_orderUpdated_card build() => _build();

  _$GOrderUpdatedData_orderUpdated_card _build() {
    final _$result =
        _$v ??
        _$GOrderUpdatedData_orderUpdated_card._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GOrderUpdatedData_orderUpdated_card',
            'G__typename',
          ),
          paymentMethodId: BuiltValueNullFieldError.checkNotNull(
            paymentMethodId,
            r'GOrderUpdatedData_orderUpdated_card',
            'paymentMethodId',
          ),
          brand: BuiltValueNullFieldError.checkNotNull(
            brand,
            r'GOrderUpdatedData_orderUpdated_card',
            'brand',
          ),
          last4: BuiltValueNullFieldError.checkNotNull(
            last4,
            r'GOrderUpdatedData_orderUpdated_card',
            'last4',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GOrderUpdatedData_orderUpdated_timeline
    extends GOrderUpdatedData_orderUpdated_timeline {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GOrderEventType type;
  @override
  final String at;
  @override
  final String? message;

  factory _$GOrderUpdatedData_orderUpdated_timeline([
    void Function(GOrderUpdatedData_orderUpdated_timelineBuilder)? updates,
  ]) => (GOrderUpdatedData_orderUpdated_timelineBuilder()..update(updates))
      ._build();

  _$GOrderUpdatedData_orderUpdated_timeline._({
    required this.G__typename,
    required this.id,
    required this.type,
    required this.at,
    this.message,
  }) : super._();
  @override
  GOrderUpdatedData_orderUpdated_timeline rebuild(
    void Function(GOrderUpdatedData_orderUpdated_timelineBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderUpdatedData_orderUpdated_timelineBuilder toBuilder() =>
      GOrderUpdatedData_orderUpdated_timelineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderUpdatedData_orderUpdated_timeline &&
        G__typename == other.G__typename &&
        id == other.id &&
        type == other.type &&
        at == other.at &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, at.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GOrderUpdatedData_orderUpdated_timeline',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('type', type)
          ..add('at', at)
          ..add('message', message))
        .toString();
  }
}

class GOrderUpdatedData_orderUpdated_timelineBuilder
    implements
        Builder<
          GOrderUpdatedData_orderUpdated_timeline,
          GOrderUpdatedData_orderUpdated_timelineBuilder
        > {
  _$GOrderUpdatedData_orderUpdated_timeline? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GOrderEventType? _type;
  _i2.GOrderEventType? get type => _$this._type;
  set type(_i2.GOrderEventType? type) => _$this._type = type;

  String? _at;
  String? get at => _$this._at;
  set at(String? at) => _$this._at = at;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GOrderUpdatedData_orderUpdated_timelineBuilder() {
    GOrderUpdatedData_orderUpdated_timeline._initializeBuilder(this);
  }

  GOrderUpdatedData_orderUpdated_timelineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _type = $v.type;
      _at = $v.at;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderUpdatedData_orderUpdated_timeline other) {
    _$v = other as _$GOrderUpdatedData_orderUpdated_timeline;
  }

  @override
  void update(
    void Function(GOrderUpdatedData_orderUpdated_timelineBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GOrderUpdatedData_orderUpdated_timeline build() => _build();

  _$GOrderUpdatedData_orderUpdated_timeline _build() {
    final _$result =
        _$v ??
        _$GOrderUpdatedData_orderUpdated_timeline._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GOrderUpdatedData_orderUpdated_timeline',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GOrderUpdatedData_orderUpdated_timeline',
            'id',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'GOrderUpdatedData_orderUpdated_timeline',
            'type',
          ),
          at: BuiltValueNullFieldError.checkNotNull(
            at,
            r'GOrderUpdatedData_orderUpdated_timeline',
            'at',
          ),
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GOrderFieldsData extends GOrderFieldsData {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GOrderStatus status;
  @override
  final int totalCents;
  @override
  final String currency;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final BuiltList<GOrderFieldsData_items> items;
  @override
  final GOrderFieldsData_slot slot;
  @override
  final GOrderFieldsData_card card;
  @override
  final BuiltList<GOrderFieldsData_timeline> timeline;

  factory _$GOrderFieldsData([
    void Function(GOrderFieldsDataBuilder)? updates,
  ]) => (GOrderFieldsDataBuilder()..update(updates))._build();

  _$GOrderFieldsData._({
    required this.G__typename,
    required this.id,
    required this.status,
    required this.totalCents,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.slot,
    required this.card,
    required this.timeline,
  }) : super._();
  @override
  GOrderFieldsData rebuild(void Function(GOrderFieldsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GOrderFieldsDataBuilder toBuilder() =>
      GOrderFieldsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderFieldsData &&
        G__typename == other.G__typename &&
        id == other.id &&
        status == other.status &&
        totalCents == other.totalCents &&
        currency == other.currency &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        items == other.items &&
        slot == other.slot &&
        card == other.card &&
        timeline == other.timeline;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, totalCents.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, slot.hashCode);
    _$hash = $jc(_$hash, card.hashCode);
    _$hash = $jc(_$hash, timeline.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderFieldsData')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('status', status)
          ..add('totalCents', totalCents)
          ..add('currency', currency)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('items', items)
          ..add('slot', slot)
          ..add('card', card)
          ..add('timeline', timeline))
        .toString();
  }
}

class GOrderFieldsDataBuilder
    implements Builder<GOrderFieldsData, GOrderFieldsDataBuilder> {
  _$GOrderFieldsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GOrderStatus? _status;
  _i2.GOrderStatus? get status => _$this._status;
  set status(_i2.GOrderStatus? status) => _$this._status = status;

  int? _totalCents;
  int? get totalCents => _$this._totalCents;
  set totalCents(int? totalCents) => _$this._totalCents = totalCents;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  ListBuilder<GOrderFieldsData_items>? _items;
  ListBuilder<GOrderFieldsData_items> get items =>
      _$this._items ??= ListBuilder<GOrderFieldsData_items>();
  set items(ListBuilder<GOrderFieldsData_items>? items) =>
      _$this._items = items;

  GOrderFieldsData_slotBuilder? _slot;
  GOrderFieldsData_slotBuilder get slot =>
      _$this._slot ??= GOrderFieldsData_slotBuilder();
  set slot(GOrderFieldsData_slotBuilder? slot) => _$this._slot = slot;

  GOrderFieldsData_cardBuilder? _card;
  GOrderFieldsData_cardBuilder get card =>
      _$this._card ??= GOrderFieldsData_cardBuilder();
  set card(GOrderFieldsData_cardBuilder? card) => _$this._card = card;

  ListBuilder<GOrderFieldsData_timeline>? _timeline;
  ListBuilder<GOrderFieldsData_timeline> get timeline =>
      _$this._timeline ??= ListBuilder<GOrderFieldsData_timeline>();
  set timeline(ListBuilder<GOrderFieldsData_timeline>? timeline) =>
      _$this._timeline = timeline;

  GOrderFieldsDataBuilder() {
    GOrderFieldsData._initializeBuilder(this);
  }

  GOrderFieldsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _status = $v.status;
      _totalCents = $v.totalCents;
      _currency = $v.currency;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _items = $v.items.toBuilder();
      _slot = $v.slot.toBuilder();
      _card = $v.card.toBuilder();
      _timeline = $v.timeline.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderFieldsData other) {
    _$v = other as _$GOrderFieldsData;
  }

  @override
  void update(void Function(GOrderFieldsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderFieldsData build() => _build();

  _$GOrderFieldsData _build() {
    _$GOrderFieldsData _$result;
    try {
      _$result =
          _$v ??
          _$GOrderFieldsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GOrderFieldsData',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GOrderFieldsData',
              'id',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GOrderFieldsData',
              'status',
            ),
            totalCents: BuiltValueNullFieldError.checkNotNull(
              totalCents,
              r'GOrderFieldsData',
              'totalCents',
            ),
            currency: BuiltValueNullFieldError.checkNotNull(
              currency,
              r'GOrderFieldsData',
              'currency',
            ),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'GOrderFieldsData',
              'createdAt',
            ),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt,
              r'GOrderFieldsData',
              'updatedAt',
            ),
            items: items.build(),
            slot: slot.build(),
            card: card.build(),
            timeline: timeline.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
        _$failedField = 'slot';
        slot.build();
        _$failedField = 'card';
        card.build();
        _$failedField = 'timeline';
        timeline.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GOrderFieldsData',
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

class _$GOrderFieldsData_items extends GOrderFieldsData_items {
  @override
  final String G__typename;
  @override
  final String serviceId;
  @override
  final String name;
  @override
  final int priceCents;

  factory _$GOrderFieldsData_items([
    void Function(GOrderFieldsData_itemsBuilder)? updates,
  ]) => (GOrderFieldsData_itemsBuilder()..update(updates))._build();

  _$GOrderFieldsData_items._({
    required this.G__typename,
    required this.serviceId,
    required this.name,
    required this.priceCents,
  }) : super._();
  @override
  GOrderFieldsData_items rebuild(
    void Function(GOrderFieldsData_itemsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderFieldsData_itemsBuilder toBuilder() =>
      GOrderFieldsData_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderFieldsData_items &&
        G__typename == other.G__typename &&
        serviceId == other.serviceId &&
        name == other.name &&
        priceCents == other.priceCents;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, serviceId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, priceCents.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderFieldsData_items')
          ..add('G__typename', G__typename)
          ..add('serviceId', serviceId)
          ..add('name', name)
          ..add('priceCents', priceCents))
        .toString();
  }
}

class GOrderFieldsData_itemsBuilder
    implements Builder<GOrderFieldsData_items, GOrderFieldsData_itemsBuilder> {
  _$GOrderFieldsData_items? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _serviceId;
  String? get serviceId => _$this._serviceId;
  set serviceId(String? serviceId) => _$this._serviceId = serviceId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _priceCents;
  int? get priceCents => _$this._priceCents;
  set priceCents(int? priceCents) => _$this._priceCents = priceCents;

  GOrderFieldsData_itemsBuilder() {
    GOrderFieldsData_items._initializeBuilder(this);
  }

  GOrderFieldsData_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _serviceId = $v.serviceId;
      _name = $v.name;
      _priceCents = $v.priceCents;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderFieldsData_items other) {
    _$v = other as _$GOrderFieldsData_items;
  }

  @override
  void update(void Function(GOrderFieldsData_itemsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderFieldsData_items build() => _build();

  _$GOrderFieldsData_items _build() {
    final _$result =
        _$v ??
        _$GOrderFieldsData_items._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GOrderFieldsData_items',
            'G__typename',
          ),
          serviceId: BuiltValueNullFieldError.checkNotNull(
            serviceId,
            r'GOrderFieldsData_items',
            'serviceId',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GOrderFieldsData_items',
            'name',
          ),
          priceCents: BuiltValueNullFieldError.checkNotNull(
            priceCents,
            r'GOrderFieldsData_items',
            'priceCents',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GOrderFieldsData_slot extends GOrderFieldsData_slot {
  @override
  final String G__typename;
  @override
  final String slotId;
  @override
  final String startsAt;
  @override
  final String endsAt;

  factory _$GOrderFieldsData_slot([
    void Function(GOrderFieldsData_slotBuilder)? updates,
  ]) => (GOrderFieldsData_slotBuilder()..update(updates))._build();

  _$GOrderFieldsData_slot._({
    required this.G__typename,
    required this.slotId,
    required this.startsAt,
    required this.endsAt,
  }) : super._();
  @override
  GOrderFieldsData_slot rebuild(
    void Function(GOrderFieldsData_slotBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderFieldsData_slotBuilder toBuilder() =>
      GOrderFieldsData_slotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderFieldsData_slot &&
        G__typename == other.G__typename &&
        slotId == other.slotId &&
        startsAt == other.startsAt &&
        endsAt == other.endsAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, slotId.hashCode);
    _$hash = $jc(_$hash, startsAt.hashCode);
    _$hash = $jc(_$hash, endsAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderFieldsData_slot')
          ..add('G__typename', G__typename)
          ..add('slotId', slotId)
          ..add('startsAt', startsAt)
          ..add('endsAt', endsAt))
        .toString();
  }
}

class GOrderFieldsData_slotBuilder
    implements Builder<GOrderFieldsData_slot, GOrderFieldsData_slotBuilder> {
  _$GOrderFieldsData_slot? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _slotId;
  String? get slotId => _$this._slotId;
  set slotId(String? slotId) => _$this._slotId = slotId;

  String? _startsAt;
  String? get startsAt => _$this._startsAt;
  set startsAt(String? startsAt) => _$this._startsAt = startsAt;

  String? _endsAt;
  String? get endsAt => _$this._endsAt;
  set endsAt(String? endsAt) => _$this._endsAt = endsAt;

  GOrderFieldsData_slotBuilder() {
    GOrderFieldsData_slot._initializeBuilder(this);
  }

  GOrderFieldsData_slotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _slotId = $v.slotId;
      _startsAt = $v.startsAt;
      _endsAt = $v.endsAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderFieldsData_slot other) {
    _$v = other as _$GOrderFieldsData_slot;
  }

  @override
  void update(void Function(GOrderFieldsData_slotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderFieldsData_slot build() => _build();

  _$GOrderFieldsData_slot _build() {
    final _$result =
        _$v ??
        _$GOrderFieldsData_slot._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GOrderFieldsData_slot',
            'G__typename',
          ),
          slotId: BuiltValueNullFieldError.checkNotNull(
            slotId,
            r'GOrderFieldsData_slot',
            'slotId',
          ),
          startsAt: BuiltValueNullFieldError.checkNotNull(
            startsAt,
            r'GOrderFieldsData_slot',
            'startsAt',
          ),
          endsAt: BuiltValueNullFieldError.checkNotNull(
            endsAt,
            r'GOrderFieldsData_slot',
            'endsAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GOrderFieldsData_card extends GOrderFieldsData_card {
  @override
  final String G__typename;
  @override
  final String paymentMethodId;
  @override
  final _i2.GCardBrand brand;
  @override
  final String last4;

  factory _$GOrderFieldsData_card([
    void Function(GOrderFieldsData_cardBuilder)? updates,
  ]) => (GOrderFieldsData_cardBuilder()..update(updates))._build();

  _$GOrderFieldsData_card._({
    required this.G__typename,
    required this.paymentMethodId,
    required this.brand,
    required this.last4,
  }) : super._();
  @override
  GOrderFieldsData_card rebuild(
    void Function(GOrderFieldsData_cardBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderFieldsData_cardBuilder toBuilder() =>
      GOrderFieldsData_cardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderFieldsData_card &&
        G__typename == other.G__typename &&
        paymentMethodId == other.paymentMethodId &&
        brand == other.brand &&
        last4 == other.last4;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, paymentMethodId.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, last4.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderFieldsData_card')
          ..add('G__typename', G__typename)
          ..add('paymentMethodId', paymentMethodId)
          ..add('brand', brand)
          ..add('last4', last4))
        .toString();
  }
}

class GOrderFieldsData_cardBuilder
    implements Builder<GOrderFieldsData_card, GOrderFieldsData_cardBuilder> {
  _$GOrderFieldsData_card? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _paymentMethodId;
  String? get paymentMethodId => _$this._paymentMethodId;
  set paymentMethodId(String? paymentMethodId) =>
      _$this._paymentMethodId = paymentMethodId;

  _i2.GCardBrand? _brand;
  _i2.GCardBrand? get brand => _$this._brand;
  set brand(_i2.GCardBrand? brand) => _$this._brand = brand;

  String? _last4;
  String? get last4 => _$this._last4;
  set last4(String? last4) => _$this._last4 = last4;

  GOrderFieldsData_cardBuilder() {
    GOrderFieldsData_card._initializeBuilder(this);
  }

  GOrderFieldsData_cardBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _paymentMethodId = $v.paymentMethodId;
      _brand = $v.brand;
      _last4 = $v.last4;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderFieldsData_card other) {
    _$v = other as _$GOrderFieldsData_card;
  }

  @override
  void update(void Function(GOrderFieldsData_cardBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderFieldsData_card build() => _build();

  _$GOrderFieldsData_card _build() {
    final _$result =
        _$v ??
        _$GOrderFieldsData_card._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GOrderFieldsData_card',
            'G__typename',
          ),
          paymentMethodId: BuiltValueNullFieldError.checkNotNull(
            paymentMethodId,
            r'GOrderFieldsData_card',
            'paymentMethodId',
          ),
          brand: BuiltValueNullFieldError.checkNotNull(
            brand,
            r'GOrderFieldsData_card',
            'brand',
          ),
          last4: BuiltValueNullFieldError.checkNotNull(
            last4,
            r'GOrderFieldsData_card',
            'last4',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GOrderFieldsData_timeline extends GOrderFieldsData_timeline {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GOrderEventType type;
  @override
  final String at;
  @override
  final String? message;

  factory _$GOrderFieldsData_timeline([
    void Function(GOrderFieldsData_timelineBuilder)? updates,
  ]) => (GOrderFieldsData_timelineBuilder()..update(updates))._build();

  _$GOrderFieldsData_timeline._({
    required this.G__typename,
    required this.id,
    required this.type,
    required this.at,
    this.message,
  }) : super._();
  @override
  GOrderFieldsData_timeline rebuild(
    void Function(GOrderFieldsData_timelineBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GOrderFieldsData_timelineBuilder toBuilder() =>
      GOrderFieldsData_timelineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GOrderFieldsData_timeline &&
        G__typename == other.G__typename &&
        id == other.id &&
        type == other.type &&
        at == other.at &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, at.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GOrderFieldsData_timeline')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('type', type)
          ..add('at', at)
          ..add('message', message))
        .toString();
  }
}

class GOrderFieldsData_timelineBuilder
    implements
        Builder<GOrderFieldsData_timeline, GOrderFieldsData_timelineBuilder> {
  _$GOrderFieldsData_timeline? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GOrderEventType? _type;
  _i2.GOrderEventType? get type => _$this._type;
  set type(_i2.GOrderEventType? type) => _$this._type = type;

  String? _at;
  String? get at => _$this._at;
  set at(String? at) => _$this._at = at;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GOrderFieldsData_timelineBuilder() {
    GOrderFieldsData_timeline._initializeBuilder(this);
  }

  GOrderFieldsData_timelineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _type = $v.type;
      _at = $v.at;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GOrderFieldsData_timeline other) {
    _$v = other as _$GOrderFieldsData_timeline;
  }

  @override
  void update(void Function(GOrderFieldsData_timelineBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GOrderFieldsData_timeline build() => _build();

  _$GOrderFieldsData_timeline _build() {
    final _$result =
        _$v ??
        _$GOrderFieldsData_timeline._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GOrderFieldsData_timeline',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GOrderFieldsData_timeline',
            'id',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'GOrderFieldsData_timeline',
            'type',
          ),
          at: BuiltValueNullFieldError.checkNotNull(
            at,
            r'GOrderFieldsData_timeline',
            'at',
          ),
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
