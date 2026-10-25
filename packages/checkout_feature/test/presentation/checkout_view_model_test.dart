import 'dart:async';

import 'package:checkout_feature/checkout_feature.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fakes.dart';

const String user = 'demo-user';
const String openSlot = 'slot-20261026-0800';
const String takenSlot = 'slot-20261026-1000';

class FakeCatalog implements CatalogRepository {
  @override
  Future<Result<List<Service>>> services() async =>
      const Ok<List<Service>>(<Service>[
        Service(
          id: 'svc-a',
          name: 'A',
          description: '',
          price: Money.zar(45000),
          duration: Duration(hours: 3),
        ),
        Service(
          id: 'svc-b',
          name: 'B',
          description: '',
          price: Money.zar(40000),
          duration: Duration(hours: 2),
        ),
      ]);

  @override
  Future<Result<List<Slot>>> availableSlots({int days = 7}) async =>
      Ok<List<Slot>>(<Slot>[
        Slot(
          id: openSlot,
          startsAt: DateTime.utc(2026, 10, 26, 6),
          endsAt: DateTime.utc(2026, 10, 26, 8),
          available: true,
        ),
        Slot(
          id: takenSlot,
          startsAt: DateTime.utc(2026, 10, 26, 8),
          endsAt: DateTime.utc(2026, 10, 26, 10),
          available: false,
        ),
      ]);

  @override
  Future<Result<List<PaymentMethod>>> paymentMethods() async =>
      const Ok<List<PaymentMethod>>(<PaymentMethod>[
        PaymentMethod(
          id: 'pm-visa-4242',
          brand: CardBrand.visa,
          last4: '4242',
          expiryMonth: 8,
          expiryYear: 2029,
          label: 'Personal Visa',
        ),
      ]);
}

/// Counts createOrder calls and answers only when the test says so.
class SlowOrders implements OrderRepository {
  final List<String> keys = <String>[];
  final Completer<void> answer = Completer<void>();

  @override
  Future<Result<PlacedOrder>> createOrder({
    required String idempotencyKey,
    required CheckoutRequest request,
  }) async {
    keys.add(idempotencyKey);
    await answer.future;
    return Ok<PlacedOrder>(
      PlacedOrder(order: orderFor(request), replayed: false),
    );
  }

  @override
  Stream<Result<Order?>> watchOrder(String orderId) =>
      const Stream<Result<Order?>>.empty();
}

Order orderFor(CheckoutRequest request) => Order(
  id: 'ord-1',
  status: OrderStatus.holdPending,
  items: const <OrderItem>[],
  slot: BookedSlot(
    slotId: request.slotId,
    startsAt: DateTime.utc(2026, 10, 26, 6),
    endsAt: DateTime.utc(2026, 10, 26, 8),
  ),
  card: CardSnapshot(
    paymentMethodId: request.paymentMethodId,
    brand: CardBrand.visa,
    last4: '4242',
  ),
  total: const Money.zar(85000),
  timeline: const <OrderEvent>[],
  createdAt: DateTime.utc(2026, 10, 25),
  updatedAt: DateTime.utc(2026, 10, 25),
);

void main() {
  late InMemoryLocalStore device;
  late RecordingAppLogger logger;
  late LocalCheckoutAttemptStore attempts;
  late SlowOrders orders;

  setUp(() {
    device = InMemoryLocalStore();
    logger = RecordingAppLogger();
    attempts = LocalCheckoutAttemptStore(store: device, logger: logger);
    orders = SlowOrders();
  });

  CheckoutViewModel viewModel({String? slotId}) {
    final CheckoutViewModel model = CheckoutViewModel(
      args: (serviceIds: const <String>['svc-a', 'svc-b'], slotId: slotId),
      userId: user,
      catalog: FakeCatalog(),
      placeOrder: PlaceOrderUseCase(
        orders: orders,
        attempts: attempts,
        logger: logger,
      ),
      attempts: attempts,
      logger: logger,
    );
    addTearDown(model.dispose);
    return model;
  }

  /// Waits until the view model leaves loading.
  Future<void> settle(CheckoutViewModel model) async {
    for (int i = 0; i < 50 && model.phase == CheckoutPhase.loading; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  CheckoutAttempt attempt(
    CheckoutAttemptState state, {
    String? orderId,
    String slotId = openSlot,
  }) => CheckoutAttempt(
    idempotencyKey: 'key-from-before',
    userId: user,
    request: CheckoutRequest(
      serviceIds: const <String>['svc-b', 'svc-a'],
      slotId: slotId,
      paymentMethodId: 'pm-visa-4242',
    ),
    state: state,
    createdAt: DateTime.utc(2026, 10, 25),
    orderId: orderId,
  );

  test('confirm pressed twice without waiting sends one request', () async {
    final CheckoutViewModel model = viewModel(slotId: openSlot);
    await settle(model);
    expect(model.canConfirm, isTrue);

    final Future<void> first = model.confirm.execute();
    final Future<void> second = model.confirm.execute();
    expect(model.canConfirm, isFalse, reason: 'the button is disabled');
    orders.answer.complete();
    await Future.wait(<Future<void>>[first, second]);

    expect(orders.keys, hasLength(1));
    expect(model.takeOrderToOpen(), 'ord-1');
    expect(
      logger.entries.where(
        (LoggedEvent entry) =>
            entry.event == 'checkout.duplicate_suppressed' &&
            entry.fields['layer'] == 'command',
      ),
      hasLength(1),
    );
  });

  test(
    'a confirm that never got its answer is resumed with the same key',
    () async {
      await attempts.save(attempt(CheckoutAttemptState.submitting));
      orders.answer.complete();

      final CheckoutViewModel model = viewModel();
      final List<CheckoutPhase> phases = <CheckoutPhase>[];
      model.addListener(() => phases.add(model.phase));
      await settle(model);
      await Future<void>.delayed(Duration.zero);

      expect(phases, contains(CheckoutPhase.resuming));
      expect(orders.keys, <String>['key-from-before']);
      expect(model.takeOrderToOpen(), 'ord-1');
    },
  );

  test('coming back to a placed checkout shows that, not the form', () async {
    await attempts.save(
      attempt(CheckoutAttemptState.completed, orderId: 'ord-earlier'),
    );

    final CheckoutViewModel model = viewModel(slotId: openSlot);
    await settle(model);

    expect(model.phase, CheckoutPhase.alreadyPlaced);
    expect(model.alreadyPlacedOrderId, 'ord-earlier');
    expect(orders.keys, isEmpty);
  });

  test(
    'arriving from the catalogue with the same services starts fresh',
    () async {
      await attempts.save(
        attempt(CheckoutAttemptState.completed, orderId: 'ord-earlier'),
      );

      final CheckoutViewModel model = viewModel(); // no slot in the URL yet
      await settle(model);

      expect(model.phase, CheckoutPhase.ready);
    },
  );

  test('a slot from the link that has gone is dropped with a notice', () async {
    final CheckoutViewModel model = viewModel(slotId: takenSlot);
    await settle(model);

    expect(model.selectedSlotId, isNull);
    expect(model.notice, contains('no longer available'));
    expect(model.canConfirm, isFalse);
  });
}
