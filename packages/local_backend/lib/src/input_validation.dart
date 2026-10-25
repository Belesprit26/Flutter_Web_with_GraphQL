import 'model/create_order_input.dart';
import 'server_exception.dart';
import 'slot_schedule.dart';

// Raw GraphQL argument values become typed input here, before any logic runs.
// Anything that doesn't fit is VALIDATION_FAILED.

String parseId(Object? raw, {required String argument}) {
  if (raw is String && raw.isNotEmpty) {
    return raw;
  }
  throw ServerException(
    ErrorCodes.validationFailed,
    '"$argument" must be a non-empty ID.',
  );
}

int parseDays(Object? raw) {
  if (raw is int && raw >= 1 && raw <= SlotSchedule.maxDays) {
    return raw;
  }
  throw const ServerException(
    ErrorCodes.validationFailed,
    '"days" must be between 1 and ${SlotSchedule.maxDays}.',
  );
}

CreateOrderInput parseCreateOrderInput(Object? raw) {
  if (raw
      case {
        'idempotencyKey': final String idempotencyKey,
        'serviceIds': final List<Object?> serviceIds,
        'slotId': final String slotId,
        'paymentMethodId': final String paymentMethodId,
      }
      when idempotencyKey.isNotEmpty &&
          idempotencyKey.length <= 64 &&
          serviceIds.every((Object? id) => id is String && id.isNotEmpty) &&
          slotId.isNotEmpty &&
          paymentMethodId.isNotEmpty) {
    return CreateOrderInput(
      idempotencyKey: idempotencyKey,
      serviceIds: List<String>.unmodifiable(serviceIds.cast<String>()),
      slotId: slotId,
      paymentMethodId: paymentMethodId,
    );
  }
  throw const ServerException(
    ErrorCodes.validationFailed,
    'createOrder input is incomplete or malformed.',
  );
}
