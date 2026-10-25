import 'package:equatable/equatable.dart';

/// What the customer is about to confirm.
class CheckoutRequest extends Equatable {
  const CheckoutRequest({
    required this.serviceIds,
    required this.slotId,
    required this.paymentMethodId,
  });

  final List<String> serviceIds;
  final String slotId;
  final String paymentMethodId;

  /// One or two different services - the same rule the server enforces.
  bool get hasValidServices =>
      serviceIds.isNotEmpty &&
      serviceIds.length <= 2 &&
      serviceIds.toSet().length == serviceIds.length;

  /// The request as one canonical string. Same selection, same fingerprint,
  /// whatever order the services were picked in.
  String get fingerprint =>
      '${([...serviceIds]..sort()).join(',')}|$slotId|$paymentMethodId';

  @override
  List<Object?> get props => <Object?>[serviceIds, slotId, paymentMethodId];
}

enum CheckoutAttemptState { draft, submitting, completed, abandoned }

/// One intended checkout. Its idempotency key is minted once, when the
/// attempt starts, saved before any request goes out, and reused on every
/// retry and after a reload - the key belongs to the attempt, not the click.
class CheckoutAttempt extends Equatable {
  const CheckoutAttempt({
    required this.idempotencyKey,
    required this.userId,
    required this.request,
    required this.state,
    required this.createdAt,
    this.orderId,
  });

  final String idempotencyKey;
  final String userId;
  final CheckoutRequest request;
  final CheckoutAttemptState state;
  final DateTime createdAt;

  /// Set once the attempt is completed.
  final String? orderId;

  String get fingerprint => request.fingerprint;

  /// Nothing has been confirmed yet, or the answer never came back. A confirm
  /// with the same selection reuses this attempt's key.
  bool get isOpen =>
      state == CheckoutAttemptState.draft ||
      state == CheckoutAttemptState.submitting;

  CheckoutAttempt withState(CheckoutAttemptState state, {String? orderId}) =>
      CheckoutAttempt(
        idempotencyKey: idempotencyKey,
        userId: userId,
        request: request,
        state: state,
        createdAt: createdAt,
        orderId: orderId ?? this.orderId,
      );

  @override
  List<Object?> get props => <Object?>[
    idempotencyKey,
    userId,
    request,
    state,
    createdAt,
    orderId,
  ];
}
