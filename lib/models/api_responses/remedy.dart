import 'package:artriapp/utils/enums/days_of_week.dart';

class Remedy {
  final int id;
  final String name;
  final String description;
  final int quantity;
  final List<DaysOfWeek> daysOfWeek;
  final String hour;
  final int user;

  Remedy({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.daysOfWeek,
    required this.hour,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'days_of_week': daysOfWeek.map((day) => day.apiValue).toList(),
      'hour': hour,
    };
  }

  factory Remedy.fromMap(Map<String, dynamic> map) {
    return Remedy(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      quantity: map['quantity'],
      daysOfWeek: _parseDaysOfWeek(map['days_of_week']),
      hour: map['hour'],
      user: map['user'],
    );
  }

  static List<DaysOfWeek> _parseDaysOfWeek(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((e) => DaysOfWeek.fromApiValue(e.toString())).toList();
    }
    if (value is String) {
      if (value.contains(',')) {
        return value.split(',').map((s) => DaysOfWeek.fromApiValue(s.trim())).toList();
      }
      return [DaysOfWeek.fromApiValue(value)];
    }
    return [];
  }
}
