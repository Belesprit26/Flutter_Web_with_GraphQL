import 'package:intl/intl.dart';

import '../../domain/entities/catalog.dart';
import '../../domain/entities/money.dart';
import '../../domain/entities/order.dart';

// How things look is a presentation decision, so it lives here as extensions
// and the domain stays plain.

final NumberFormat _rand = NumberFormat.currency(
  locale: 'en_US',
  symbol: 'R',
  decimalDigits: 2,
);

extension MoneyFormatting on Money {
  /// One format everywhere: R1,250.00.
  String get formatted => currency == 'ZAR'
      ? _rand.format(cents / 100)
      : '$currency ${cents / 100}';
}

/// Johannesburg is UTC+2 all year, with no daylight saving.
const Duration _sastOffset = Duration(hours: 2);

final DateFormat _dayFormat = DateFormat('EEE d MMM');
final DateFormat _timeFormat = DateFormat('HH:mm');

extension SastFormatting on DateTime {
  /// The same instant as Johannesburg wall-clock time, so a reviewer abroad
  /// sees the times a customer here would.
  DateTime get _inSast => toUtc().add(_sastOffset);

  /// "Mon 26 Oct".
  String get sastDay => _dayFormat.format(_inSast);

  /// "08:00".
  String get sastTime => _timeFormat.format(_inSast);

  /// The Johannesburg calendar date, for grouping slots by day.
  DateTime get sastDate =>
      DateTime.utc(_inSast.year, _inSast.month, _inSast.day);
}

extension SlotFormatting on Slot {
  /// "08:00-10:00".
  String get timeRange => '${startsAt.sastTime}-${endsAt.sastTime}';
}

extension BookedSlotFormatting on BookedSlot {
  /// "Mon 26 Oct · 08:00-10:00 SAST".
  String get label =>
      '${startsAt.sastDay} · ${startsAt.sastTime}-${endsAt.sastTime} SAST';
}

extension CardBrandFormatting on CardBrand {
  String get label => switch (this) {
    CardBrand.visa => 'Visa',
    CardBrand.mastercard => 'Mastercard',
  };
}

extension PaymentMethodFormatting on PaymentMethod {
  /// "Visa •••• 4242".
  String get maskedNumber => '${brand.label} •••• $last4';

  String get expiry =>
      'exp ${expiryMonth.toString().padLeft(2, '0')}/${expiryYear % 100}';
}

extension CardSnapshotFormatting on CardSnapshot {
  String get maskedNumber => '${brand.label} •••• $last4';
}

extension DurationFormatting on Duration {
  /// "3 h" or "1 h 30 min".
  String get formatted {
    final int hours = inHours;
    final int minutes = inMinutes % 60;
    if (minutes == 0) {
      return '$hours h';
    }
    return hours == 0 ? '$minutes min' : '$hours h $minutes min';
  }
}

extension OrderStatusFormatting on OrderStatus {
  String get label => switch (this) {
    OrderStatus.holdPending => 'Confirming hold',
    OrderStatus.holdPlaced => 'Hold placed',
    OrderStatus.holdFailed => 'Hold failed',
  };
}

extension OrderEventTypeFormatting on OrderEventType {
  String get label => switch (this) {
    OrderEventType.created => 'Order created',
    OrderEventType.holdRequested => 'Hold requested',
    OrderEventType.holdPlaced => 'Hold placed',
    OrderEventType.holdFailed => 'Hold declined',
  };
}

extension ShortOrderId on Order {
  /// The id without its prefix, for headings: "Order 7k3q9x2m".
  String get shortId => id.startsWith('ord-') ? id.substring(4) : id;
}
