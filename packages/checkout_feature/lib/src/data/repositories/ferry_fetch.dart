import 'package:ferry/ferry.dart';

import '../../core/app_exception.dart';
import '../../core/app_exception_mapper.dart';
import '../../core/app_logger.dart';
import '../../core/result.dart';
import '../mappers/response_mapper.dart';

/// Runs [request] once and maps the server's answer with [map]. Cache
/// emissions are skipped: this waits for the server, or the first error.
Future<Result<T>> fetchOnce<TData, TVars, T>({
  required Client client,
  required AppLogger logger,
  required OperationRequest<TData, TVars> request,
  required T Function(TData data) map,
}) async {
  try {
    final OperationResponse<TData, TVars> response = await client
        .request(request)
        .firstWhere(
          (OperationResponse<TData, TVars> response) =>
              response.dataSource == DataSource.Link || response.hasErrors,
        );
    final TData? data = response.data;
    if (response.hasErrors || data == null) {
      throw exceptionFromResponse(response);
    }
    return Ok<T>(map(data));
  } on AppException catch (exception) {
    logger.log(
      'data.request.failed',
      fields: <String, Object?>{
        'operation': request.operation.operationName,
        'exception': '$exception',
      },
    );
    return Err<T>(mapExceptionToFailure(exception));
  }
}
