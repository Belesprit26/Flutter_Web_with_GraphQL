import 'package:equatable/equatable.dart';

import 'money.dart';

class Service extends Equatable {
  const Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
  });

  final String id;
  final String name;
  final String description;
  final Money price;
  final Duration duration;

  @override
  List<Object?> get props => <Object?>[id, name, description, price, duration];
}

/// A two-hour arrival window. Times are UTC instants; showing them in
/// Johannesburg time is a presentation job.
class Slot extends Equatable {
  const Slot({
    required this.id,
    required this.startsAt,
    required this.endsAt,
    required this.available,
  });

  final String id;
  final DateTime startsAt;
  final DateTime endsAt;
  final bool available;

  @override
  List<Object?> get props => <Object?>[id, startsAt, endsAt, available];
}

enum CardBrand { visa, mastercard }

/// A saved card token. Never a card number.
class PaymentMethod extends Equatable {
  const PaymentMethod({
    required this.id,
    required this.brand,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    required this.label,
  });

  final String id;
  final CardBrand brand;
  final String last4;
  final int expiryMonth;
  final int expiryYear;
  final String label;

  @override
  List<Object?> get props => <Object?>[
    id,
    brand,
    last4,
    expiryMonth,
    expiryYear,
    label,
  ];
}
