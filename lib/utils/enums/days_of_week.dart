enum DaysOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

extension DaysOfWeekLabel on DaysOfWeek {
  String get shortLabel {
    switch (this) {
      case DaysOfWeek.monday:
        return 'Seg';
      case DaysOfWeek.tuesday:
        return 'Ter';
      case DaysOfWeek.wednesday:
        return 'Qua';
      case DaysOfWeek.thursday:
        return 'Qui';
      case DaysOfWeek.friday:
        return 'Sex';
      case DaysOfWeek.saturday:
        return 'Sáb';
      case DaysOfWeek.sunday:
        return 'Dom';
    }
  }
}
