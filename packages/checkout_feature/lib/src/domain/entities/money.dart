import 'package:equatable/equatable.dart';

/// An amount in minor units (cents), never a double. Formatting it is a
/// presentation job.
class Money extends Equatable {
  const Money({required this.cents, required this.currency});

  const Money.zar(int cents) : this(cents: cents, currency: 'ZAR');

  final int cents;
  final String currency;

  Money operator +(Money other) {
    if (other.currency != currency) {
      throw ArgumentError('Cannot add $currency and ${other.currency}.');
    }
    return Money(cents: cents + other.cents, currency: currency);
  }

  @override
  List<Object?> get props => <Object?>[cents, currency];
}
