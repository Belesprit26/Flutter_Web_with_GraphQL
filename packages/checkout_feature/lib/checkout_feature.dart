/// The checkout journey: catalogue, checkout, order details and sign-in.
/// Public exports only; everything else lives under src/.
library;

export 'src/core/app_failure.dart';
export 'src/core/app_logger.dart';
export 'src/core/result.dart';
export 'src/data/repositories/ferry_catalog_repository.dart';
export 'src/data/repositories/ferry_order_repository.dart';
export 'src/data/repositories/local_checkout_attempt_store.dart';
export 'src/data/repositories/local_session_repository.dart';
export 'src/domain/entities/catalog.dart';
export 'src/domain/entities/checkout.dart';
export 'src/domain/entities/money.dart';
export 'src/domain/entities/order.dart';
export 'src/domain/entities/session.dart';
export 'src/domain/repositories/repositories.dart';
export 'src/domain/usecases/place_order_use_case.dart';
export 'src/presentation/catalog/catalog_screen.dart';
export 'src/presentation/catalog/catalog_view_model.dart';
export 'src/presentation/checkout/checkout_screen.dart';
export 'src/presentation/checkout/checkout_view_model.dart';
export 'src/presentation/command.dart';
export 'src/presentation/not_found/not_found_screen.dart';
export 'src/presentation/order_details/order_details_screen.dart';
export 'src/presentation/order_details/order_details_view_model.dart';
export 'src/presentation/session/session_controller.dart';
export 'src/presentation/shared/app_page.dart';
export 'src/presentation/shared/view_model_host.dart';
export 'src/presentation/sign_in/sign_in_screen.dart';
