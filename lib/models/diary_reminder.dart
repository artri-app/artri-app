import 'dart:convert';

class DiaryReminder {
  String? message;
  DateTime? date;

  DiaryReminder({
    this.message,
    this.date,
  });

  String getMonthName() {
    switch(date?.month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
      default:
        return 'Janeiro';
    }
  }

  static Map<String, dynamic> toMap(DiaryReminder reminder) => {
    'message': reminder.message,
    'date': reminder.date.toString(),
  };

  static String encode(List<DiaryReminder> reminders) => json.encode(
    reminders.map<Map<String, dynamic>>(
      (reminder) => DiaryReminder.toMap(reminder),
    ).toList(),
  );

  static List<DiaryReminder> decode(String value) => 
    (json.decode(value) as List<dynamic>).map<DiaryReminder>((item) => DiaryReminder.fromJson(item)).toList();

  static DiaryReminder fromJson(Map<String, dynamic> map) {
    DateTime date = DateTime.parse(map['date']);
    return DiaryReminder(message: map['message'], date: date);
  }
}