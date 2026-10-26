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

  Map<String, Object?> toResponse() => <String, Object?>{
    '__typename': 'Slot',
    'id': id,
    'startsAt': startsAt.toIso8601String(),
    'endsAt': endsAt.toIso8601String(),
    'available': true,
  };
}

/// The bookable windows: 3 a day for the next 7 days, from tomorrow, in
/// Johannesburg time (UTC+2 all year) and stored as UTC. Ids are built from
/// the date and hour - slot-20261026-0800 is 08:00 SAST on 26 October - so a
/// slot in a URL means the same window on every load.
class SlotSchedule {
  const SlotSchedule({required this.clock});

  final Clock clock;

  static const int maxDays = 7;
  static const List<int> startHours = <int>[8, 11, 14];
  static const Duration _sastOffset = Duration(hours: 2);
  static const Duration _length = Duration(hours: 2);

  List<SlotWindow> upcoming([int days = maxDays]) {
    final DateTime today = clock.now().add(_sastOffset);
    return <SlotWindow>[
      for (int offset = 1; offset <= days; offset++)
        for (final int hour in startHours)
          _slot(
            DateTime.utc(today.year, today.month, today.day + offset),
            hour,
          ),
    ];
  }

  /// The window [slotId] refers to, if it's one of the next 7 days' slots.
  SlotWindow? find(String slotId) {
    for (final SlotWindow slot in upcoming()) {
      if (slot.id == slotId) {
        return slot;
      }
    }
    return null;
  }

  SlotWindow _slot(DateTime sastDate, int hour) {
    final DateTime startsAt = DateTime.utc(
      sastDate.year,
      sastDate.month,
      sastDate.day,
      hour,
    ).subtract(_sastOffset);
    final String date =
        '${sastDate.year}'
        '${sastDate.month.toString().padLeft(2, '0')}'
        '${sastDate.day.toString().padLeft(2, '0')}';
    return SlotWindow(
      id: 'slot-$date-${hour.toString().padLeft(2, '0')}00',
      startsAt: startsAt,
      endsAt: startsAt.add(_length),
    );
  }
}
