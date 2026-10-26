import 'dart:async';

import 'package:ferry/ferry.dart';
import 'package:graphql_api/graphql_api.dart';

import 'package:checkout_app/core/app_failure.dart';
import 'package:checkout_app/core/app_logger.dart';
import 'package:checkout_app/core/result.dart';
import '../../domain/entities/checkout.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/repositories.dart';
import '../mappers/graphql_mappers.dart';
import '../mappers/response_mapper.dart';
import 'ferry_fetch.dart';

class FerryOrderRepository implements OrderRepository {
  const FerryOrderRepository({
    required Client client,
    required AppLogger logger,
  }) : _client = client,
       _logger = logger;

  final Client _client;
  final AppLogger _logger;

  @override
  Future<Result<PlacedOrder>> createOrder({
    required String idempotencyKey,
    required CheckoutRequest request,
  }) => fetchOnce(
    client: _client,
    logger: _logger,
    request: GCreateOrderReq(
      (b) => b
        ..vars.input.idempotencyKey = idempotencyKey
        ..vars.input.serviceIds.replace(request.serviceIds)
        ..vars.input.slotId = request.slotId
        ..vars.input.paymentMethodId = request.paymentMethodId,
    ),
    map: (GCreateOrderData data) => PlacedOrder(
      order: mapOrder(data.createOrder.order),
      replayed: data.createOrder.replayed,
    ),
  );

  /// Watches the OrderDetails query and, while the order isn't final, keeps
  /// the orderUpdated subscription open. ferry writes subscription results
  /// into its cache only while something listens, and the cache write is
  /// what makes the watched query emit the new status.
  @override
  Stream<Result<Order?>> watchOrder(String orderId) {
    StreamSubscription<OperationResponse<GOrderDetailsData, GOrderDetailsVars>>?
    details;
    StreamSubscription<OperationResponse<GOrderUpdatedData, GOrderUpdatedVars>>?
    updates;
    bool settled = false;
    late final StreamController<Result<Order?>> controller;

    void onDetails(
      OperationResponse<GOrderDetailsData, GOrderDetailsVars> response,
    ) {
      if (response.hasErrors) {
        controller.add(_failure<Order?>(failureFromResponse(response)));
        return;
      }
      final GOrderDetailsData_order? data = response.data?.order;
      if (data == null) {
        // Still loading, or nothing in the cache yet: not an answer. Only the
        // server can say the order doesn't exist.
        if (response.dataSource == DataSource.Link && response.data != null) {
          controller.add(const Ok<Order?>(null));
        }
        return;
      }

      final Order order;
      try {
        order = mapOrder(data);
      } on FormatException catch (error) {
        controller.add(
          _failure<Order?>(UnexpectedFailure(developerMessage: '$error')),
        );
        return;
      }
      controller.add(Ok<Order?>(order));

      if (order.status.isTerminal) {
        settled = true;
        unawaited(updates?.cancel());
        updates = null;
      } else if (!settled) {
        updates ??= _client
            .request(GOrderUpdatedReq((b) => b..vars.id = orderId))
            .listen((_) {});
      }
    }

    controller = StreamController<Result<Order?>>(
      onListen: () {
        details = _client
            .request(GOrderDetailsReq((b) => b..vars.id = orderId))
            .listen(onDetails);
      },
      onCancel: () async {
        await details?.cancel();
        await updates?.cancel();
      },
    );
    return controller.stream;
  }

  Result<T> _failure<T>(AppFailure failure) {
    _logger.log(
      'data.order_watch.failed',
      fields: <String, Object?>{'failure': failure.developerMessage},
    );
    return Err<T>(failure);
  }
}
