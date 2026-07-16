import 'package:artriapp/models/api_responses/remedy.dart';
import 'package:artriapp/utils/enums/days_of_week.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'remedy_reminders';
  static const _channelName = 'Lembretes de medicamentos';

  Future<void> init() async {
    tz.initializeTimeZones();
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    } catch (e) {
      debugPrint('Erro ao configurar timezone, usando padrão: $e');
    }

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );

    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();
    await androidPlugin?.requestExactAlarmsPermission();
  }

  int _notificationId(int remedyId, DaysOfWeek day) {
    return remedyId * 10 + day.index;
  }

  Future<void> cancelReminderForDay(int remedyId, DaysOfWeek day) async {
    await _plugin.cancel(id: _notificationId(remedyId, day));
  }

  tz.TZDateTime _nextInstanceOfDayTime(DaysOfWeek day, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    // DaysOfWeek.monday.index == 0, DateTime.weekday Monday == 1.
    final targetWeekday = day.index + 1;
    while (scheduled.weekday != targetWeekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }

  Future<void> scheduleRemedyReminders(Remedy remedy) async {
    await cancelRemedyReminders(remedy.id);

    if (!remedy.reminderEnabled) return;

    final parts = remedy.hour.split(':');
    if (parts.length < 2) return;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return;

    for (final day in remedy.daysOfWeek) {
      await _plugin.zonedSchedule(
        id: _notificationId(remedy.id, day),
        title: 'Hora do remédio',
        body:
            '${remedy.name}${remedy.quantity.isNotEmpty ? ' • ${remedy.quantity}' : ''}',
        scheduledDate: _nextInstanceOfDayTime(day, hour, minute),
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: 'Lembretes de horário dos medicamentos',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  Future<void> cancelRemedyReminders(int remedyId) async {
    for (final day in DaysOfWeek.values) {
      await _plugin.cancel(id: _notificationId(remedyId, day));
    }
  }
}
