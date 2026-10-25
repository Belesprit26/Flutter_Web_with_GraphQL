import 'package:gql/ast.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_link/gql_link.dart';

import 'seed_data.dart';

typedef _Resolver = Object? Function(Map<String, dynamic> variables);

/// The Link the GraphQL client talks to. Instead of sending an operation over
/// the network it answers it in-process: each root field in the operation is
/// handed to the resolver registered for that field.
class LocalServerLink extends Link {
  LocalServerLink();

  late final Map<String, _Resolver> _queryResolvers = <String, _Resolver>{
    'services': (_) => <Object?>[
      for (final service in seedServices) service.toResponse(),
    ],
  };

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final OperationDefinitionNode operation = _findOperation(request.operation);
    final Map<String, Object?> data = <String, Object?>{};

    for (final FieldNode field
        in operation.selectionSet.selections.whereType<FieldNode>()) {
      final String fieldName = field.name.value;
      final String responseKey = field.alias?.value ?? fieldName;

      if (fieldName == '__typename') {
        data[responseKey] = _rootTypeName(operation.type);
        continue;
      }

      final _Resolver? resolver = operation.type == OperationType.query
          ? _queryResolvers[fieldName]
          : null;
      if (resolver == null) {
        yield _errorResponse(
          'No resolver for ${operation.type.name} field "$fieldName".',
          code: 'NOT_IMPLEMENTED',
        );
        return;
      }
      data[responseKey] = resolver(request.variables);
    }

    yield Response(data: data, response: const <String, dynamic>{});
  }

  OperationDefinitionNode _findOperation(Operation operation) {
    final Iterable<OperationDefinitionNode> definitions = operation
        .document
        .definitions
        .whereType<OperationDefinitionNode>();
    final String? operationName = operation.operationName;
    if (operationName == null) {
      return definitions.single;
    }
    return definitions.singleWhere(
      (OperationDefinitionNode definition) =>
          definition.name?.value == operationName,
    );
  }

  String _rootTypeName(OperationType type) => switch (type) {
    OperationType.query => 'Query',
    OperationType.mutation => 'Mutation',
    OperationType.subscription => 'Subscription',
  };

  Response _errorResponse(String message, {required String code}) {
    return Response(
      errors: <GraphQLError>[
        GraphQLError(
          message: message,
          extensions: <String, dynamic>{'code': code},
        ),
      ],
      response: const <String, dynamic>{},
    );
  }
}
