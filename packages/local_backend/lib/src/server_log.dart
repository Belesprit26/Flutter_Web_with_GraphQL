/// Receives the server's structured events: a dotted event name plus fields,
/// e.g. `server.order.replayed` with the order id and idempotency key. The app
/// plugs its own logger in; by default events are dropped.
typedef ServerLog = void Function(String event, Map<String, Object?> fields);

void ignoreServerEvents(String event, Map<String, Object?> fields) {}
