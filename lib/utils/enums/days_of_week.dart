enum DaysOfWeek {
  monday('Monday'),
  tuesday('Tuesday'),
  wednesday('Wednesday'),
  thursday('Thursday'),
  friday('Friday'),
  saturday('Saturday'),
  sunday('Sunday');

  final String apiValue;
  const DaysOfWeek(this.apiValue);

  static DaysOfWeek fromApiValue(String value) {
    return DaysOfWeek.values.firstWhere(
      (d) => d.apiValue == value,
      orElse: () => DaysOfWeek.monday,
    );
  }
}
