import 'order_status.dart';

/// An order as the server stores it. The idempotency key and request
/// fingerprint live on the order itself, so the order and its key are saved
/// in one write - there's no moment where one exists without the other.
class OrderRecord {
  const OrderRecord({
    required this.id,
    required this.userId,
    required this.idempotencyKey,
    required this.fingerprint,
    required this.status,
    required this.items,
    required this.slot,
    required this.card,
    required this.totalCents,
    required this.currency,
    required this.timeline,
    required this.createdAt,
    required this.updatedAt,
    required this.holdRequestedAt,
  });

  final String id;
  final String userId;
  final String idempotencyKey;
  final String fingerprint;
  final OrderStatus status;
  final List<OrderItemRecord> items;
  final BookedSlotRecord slot;
  final CardSnapshotRecord card;
  final int totalCents;
  final String currency;
  final List<OrderEventRecord> timeline;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// When the gateway was asked for the hold. After a reload the hold is
  /// rescheduled from this, not from the reload.
  final DateTime holdRequestedAt;

  /// The order after the gateway's answer. Status and timeline change in the
  /// same step, so they can never disagree.
  OrderRecord settled({
    required OrderStatus status,
    required DateTime at,
    required String message,
  }) {
    final OrderEventType type = status == OrderStatus.holdPlaced
        ? OrderEventType.holdPlaced
        : OrderEventType.holdFailed;
    return OrderRecord(
      id: id,
      userId: userId,
      idempotencyKey: idempotencyKey,
      fingerprint: fingerprint,
      status: status,
      items: items,
      slot: slot,
      card: card,
      totalCents: totalCents,
      currency: currency,
      timeline: <OrderEventRecord>[
        ...timeline,
        OrderEventRecord(
          id: eventId(id, timeline.length + 1),
          type: type,
          at: at,
          message: message,
        ),
      ],
      createdAt: createdAt,
      updatedAt: at,
      holdRequestedAt: holdRequestedAt,
    );
  }

  /// Event ids are unique across all orders because the client cache
  /// normalises events by id.
  static String eventId(String orderId, int number) => '$orderId-e$number';

  Map<String, Object?> toResponse() => <String, Object?>{
    '__typename': 'Order',
    'id': id,
    'status': status.wireName,
    'items': <Object?>[
      for (final OrderItemRecord item in items) item.toResponse(),
    ],
    'slot': slot.toResponse(),
    'card': card.toResponse(),
    'totalCents': totalCents,
    'currency': currency,
    'timeline': <Object?>[
      for (final OrderEventRecord event in timeline) event.toResponse(),
    ],
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  Map<String, Object?> toJson() => <String, Object?>{
    'id': id,
    'userId': userId,
    'idempotencyKey': idempotencyKey,
    'fingerprint': fingerprint,
    'status': status.wireName,
    'items': <Object?>[for (final OrderItemRecord item in items) item.toJson()],
    'slot': slot.toJson(),
    'card': card.toJson(),
    'totalCents': totalCents,
    'currency': currency,
    'timeline': <Object?>[
      for (final OrderEventRecord event in timeline) event.toJson(),
    ],
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'holdRequestedAt': holdRequestedAt.toIso8601String(),
  };

  /// Throws [FormatException] if [json] isn't a stored order.
  static OrderRecord fromJson(Object? json) {
    if (json case {
      'id': final String id,
      'userId': final String userId,
      'idempotencyKey': final String idempotencyKey,
      'fingerprint': final String fingerprint,
      'status': final String status,
      'items': final List<Object?> items,
      'slot': final Object? slot,
      'card': final Object? card,
      'totalCents': final int totalCents,
      'currency': final String currency,
      'timeline': final List<Object?> timeline,
      'createdAt': final String createdAt,
      'updatedAt': final String updatedAt,
      'holdRequestedAt': final String holdRequestedAt,
    }) {
      return OrderRecord(
        id: id,
        userId: userId,
        idempotencyKey: idempotencyKey,
        fingerprint: fingerprint,
        status: OrderStatus.fromWireName(status),
        items: <OrderItemRecord>[
          for (final Object? item in items) OrderItemRecord.fromJson(item),
        ],
        slot: BookedSlotRecord.fromJson(slot),
        card: CardSnapshotRecord.fromJson(card),
        totalCents: totalCents,
        currency: currency,
        timeline: <OrderEventRecord>[
          for (final Object? event in timeline)
            OrderEventRecord.fromJson(event),
        ],
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
        holdRequestedAt: DateTime.parse(holdRequestedAt),
      );
    }
    throw const FormatException('Not a stored order.');
  }
}

/// A service as it was when the order was placed.
class OrderItemRecord {
  const OrderItemRecord({
    required this.serviceId,
    required this.name,
    required this.priceCents,
  });

  final String serviceId;
  final String name;
  final int priceCents;

  Map<String, Object?> toResponse() => <String, Object?>{
    '__typename': 'OrderItem',
    ...toJson(),
  };

  Map<String, Object?> toJson() => <String, Object?>{
    'serviceId': serviceId,
    'name': name,
    'priceCents': priceCents,
  };

  static OrderItemRecord fromJson(Object? json) {
    if (json case {
      'serviceId': final String serviceId,
      'name': final String name,
      'priceCents': final int priceCents,
    }) {
      return OrderItemRecord(
        serviceId: serviceId,
        name: name,
        priceCents: priceCents,
      );
    }
    throw const FormatException('Not a stored order item.');
  }
}

/// The slot as it was when the order was placed.
class BookedSlotRecord {
  const BookedSlotRecord({
    required this.slotId,
    required this.startsAt,
    required this.endsAt,
  });

  final String slotId;
  final DateTime startsAt;
  final DateTime endsAt;

  Map<String, Object?> toResponse() => <String, Object?>{
    '__typename': 'BookedSlot',
    ...toJson(),
  };

  Map<String, Object?> toJson() => <String, Object?>{
    'slotId': slotId,
    'startsAt': startsAt.toIso8601String(),
    'endsAt': endsAt.toIso8601String(),
  };

  static BookedSlotRecord fromJson(Object? json) {
    if (json case {
      'slotId': final String slotId,
      'startsAt': final String startsAt,
      'endsAt': final String endsAt,
    }) {
      return BookedSlotRecord(
        slotId: slotId,
        startsAt: DateTime.parse(startsAt),
        endsAt: DateTime.parse(endsAt),
      );
    }
    throw const FormatException('Not a stored booked slot.');
  }
}

/// The card's brand and last 4 as they were when the order was placed.
class CardSnapshotRecord {
  const CardSnapshotRecord({
    required this.paymentMethodId,
    required this.brand,
    required this.last4,
  });

  final String paymentMethodId;
  final String brand;
  final String last4;

  Map<String, Object?> toResponse() => <String, Object?>{
    '__typename': 'CardSnapshot',
    ...toJson(),
  };

  Map<String, Object?> toJson() => <String, Object?>{
    'paymentMethodId': paymentMethodId,
    'brand': brand,
    'last4': last4,
  };

  static CardSnapshotRecord fromJson(Object? json) {
    if (json case {
      'paymentMethodId': final String paymentMethodId,
      'brand': final String brand,
      'last4': final String last4,
    }) {
      return CardSnapshotRecord(
        paymentMethodId: paymentMethodId,
        brand: brand,
        last4: last4,
      );
    }
    throw const FormatException('Not a stored card snapshot.');
  }
}

/// One step on the order's timeline.
class OrderEventRecord {
  const OrderEventRecord({
    required this.id,
    required this.type,
    required this.at,
    this.message,
  });

  final String id;
  final OrderEventType type;
  final DateTime at;
  final String? message;

  Map<String, Object?> toResponse() => <String, Object?>{
    '__typename': 'OrderEvent',
    ...toJson(),
  };

  Map<String, Object?> toJson() => <String, Object?>{
    'id': id,
    'type': type.wireName,
    'at': at.toIso8601String(),
    'message': message,
  };

  static OrderEventRecord fromJson(Object? json) {
    if (json case {
      'id': final String id,
      'type': final String type,
      'at': final String at,
      'message': final String? message,
    }) {
      return OrderEventRecord(
        id: id,
        type: OrderEventType.fromWireName(type),
        at: DateTime.parse(at),
        message: message,
      );
    }
    throw const FormatException('Not a stored order event.');
  }
}
