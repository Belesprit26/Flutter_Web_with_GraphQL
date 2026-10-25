import '../local_server.dart';
import '../server_exception.dart';

/// What a resolver gets: the server, the caller and the field's arguments.
class ResolverContext {
  const ResolverContext({
    required this.server,
    required this.userId,
    required this.arguments,
  });

  final LocalServer server;
  final String? userId;
  final Map<String, Object?> arguments;

  /// The caller's user id, or UNAUTHENTICATED when nobody is signed in.
  String requireUser() {
    final String? id = userId;
    if (id == null) {
      throw const ServerException(
        ErrorCodes.unauthenticated,
        'Sign in to continue.',
      );
    }
    return id;
  }
}

/// Resolves a query or mutation root field to its GraphQL shape.
typedef FieldResolver = Future<Object?> Function(ResolverContext context);

/// Resolves a subscription root field to a stream of GraphQL shapes.
typedef SubscriptionResolver =
    Stream<Object?> Function(ResolverContext context);
