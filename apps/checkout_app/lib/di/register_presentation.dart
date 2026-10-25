import 'package:checkout_feature/checkout_feature.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';

void registerPresentation(GetIt getIt, {required SessionController session}) {
  // View models are factories: each page visit gets a fresh one, created by
  // its route and disposed with it. The routes are protected, so a session
  // exists whenever these run.
  getIt
    ..registerSingleton<SessionController>(session)
    ..registerFactoryParam<CatalogViewModel, List<String>, void>(
      (List<String> selected, _) => CatalogViewModel(
        catalog: getIt<CatalogRepository>(),
        initiallySelected: selected,
      ),
    )
    ..registerFactoryParam<CheckoutViewModel, CheckoutArgs, void>(
      (CheckoutArgs args, _) => CheckoutViewModel(
        args: args,
        userId: session.userId!,
        catalog: getIt<CatalogRepository>(),
        placeOrder: getIt<PlaceOrderUseCase>(),
        attempts: getIt<CheckoutAttemptStore>(),
        logger: getIt<AppLogger>(),
      ),
    )
    ..registerFactoryParam<OrderDetailsViewModel, String, void>(
      (String orderId, _) => OrderDetailsViewModel(
        orderId: orderId,
        userId: session.userId!,
        orders: getIt<OrderRepository>(),
        placeOrder: getIt<PlaceOrderUseCase>(),
      ),
    )
    ..registerSingleton<GoRouter>(
      buildRouter(
        session: session,
        viewModels: ViewModelFactories(
          catalog: (List<String> selected) =>
              getIt<CatalogViewModel>(param1: selected),
          checkout: (CheckoutArgs args) =>
              getIt<CheckoutViewModel>(param1: args),
          orderDetails: (String orderId) =>
              getIt<OrderDetailsViewModel>(param1: orderId),
        ),
      ),
    );
}
