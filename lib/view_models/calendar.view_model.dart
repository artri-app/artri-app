import 'package:artriapp/models/diary_reminder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CalendarViewModel extends ChangeNotifier {
  String _newReminderMessage = '';
  String get newReminderMessage => _newReminderMessage;
  DateTime _newReminderDateTime = DateTime.now();
  DateTime get newReminderDateTime => _newReminderDateTime;
  List<DiaryReminder> _calendarReminders = [];

  List<DiaryReminder> get calendarReminders => _calendarReminders;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;


  // Metodos para gestao do calendario:
  void addReminder() {
    DiaryReminder newReminder = DiaryReminder(
      message: _newReminderMessage,
      date: _newReminderDateTime,
    );
    _calendarReminders.add(newReminder);

    _calendarReminders.sort((a, b) => a.date?.compareTo(b.date ?? DateTime.now()) ?? 0);
    saveReminderListLocally();

    resetNewReminder();
  }

  void saveReminderListLocally() async {
    String listToString = DiaryReminder.encode(_calendarReminders);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('lembretes', listToString);
  }

  void getLocallySavedReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String listToString = prefs.getString('lembretes') ?? '';

    final List<DiaryReminder> remindersFromLocalStorage = DiaryReminder.decode(listToString);
    for (final element in remindersFromLocalStorage) {
      // if ((element.date ?? DateTime.now()).subtract(DateTime.now()) > 0) {
      // if ((element.date ?? DateTime.now()).compareTo(DateTime.now()) == 0) {
      DateTime now = DateTime.now();
      DateTime currentDate = DateTime(DateTime.now().year, now.month, now.day);
      if ((element.date?.millisecondsSinceEpoch ?? 0) < currentDate.millisecondsSinceEpoch) {
        remindersFromLocalStorage.remove(element);
      }
    }

    _calendarReminders = remindersFromLocalStorage;
    notifyListeners();
  }

  void resetNewReminder() {
    _newReminderMessage = '';
    _newReminderDateTime = DateTime.now();

    notifyListeners();
  }

  void setNewDate(DateTime time) {
    _newReminderDateTime = time;

    notifyListeners();
  }

  void setRemiderMessageValue(String value) {
    _newReminderMessage = value;

    notifyListeners();
  }
}