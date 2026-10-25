import '../../core/result.dart';
import '../entities/catalog.dart';
import '../entities/checkout.dart';
import '../entities/order.dart';
import '../entities/session.dart';

abstract interface class CatalogRepository {
  Future<Result<List<Service>>> services();

  Future<Result<List<Slot>>> availableSlots({int days = 7});

  Future<Result<List<PaymentMethod>>> paymentMethods();
}

class PlacedOrder {
  const PlacedOrder({required this.order, required this.replayed});

  final Order order;

  /// True when the server had seen the idempotency key and returned the
  /// original order instead of making a new one.
  final bool replayed;
}

abstract interface class OrderRepository {
  Future<Result<PlacedOrder>> createOrder({
    required String idempotencyKey,
    required CheckoutRequest request,
  });

  /// The order, then every change until it's final. Emits `Ok(null)` only
  /// once the server has said the order doesn't exist for this account -
  /// never while it's still loading.
  Stream<Result<Order?>> watchOrder(String orderId);
}

/// Where the user's latest checkout attempt is kept between page loads.
abstract interface class CheckoutAttemptStore {
  Future<CheckoutAttempt?> load(String userId);

  Future<void> save(CheckoutAttempt attempt);
}

abstract interface class SessionRepository {
  Future<Session?> restore();

  Future<void> save(Session session);

  Future<void> clear();
}

/// Device key-value storage. The domain owns the port; the app implements it.
abstract interface class LocalStore {
  Future<String?> read(String key);

  Future<void> write(String key, String value);

  Future<void> remove(String key);
}
