import 'package:ferry/ferry.dart';
import 'package:graphql_api/graphql_api.dart';

import 'package:checkout_app/core/app_logger.dart';
import 'package:checkout_app/core/result.dart';
import '../../domain/entities/catalog.dart';
import '../../domain/repositories/repositories.dart';
import '../mappers/graphql_mappers.dart';
import 'ferry_fetch.dart';

class FerryCatalogRepository implements CatalogRepository {
  const FerryCatalogRepository({
    required Client client,
    required AppLogger logger,
  }) : _client = client,
       _logger = logger;

  final Client _client;
  final AppLogger _logger;

  @override
  Future<Result<List<Service>>> services() => fetchOnce(
    client: _client,
    logger: _logger,
    request: GServicesReq(),
    map: (GServicesData data) => <Service>[
      for (final GServicesData_services service in data.services)
        mapService(service),
    ],
  );

  @override
  Future<Result<List<Slot>>> availableSlots({int days = 7}) => fetchOnce(
    client: _client,
    logger: _logger,
    request: GAvailableSlotsReq((b) => b..vars.days = days),
    map: (GAvailableSlotsData data) => <Slot>[
      for (final GAvailableSlotsData_availableSlots slot in data.availableSlots)
        mapSlot(slot),
    ],
  );

  @override
  Future<Result<List<PaymentMethod>>> paymentMethods() => fetchOnce(
    client: _client,
    logger: _logger,
    request: GPaymentMethodsReq(),
    map: (GPaymentMethodsData data) => <PaymentMethod>[
      for (final GPaymentMethodsData_paymentMethods card in data.paymentMethods)
        mapPaymentMethod(card),
    ],
  );
}
