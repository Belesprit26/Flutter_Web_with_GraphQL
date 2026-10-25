import 'package:checkout_feature/checkout_feature.dart';
import 'package:get_it/get_it.dart';

void registerDomain(GetIt getIt) {
  // One instance for the whole app, so single-flight spans every page.
  getIt.registerLazySingleton<PlaceOrderUseCase>(
    () => PlaceOrderUseCase(
      orders: getIt<OrderRepository>(),
      attempts: getIt<CheckoutAttemptStore>(),
      logger: getIt<AppLogger>(),
    ),
  );
}
