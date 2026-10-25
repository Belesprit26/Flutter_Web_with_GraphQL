import 'package:checkout_feature/checkout_feature.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';

void main() {
  late InMemoryLocalStore device;
  late RecordingAppLogger logger;
  late LocalCheckoutAttemptStore store;

  setUp(() {
    device = InMemoryLocalStore();
    logger = RecordingAppLogger();
    store = LocalCheckoutAttemptStore(store: device, logger: logger);
  });

  final CheckoutAttempt attempt = CheckoutAttempt(
    idempotencyKey: '6f1c3a1e-0000-4000-8000-000000000001',
    userId: 'demo',
    request: const CheckoutRequest(
      serviceIds: <String>['svc-windows', 'svc-laundry'],
      slotId: 'slot-20261026-0800',
      paymentMethodId: 'pm-visa-4242',
    ),
    state: CheckoutAttemptState.submitting,
    createdAt: DateTime.utc(2026, 10, 25, 9),
  );

  test('an attempt comes back exactly as it was saved', () async {
    await store.save(attempt);

    expect(await store.load('demo'), attempt);
  });

  test('attempts are kept per user', () async {
    await store.save(attempt);

    expect(await store.load('someone-else'), isNull);
  });

  test('an unreadable attempt is treated as none, and logged', () async {
    device.values[LocalCheckoutAttemptStore.keyFor('demo')] = '{"half":';
    expect(await store.load('demo'), isNull);

    device.values[LocalCheckoutAttemptStore.keyFor('demo')] =
        '{"idempotencyKey":"k","userId":"demo","serviceIds":[],"slotId":"s",'
        '"paymentMethodId":"p","state":"exploded","createdAt":"2026-10-25T09:00:00Z",'
        '"orderId":null}';
    expect(await store.load('demo'), isNull);

    expect(
      logger.events.where(
        (String event) => event == 'checkout.attempt.unreadable',
      ),
      hasLength(2),
    );
  });
}
