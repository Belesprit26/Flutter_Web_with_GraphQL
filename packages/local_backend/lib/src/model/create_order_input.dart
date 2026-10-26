/// createOrder's input once its shape has been checked. The business rules
/// (services exist, slot is free, card is the caller's) are checked by the
/// server against its current state.
class CreateOrderInput {
  const CreateOrderInput({
    required this.idempotencyKey,
    required this.serviceIds,
    required this.slotId,
    required this.paymentMethodId,
  });

  final String idempotencyKey;
  final List<String> serviceIds;
  final String slotId;
  final String paymentMethodId;
}
