import 'package:flutter/foundation.dart';

import '../../domain/entities/session.dart';
import '../../domain/repositories/repositories.dart';

/// Who is signed in, for the whole app. The router listens to it, so signing
/// in or out re-runs the redirects straight away.
class SessionController extends ChangeNotifier {
  SessionController({required SessionRepository repository, Session? initial})
    : _repository = repository,
      _session = initial;

  final SessionRepository _repository;
  Session? _session;

  Session? get session => _session;

  bool get signedIn => _session != null;

  /// What the in-app server reads as the caller - the stand-in for an auth
  /// header.
  String? get userId => _session?.userId;

  Future<void> signIn(Session session) async {
    await _repository.save(session);
    _session = session;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _repository.clear();
    _session = null;
    notifyListeners();
  }
}
