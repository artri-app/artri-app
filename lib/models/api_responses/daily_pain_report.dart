class DailyPainReport {
  DailyPainReport({
    required this.id,
    required this.date,
    required this.painLevel,
    required this.painLocation,
    required this.userId,
  });

  final String id;
  final DateTime date;
  final int painLevel; // Scale from 0 to 10
  final String painLocation; // List of symptoms experienced
  final int userId; // e.g., "Happy", "Sad", "Anxious"

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'pain_level': painLevel,
      'pain_location': painLocation,
      'user': userId,
    };
  }

  factory DailyPainReport.fromMap(Map<String, dynamic> map) {
    return DailyPainReport(
      id: map['id'],
      date: DateTime.parse(map['date']),
      painLevel: map['pain_level'],
      painLocation: map['symptoms'],
      userId: map['user'],
    );
  }
}
