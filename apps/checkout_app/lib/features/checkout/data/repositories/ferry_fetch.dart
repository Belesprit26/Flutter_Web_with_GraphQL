import 'package:checkout_app/core/app_failure.dart';
import 'package:checkout_app/core/app_logger.dart';
import 'package:checkout_app/core/result.dart';
import 'package:ferry/ferry.dart';

import '../mappers/response_mapper.dart';

/// Runs [request] once and maps the server's answer with [map]. Cache
/// emissions are skipped: this waits for the server, or the first error.
Future<Result<T>> fetchOnce<TData, TVars, T>({
  required Client client,
  required AppLogger logger,
  required OperationRequest<TData, TVars> request,
  required T Function(TData data) map,
}) async {
  final OperationResponse<TData, TVars> response = await client
      .request(request)
      .firstWhere(
        (OperationResponse<TData, TVars> response) =>
            response.dataSource == DataSource.Link || response.hasErrors,
      );
  final TData? data = response.data;
  final AppFailure failure;
  if (response.hasErrors || data == null) {
    failure = failureFromResponse(response);
  } else {
    try {
      return Ok<T>(map(data));
    } on FormatException catch (error) {
      failure = UnexpectedFailure(developerMessage: '$error');
    }
  }
  logger.log(
    'data.request.failed',
    fields: <String, Object?>{
      'operation': request.operation.operationName,
      'failure': failure.developerMessage,
    },
  );
  return Err<T>(failure);
}
