import 'package:equatable/equatable.dart';

import 'catalog.dart';
import 'money.dart';

/// The same three words as the schema and the server's state machine.
enum OrderStatus {
  holdPending,
  holdPlaced,
  holdFailed;

  bool get isTerminal => this != holdPending;
}

enum OrderEventType { created, holdRequested, holdPlaced, holdFailed }

class Order extends Equatable {
  const Order({
    required this.id,
    required this.status,
    required this.items,
    required this.slot,
    required this.card,
    required this.total,
    required this.timeline,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final OrderStatus status;
  final List<OrderItem> items;
  final BookedSlot slot;
  final CardSnapshot card;

  /// The server's total. The checkout's total is only an estimate.
  final Money total;
  final List<OrderEvent> timeline;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => <Object?>[
    id,
    status,
    items,
    slot,
    card,
    total,
    timeline,
    createdAt,
    updatedAt,
  ];
}

/// A service as it was priced when the order was placed.
class OrderItem extends Equatable {
  const OrderItem({
    required this.serviceId,
    required this.name,
    required this.price,
  });

  final String serviceId;
  final String name;
  final Money price;

  @override
  List<Object?> get props => <Object?>[serviceId, name, price];
}

/// The slot as it was when the order was placed.
class BookedSlot extends Equatable {
  const BookedSlot({
    required this.slotId,
    required this.startsAt,
    required this.endsAt,
  });

  final String slotId;
  final DateTime startsAt;
  final DateTime endsAt;

  @override
  List<Object?> get props => <Object?>[slotId, startsAt, endsAt];
}

/// The card's brand and last 4 as they were when the order was placed.
class CardSnapshot extends Equatable {
  const CardSnapshot({
    required this.paymentMethodId,
    required this.brand,
    required this.last4,
  });

  final String paymentMethodId;
  final CardBrand brand;
  final String last4;

  @override
  List<Object?> get props => <Object?>[paymentMethodId, brand, last4];
}

class OrderEvent extends Equatable {
  const OrderEvent({
    required this.id,
    required this.type,
    required this.at,
    this.message,
  });

  final String id;
  final OrderEventType type;
  final DateTime at;
  final String? message;

  @override
  List<Object?> get props => <Object?>[id, type, at, message];
}
