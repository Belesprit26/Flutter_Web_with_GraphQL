import 'package:checkout_feature/checkout_feature.dart';
import 'package:checkout_feature/src/core/app_exception.dart';
import 'package:checkout_feature/src/data/mappers/response_mapper.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_api/graphql_api.dart';
import 'package:local_backend/local_backend.dart';

import '../support/fakes.dart';

void main() {
  late LocalServer server;
  late Client client;
  late FerryCatalogRepository catalog;
  late FerryOrderRepository orders;
  String? signedInAs;

  setUp(() async {
    signedInAs = 'demo';
    server = await LocalServer.start(
      store: InMemoryKeyValueStore(),
      holdDelay: const Duration(milliseconds: 20),
    );
    client = createGraphQLClient(
      link: LocalServerLink(server: server, currentUserId: () => signedInAs),
    );
    final RecordingAppLogger logger = RecordingAppLogger();
    catalog = FerryCatalogRepository(client: client, logger: logger);
    orders = FerryOrderRepository(client: client, logger: logger);
  });

  tearDown(() async {
    await client.dispose();
    await server.dispose();
  });

  T valueOf<T>(Result<T> result) => result.fold(
    ok: (T value) => value,
    err: (AppFailure failure) => fail('Expected a value, got $failure'),
  );

  AppFailure failureOf<T>(Result<T> result) => result.fold(
    ok: (T value) => fail('Expected a failure, got $value'),
    err: (AppFailure failure) => failure,
  );

  group('catalogue', () {
    test('services become entities with Money and Duration', () async {
      final List<Service> services = valueOf(await catalog.services());

      final Service regular = services.firstWhere(
        (Service service) => service.id == 'svc-regular-clean',
      );
      expect(regular.price, const Money.zar(45000));
      expect(regular.duration, const Duration(hours: 3));
    });

    test('slot times arrive as UTC instants', () async {
      final List<Slot> slots = valueOf(await catalog.availableSlots());

      expect(slots, hasLength(28));
      expect(slots.first.startsAt.isUtc, isTrue);
    });

    test('a signed-out caller gets a session failure, not a crash', () async {
      signedInAs = null;

      expect(
        failureOf(await catalog.paymentMethods()),
        isA<SessionExpiredFailure>(),
      );
    });

    test('bad input comes back as a validation failure', () async {
      expect(
        failureOf(await catalog.availableSlots(days: 99)),
        isA<ValidationFailure>(),
      );
    });
  });

  group('watching an order', () {
    test('an unknown order is reported once the server answers', () async {
      final List<Result<Order?>> results = await orders
          .watchOrder('ord-nope')
          .take(1)
          .toList();

      expect(valueOf(results.single), isNull);
    });

    test('a pending order flips to placed through the subscription', () async {
      final String slotId = valueOf(
        await catalog.availableSlots(),
      ).firstWhere((Slot slot) => slot.available).id;
      final PlacedOrder placed = valueOf(
        await orders.createOrder(
          idempotencyKey: 'key-1',
          request: CheckoutRequest(
            serviceIds: const <String>['svc-laundry'],
            slotId: slotId,
            paymentMethodId: 'pm-visa-4242',
          ),
        ),
      );
      expect(placed.order.status, OrderStatus.holdPending);

      final Order settled = await orders
          .watchOrder(placed.order.id)
          .map((Result<Order?> result) => valueOf(result)!)
          .firstWhere((Order order) => order.status.isTerminal)
          .timeout(const Duration(seconds: 5));

      expect(settled.status, OrderStatus.holdPlaced);
      expect(settled.timeline.last.type, OrderEventType.holdPlaced);
    });
  });

  group('link errors', () {
    OperationResponse<GServicesData, GServicesVars> failedWith(Object error) =>
        OperationResponse<GServicesData, GServicesVars>(
          operationRequest: GServicesReq(),
          linkException: TypedLinkException(error, StackTrace.current),
          dataSource: DataSource.None,
        );

    test('a dropped connection is a network problem', () {
      expect(
        exceptionFromResponse(failedWith(const ConnectionDropped())),
        isA<NetworkException>(),
      );
    });

    test('a response that does not fit the types is a mapping problem', () {
      expect(
        exceptionFromResponse(failedWith(StateError('bad shape'))),
        isA<MappingException>(),
      );
    });
  });
}
