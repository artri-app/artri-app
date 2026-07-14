import 'package:artriapp/utils/enums/days_of_week.dart';

// O backend (Django) guarda os dias como um array de strings em inglês
// (ex: ['Monday', 'Wednesday']) num Postgres ArrayField.
const Map<DaysOfWeek, String> daysOfWeekBackendValues = {
  DaysOfWeek.monday: 'Monday',
  DaysOfWeek.tuesday: 'Tuesday',
  DaysOfWeek.wednesday: 'Wednesday',
  DaysOfWeek.thursday: 'Thursday',
  DaysOfWeek.friday: 'Friday',
  DaysOfWeek.saturday: 'Saturday',
  DaysOfWeek.sunday: 'Sunday',
};

class Remedy {
  final int id;
  final String name;
  final String description;
  final String quantity;
  final List<DaysOfWeek> daysOfWeek;
  final String hour;
  final int user;
  final bool reminderEnabled;

  Remedy({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.daysOfWeek,
    required this.hour,
    required this.user,
    required this.reminderEnabled,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'days_of_week':
          daysOfWeek.map((day) => daysOfWeekBackendValues[day]).toList(),
      'hour': hour,
      'user': user,
      'reminder_enabled': reminderEnabled,
    };
  }

  factory Remedy.fromMap(Map<String, dynamic> map) {
    return Remedy(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      quantity: map['quantity'],
      daysOfWeek: List<DaysOfWeek>.from(
        (map['days_of_week'] as List).map(
          (value) => daysOfWeekBackendValues.entries
              .firstWhere((entry) => entry.value == value)
              .key,
        ),
      ),
      hour: map['hour'],
      user: map['user'],
      reminderEnabled: map['reminder_enabled'] ?? true,
    );
  }
}
