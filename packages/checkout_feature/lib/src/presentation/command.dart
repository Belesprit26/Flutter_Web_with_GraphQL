import 'package:flutter/foundation.dart';

import '../core/result.dart';

/// An action a view can trigger, with its running state and last result for
/// the view to render. While it's running, another execute is dropped - layer
/// 1 of the duplicate protection, which every action in the app gets for free.
abstract class Command<T> extends ChangeNotifier {
  Command({this.onDuplicate});

  /// Called when an execute is dropped because one is already running.
  final VoidCallback? onDuplicate;

  bool _running = false;
  Result<T>? _result;

  bool get running => _running;

  Result<T>? get result => _result;

  bool get completed => _result is Ok<T>;

  bool get failed => _result is Err<T>;

  void clearResult() {
    _result = null;
    notifyListeners();
  }

  Future<void> _run(Future<Result<T>> Function() action) async {
    if (_running) {
      onDuplicate?.call();
      return;
    }
    _running = true;
    _result = null;
    notifyListeners();
    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

class Command0<T> extends Command<T> {
  Command0(this._action, {super.onDuplicate});

  final Future<Result<T>> Function() _action;

  Future<void> execute() => _run(_action);
}

class Command1<T, A> extends Command<T> {
  Command1(this._action, {super.onDuplicate});

  final Future<Result<T>> Function(A argument) _action;

  Future<void> execute(A argument) => _run(() => _action(argument));
}
