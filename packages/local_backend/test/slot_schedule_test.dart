import 'package:local_backend/src/slot_schedule.dart';
import 'package:test/test.dart';

import 'support/server_fixtures.dart';

void main() {
  test('windows start tomorrow in Johannesburg, four a day, stored in UTC', () {
    final SlotSchedule schedule = SlotSchedule(clock: FakeClock());

    final List<SlotWindow> windows = schedule.upcoming(2);

    expect(windows, hasLength(8));
    expect(windows.first.id, 'slot-20261025-0800');
    // 08:00 SAST is 06:00 UTC.
    expect(windows.first.startsAt, DateTime.utc(2026, 10, 25, 6));
    expect(windows.first.endsAt, DateTime.utc(2026, 10, 25, 8));
    expect(windows.last.id, 'slot-20261026-1400');
  });

  test('"tomorrow" follows the Johannesburg date, not the UTC one', () {
    // 23:30 UTC on the 24th is already 01:30 on the 25th in Johannesburg.
    final SlotSchedule lateUtc = SlotSchedule(
      clock: FakeClock(DateTime.utc(2026, 10, 24, 23, 30)),
    );
    expect(lateUtc.upcoming(1).first.id, 'slot-20261026-0800');

    // 21:30 UTC on the 24th is 23:30 on the 24th in Johannesburg.
    final SlotSchedule lateSast = SlotSchedule(
      clock: FakeClock(DateTime.utc(2026, 10, 24, 21, 30)),
    );
    expect(lateSast.upcoming(1).first.id, 'slot-20261025-0800');
  });

  test('an id parses back to the same window', () {
    final SlotSchedule schedule = SlotSchedule(clock: FakeClock());
    for (final SlotWindow window in schedule.upcoming(7)) {
      final SlotWindow parsed = schedule.parse(window.id)!;
      expect(parsed.startsAt, window.startsAt);
      expect(parsed.endsAt, window.endsAt);
    }
  });

  test('ids that are not real windows do not parse', () {
    final SlotSchedule schedule = SlotSchedule(clock: FakeClock());
    for (final String id in <String>[
      'slot-20261025-0900', // not a start hour
      'slot-20260231-0800', // 31 February
      'slot-2026102-0800',
      'slot-20261025-0830',
      'nonsense',
    ]) {
      expect(schedule.parse(id), isNull, reason: id);
    }
  });

  test('seeded closures are stable and leave most of the week open', () {
    final List<SlotWindow> week = SlotSchedule(clock: FakeClock()).upcoming(7);
    final int closed = week
        .where((SlotWindow window) => SlotSchedule.closedBySeed(window.id))
        .length;

    expect(closed, greaterThan(0));
    expect(closed, lessThan(week.length ~/ 2));
    expect(
      week.map((SlotWindow window) => SlotSchedule.closedBySeed(window.id)),
      week.map((SlotWindow window) => SlotSchedule.closedBySeed(window.id)),
    );
  });
}
