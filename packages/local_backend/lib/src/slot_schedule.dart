import 'clock.dart';

/// A two-hour arrival window.
class SlotWindow {
  const SlotWindow({
    required this.id,
    required this.startsAt,
    required this.endsAt,
  });

  final String id;
  final DateTime startsAt;
  final DateTime endsAt;

  Map<String, Object?> toResponse({required bool available}) =>
      <String, Object?>{
        '__typename': 'Slot',
        'id': id,
        'startsAt': startsAt.toIso8601String(),
        'endsAt': endsAt.toIso8601String(),
        'available': available,
      };
}

/// The bookable arrival windows. Times follow Johannesburg business hours
/// (UTC+2 all year, no daylight saving) and are stored in UTC. Ids are
/// deterministic - slot-20261026-0800 is always 08:00 SAST on 26 October - so
/// a slot id in a URL means the same window on every load.
class SlotSchedule {
  const SlotSchedule({required this.clock});

  final Clock clock;

  static const int maxDays = 14;
  static const Duration sastOffset = Duration(hours: 2);
  static const List<int> startHours = <int>[8, 10, 12, 14];
  static const Duration window = Duration(hours: 2);

  static final RegExp _idPattern = RegExp(
    r'^slot-(\d{4})(\d{2})(\d{2})-(\d{2})00$',
  );

  /// Windows from tomorrow (Johannesburg date) for [days] days. Whether each
  /// one can still be booked is the server's call.
  List<SlotWindow> upcoming(int days) {
    final DateTime todayInSast = clock.now().add(sastOffset);
    return <SlotWindow>[
      for (int offset = 1; offset <= days; offset++)
        for (final int hour in startHours)
          _window(
            DateTime.utc(
              todayInSast.year,
              todayInSast.month,
              todayInSast.day + offset,
            ),
            hour,
          ),
    ];
  }

  /// The window an id refers to, or null if it isn't a valid slot id.
  SlotWindow? parse(String slotId) {
    final RegExpMatch? match = _idPattern.firstMatch(slotId);
    if (match == null) {
      return null;
    }
    final int year = int.parse(match.group(1)!);
    final int month = int.parse(match.group(2)!);
    final int day = int.parse(match.group(3)!);
    final int hour = int.parse(match.group(4)!);
    final DateTime date = DateTime.utc(year, month, day);
    // DateTime rolls 31 February over into March; a real date round-trips.
    if (date.year != year || date.month != month || date.day != day) {
      return null;
    }
    if (!startHours.contains(hour)) {
      return null;
    }
    return _window(date, hour);
  }

  /// Seeded closures: about 1 window in 5 is unavailable, decided by the id
  /// alone so every load agrees. String.hashCode differs between the web and
  /// the VM, so this uses its own hash.
  static bool closedBySeed(String slotId) {
    final int hash = slotId.codeUnits.fold(
      0,
      (int hash, int unit) => (hash * 31 + unit) & 0x7fffffff,
    );
    return hash % 5 == 0;
  }

  SlotWindow _window(DateTime sastDate, int hour) {
    final DateTime startsAt = DateTime.utc(
      sastDate.year,
      sastDate.month,
      sastDate.day,
      hour,
    ).subtract(sastOffset);
    final String date =
        '${sastDate.year.toString().padLeft(4, '0')}'
        '${sastDate.month.toString().padLeft(2, '0')}'
        '${sastDate.day.toString().padLeft(2, '0')}';
    return SlotWindow(
      id: 'slot-$date-${hour.toString().padLeft(2, '0')}00',
      startsAt: startsAt,
      endsAt: startsAt.add(window),
    );
  }
}
