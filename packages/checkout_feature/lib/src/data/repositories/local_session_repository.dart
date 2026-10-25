import 'dart:convert';

import '../../core/app_logger.dart';
import '../../domain/entities/session.dart';
import '../../domain/repositories/repositories.dart';

/// Keeps the simulated session in device storage, so a refresh stays signed in.
class LocalSessionRepository implements SessionRepository {
  const LocalSessionRepository({
    required LocalStore store,
    required AppLogger logger,
  }) : _store = store,
       _logger = logger;

  final LocalStore _store;
  final AppLogger _logger;

  static const String key = 'session.v1';

  @override
  Future<Session?> restore() async {
    final String? raw = await _store.read(key);
    if (raw == null) {
      return null;
    }
    try {
      if (jsonDecode(raw) case {
        'userId': final String userId,
        'displayName': final String displayName,
      }) {
        return Session(userId: userId, displayName: displayName);
      }
    } on FormatException {
      // Falls through to the log below.
    }
    _logger.log('session.unreadable');
    return null;
  }

  @override
  Future<void> save(Session session) => _store.write(
    key,
    jsonEncode(<String, Object?>{
      'userId': session.userId,
      'displayName': session.displayName,
    }),
  );

  @override
  Future<void> clear() => _store.remove(key);
}
