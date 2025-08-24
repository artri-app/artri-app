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
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'days_of_week': daysOfWeek.map((day) => day.index).toList(),
      'hour': hour,
      'user': user,
    };
  }

  factory Remedy.fromMap(Map<String, dynamic> map) {
    return Remedy(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      quantity: map['quantity'],
      daysOfWeek: List<DaysOfWeek>.from(
        (map['days_of_week'] as List).map((day) => DaysOfWeek.values[day]),
      ),
      hour: map['hour'],
      user: map['user'],
    );
  }
}
