import 'package:graphql_api/graphql_api.dart';

import '../../domain/entities/catalog.dart';
import '../../domain/entities/money.dart';
import '../../domain/entities/order.dart';

// Generated GraphQL types in, domain entities out. Anything that doesn't fit
// throws FormatException rather than reaching the UI half-formed.

Service mapService(GServicesData_services data) => Service(
  id: data.id,
  name: data.name,
  description: data.description,
  price: Money.zar(data.priceCents),
  duration: Duration(minutes: data.durationMinutes),
);

Slot mapSlot(GAvailableSlotsData_availableSlots data) => Slot(
  id: data.id,
  startsAt: _timestamp(data.startsAt),
  endsAt: _timestamp(data.endsAt),
  available: data.available,
);

PaymentMethod mapPaymentMethod(GPaymentMethodsData_paymentMethods data) =>
    PaymentMethod(
      id: data.id,
      brand: _cardBrand(data.brand),
      last4: data.last4,
      expiryMonth: data.expiryMonth,
      expiryYear: data.expiryYear,
      label: data.label,
    );

/// One mapper for every order result: OrderDetails, CreateOrder and
/// OrderUpdated all select the OrderFields fragment.
Order mapOrder(GOrderFields data) {
  Money money(int cents) => Money(cents: cents, currency: data.currency);
  return Order(
    id: data.id,
    status: _orderStatus(data.status),
    items: <OrderItem>[
      for (final GOrderFields_items item in data.items)
        OrderItem(
          serviceId: item.serviceId,
          name: item.name,
          price: money(item.priceCents),
        ),
    ],
    slot: BookedSlot(
      slotId: data.slot.slotId,
      startsAt: _timestamp(data.slot.startsAt),
      endsAt: _timestamp(data.slot.endsAt),
    ),
    card: CardSnapshot(
      paymentMethodId: data.card.paymentMethodId,
      brand: _cardBrand(data.card.brand),
      last4: data.card.last4,
    ),
    total: money(data.totalCents),
    timeline: <OrderEvent>[
      for (final GOrderFields_timeline event in data.timeline)
        OrderEvent(
          id: event.id,
          type: _eventType(event.type),
          at: _timestamp(event.at),
          message: event.message,
        ),
    ],
    createdAt: _timestamp(data.createdAt),
    updatedAt: _timestamp(data.updatedAt),
  );
}

DateTime _timestamp(String raw) {
  final DateTime? parsed = DateTime.tryParse(raw);
  if (parsed == null) {
    throw FormatException('Not an ISO-8601 timestamp: "$raw"');
  }
  return parsed;
}

// The generated enums aren't Dart enums, so these switch on the wire name.
// An unknown value fails loudly instead of being guessed.

OrderStatus _orderStatus(GOrderStatus status) => switch (status.name) {
  'HOLD_PENDING' => OrderStatus.holdPending,
  'HOLD_PLACED' => OrderStatus.holdPlaced,
  'HOLD_FAILED' => OrderStatus.holdFailed,
  _ => throw FormatException('Unknown order status "${status.name}"'),
};

OrderEventType _eventType(GOrderEventType type) => switch (type.name) {
  'CREATED' => OrderEventType.created,
  'HOLD_REQUESTED' => OrderEventType.holdRequested,
  'HOLD_PLACED' => OrderEventType.holdPlaced,
  'HOLD_FAILED' => OrderEventType.holdFailed,
  _ => throw FormatException('Unknown order event type "${type.name}"'),
};

CardBrand _cardBrand(GCardBrand brand) => switch (brand.name) {
  'VISA' => CardBrand.visa,
  'MASTERCARD' => CardBrand.mastercard,
  _ => throw FormatException('Unknown card brand "${brand.name}"'),
};
