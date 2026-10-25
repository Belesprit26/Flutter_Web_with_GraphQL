/// A saved card token. The server never sees or stores a card number.
class PaymentMethodRecord {
  const PaymentMethodRecord({
    required this.id,
    required this.brand,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    required this.label,
    this.alwaysDeclines = false,
  });

  final String id;

  /// The schema's CardBrand: VISA or MASTERCARD.
  final String brand;
  final String last4;
  final int expiryMonth;
  final int expiryYear;
  final String label;

  /// Simulation only: the gateway declines every hold on this card. Never
  /// sent to the client.
  final bool alwaysDeclines;

  Map<String, Object?> toResponse() => <String, Object?>{
    '__typename': 'PaymentMethod',
    'id': id,
    'brand': brand,
    'last4': last4,
    'expiryMonth': expiryMonth,
    'expiryYear': expiryYear,
    'label': label,
  };
}
