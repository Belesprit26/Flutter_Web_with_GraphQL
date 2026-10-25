import 'dart:async';

import 'package:checkout_feature/checkout_feature.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an execute while one is running is dropped, not queued', () async {
    int calls = 0;
    int duplicates = 0;
    final Completer<Result<int>> answer = Completer<Result<int>>();
    final Command0<int> command = Command0<int>(() {
      calls++;
      return answer.future;
    }, onDuplicate: () => duplicates++);

    final Future<void> first = command.execute();
    final Future<void> second = command.execute();
    final Future<void> third = command.execute();
    expect(command.running, isTrue);

    answer.complete(const Ok<int>(1));
    await Future.wait(<Future<void>>[first, second, third]);

    expect(calls, 1);
    expect(duplicates, 2);
    expect(command.running, isFalse);
    expect(command.completed, isTrue);
  });

  test('it runs again once the first run has finished', () async {
    int calls = 0;
    final Command1<int, int> command = Command1<int, int>((int value) async {
      calls++;
      return Ok<int>(value);
    });

    await command.execute(1);
    await command.execute(2);

    expect(calls, 2);
    expect((command.result! as Ok<int>).value, 2);
  });

  test('a failure is kept for the view and can be cleared', () async {
    final Command0<int> command = Command0<int>(
      () async => const Err<int>(NetworkFailure(developerMessage: 'offline')),
    );
    int notifications = 0;
    command.addListener(() => notifications++);

    await command.execute();
    expect(command.failed, isTrue);
    command.clearResult();

    expect(command.result, isNull);
    expect(notifications, 3); // started, finished, cleared
  });
}
