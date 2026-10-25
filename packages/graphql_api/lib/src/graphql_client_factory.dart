import 'package:ferry/ferry.dart';

import '../schema/__generated__/schema.schema.gql.dart' show possibleTypesMap;

/// Builds the ferry client the app talks to. The [link] decides where
/// operations go: the in-app server today, a real endpoint later.
Client createGraphQLClient({required Link link}) {
  return Client(
    link: link,
    cache: Cache(possibleTypes: possibleTypesMap),
    // Queries answer from the cache and still ask the server, so a cached
    // order is never the last word. Subscription results land in the same
    // cache, which re-emits any query watching that order.
    defaultFetchPolicies: const {
      OperationType.query: FetchPolicy.CacheAndNetwork,
    },
  );
}
