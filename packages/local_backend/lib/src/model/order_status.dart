/// Order statuses, spelled exactly as the schema's OrderStatus enum.
enum OrderStatus {
  holdPending('HOLD_PENDING'),
  holdPlaced('HOLD_PLACED'),
  holdFailed('HOLD_FAILED');

  const OrderStatus(this.wireName);

  final String wireName;

  static OrderStatus fromWireName(String name) => values.firstWhere(
    (OrderStatus status) => status.wireName == name,
    orElse: () => throw FormatException('Unknown order status "$name".'),
  );
}

/// Timeline event types, spelled exactly as the schema's OrderEventType enum.
enum OrderEventType {
  created('CREATED'),
  holdRequested('HOLD_REQUESTED'),
  holdPlaced('HOLD_PLACED'),
  holdFailed('HOLD_FAILED');

  const OrderEventType(this.wireName);

  final String wireName;

  static OrderEventType fromWireName(String name) => values.firstWhere(
    (OrderEventType type) => type.wireName == name,
    orElse: () => throw FormatException('Unknown order event type "$name".'),
  );
}
