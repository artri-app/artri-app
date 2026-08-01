import 'package:artriapp/utils/enums/days_of_week.dart';

class ReminderScheduler {
  DateTime calculateNextSchedule({
    required int hourInt,
    required int minuteInt,
    required List<DaysOfWeek> daysOfWeek,
    DateTime? now,
  }) {
    final current = now ?? DateTime.now();
    final todayScheduled = DateTime(current.year, current.month, current.day, hourInt, minuteInt);
    final todayDayIndex = current.weekday - 1;

    if (daysOfWeek.isEmpty) {
      if (todayScheduled.isAfter(current)) return todayScheduled;
      return todayScheduled.add(const Duration(days: 1));
    }

    final dayIndices = daysOfWeek.map((d) => d.index).toSet();

    if (dayIndices.contains(todayDayIndex) && todayScheduled.isAfter(current)) {
      return todayScheduled;
    }

    for (int offset = 1; offset <= 7; offset++) {
      final nextDayIndex = (todayDayIndex + offset) % 7;
      if (dayIndices.contains(nextDayIndex)) {
        return DateTime(current.year, current.month, current.day + offset, hourInt, minuteInt);
      }
    }

    return todayScheduled.add(const Duration(days: 1));
  }
}
