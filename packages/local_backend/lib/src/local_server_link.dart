import 'package:gql/ast.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_link/gql_link.dart' show Link, NextLink;

import 'local_server.dart';
import 'resolvers/resolver_context.dart';
import 'resolvers/resolvers.dart';
import 'server_exception.dart';
import 'server_log.dart';

/// The Link the GraphQL client talks to, in place of an HTTP link. It answers
/// operations in-process: each root field goes to its resolver on the
/// [LocalServer]. The caller comes from [currentUserId] - the in-app version
/// of an auth header, read in one place so no resolver can forget it.
class LocalServerLink extends Link {
  LocalServerLink({
    required LocalServer server,
    required String? Function() currentUserId,
    this.networkDelay = Duration.zero,
    ServerLog log = ignoreServerEvents,
  }) : _server = server,
       _currentUserId = currentUserId,
       _log = log;

  final LocalServer _server;
  final String? Function() _currentUserId;
  final ServerLog _log;

  /// Applied before a query or mutation reaches its resolver, never inside
  /// one. Without it a double click can't be shown and loading states flash
  /// past unseen.
  final Duration networkDelay;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    final OperationDefinitionNode? operation = _findOperation(
      request.operation,
    );
    if (operation == null) {
      return Stream<Response>.value(
        _errorResponse(
          ErrorCodes.validationFailed,
          'The document has no matching operation.',
        ),
      );
    }
    return operation.type == OperationType.subscription
        ? _subscribe(operation, request)
        : _execute(operation, request);
  }

  Stream<Response> _execute(
    OperationDefinitionNode operation,
    Request request,
  ) async* {
    if (networkDelay > Duration.zero) {
      await Future<void>.delayed(networkDelay);
    }
    final String? userId = _currentUserId();
    final Map<String, FieldResolver> resolvers =
        operation.type == OperationType.mutation
        ? mutationResolvers
        : queryResolvers;
    final Map<String, Object?> data = <String, Object?>{};

    try {
      for (final FieldNode field in _rootFields(operation)) {
        final String name = field.name.value;
        final String responseKey = field.alias?.value ?? name;
        if (name == '__typename') {
          data[responseKey] = _rootTypeName(operation.type);
          continue;
        }
        final FieldResolver? resolver = resolvers[name];
        if (resolver == null) {
          throw ServerException(
            ErrorCodes.notImplemented,
            'No resolver for ${operation.type.name} field "$name".',
          );
        }
        data[responseKey] = await resolver(
          ResolverContext(
            server: _server,
            userId: userId,
            arguments: _arguments(field, request.variables),
          ),
        );
      }
    } on ServerException catch (error) {
      yield _errorResponse(error.code, error.message);
      return;
    } catch (error) {
      _log('server.request.failed', <String, Object?>{'error': '$error'});
      yield _errorResponse(
        ErrorCodes.internal,
        'Something went wrong on the server.',
      );
      return;
    }

    yield Response(data: data, response: const <String, dynamic>{});
  }

  Stream<Response> _subscribe(
    OperationDefinitionNode operation,
    Request request,
  ) async* {
    final List<FieldNode> fields = _rootFields(
      operation,
    ).where((FieldNode field) => field.name.value != '__typename').toList();
    if (fields.length != 1) {
      yield _errorResponse(
        ErrorCodes.validationFailed,
        'A subscription selects exactly one root field.',
      );
      return;
    }
    final FieldNode field = fields.single;
    final SubscriptionResolver? resolver =
        subscriptionResolvers[field.name.value];
    if (resolver == null) {
      yield _errorResponse(
        ErrorCodes.notImplemented,
        'No resolver for subscription field "${field.name.value}".',
      );
      return;
    }

    final String responseKey = field.alias?.value ?? field.name.value;
    final bool wantsTypename = _rootFields(
      operation,
    ).any((FieldNode field) => field.name.value == '__typename');
    try {
      final Stream<Object?> events = resolver(
        ResolverContext(
          server: _server,
          userId: _currentUserId(),
          arguments: _arguments(field, request.variables),
        ),
      );
      await for (final Object? event in events) {
        yield Response(
          data: <String, Object?>{
            if (wantsTypename) '__typename': 'Subscription',
            responseKey: event,
          },
          response: const <String, dynamic>{},
        );
      }
    } on ServerException catch (error) {
      yield _errorResponse(error.code, error.message);
    }
  }

  OperationDefinitionNode? _findOperation(Operation operation) {
    final List<OperationDefinitionNode> definitions = operation
        .document
        .definitions
        .whereType<OperationDefinitionNode>()
        .toList();
    final String? operationName = operation.operationName;
    if (operationName == null) {
      return definitions.length == 1 ? definitions.single : null;
    }
    for (final OperationDefinitionNode definition in definitions) {
      if (definition.name?.value == operationName) {
        return definition;
      }
    }
    return null;
  }

  // Root-level fragments aren't supported; the operations in this repo don't
  // use them.
  Iterable<FieldNode> _rootFields(OperationDefinitionNode operation) =>
      operation.selectionSet.selections.whereType<FieldNode>();

  /// The field's arguments by argument name, with variables substituted.
  Map<String, Object?> _arguments(
    FieldNode field,
    Map<String, dynamic> variables,
  ) => <String, Object?>{
    for (final ArgumentNode argument in field.arguments)
      argument.name.value: _value(argument.value, variables),
  };

  Object? _value(ValueNode node, Map<String, dynamic> variables) =>
      switch (node) {
        VariableNode(:final NameNode name) => variables[name.value],
        IntValueNode(:final String value) => int.parse(value),
        FloatValueNode(:final String value) => double.parse(value),
        StringValueNode(:final String value) => value,
        BooleanValueNode(:final bool value) => value,
        EnumValueNode(:final NameNode name) => name.value,
        NullValueNode() => null,
        ListValueNode(:final List<ValueNode> values) => <Object?>[
          for (final ValueNode value in values) _value(value, variables),
        ],
        ObjectValueNode(:final List<ObjectFieldNode> fields) =>
          <String, Object?>{
            for (final ObjectFieldNode field in fields)
              field.name.value: _value(field.value, variables),
          },
        _ => throw const ServerException(
          ErrorCodes.validationFailed,
          'Unsupported argument value.',
        ),
      };

  String _rootTypeName(OperationType type) => switch (type) {
    OperationType.query => 'Query',
    OperationType.mutation => 'Mutation',
    OperationType.subscription => 'Subscription',
  };

  Response _errorResponse(String code, String message) => Response(
    errors: <GraphQLError>[
      GraphQLError(
        message: message,
        extensions: <String, dynamic>{'code': code},
      ),
    ],
    response: const <String, dynamic>{},
  );
}
