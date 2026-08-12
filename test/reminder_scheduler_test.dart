import 'package:artriapp/utils/enums/days_of_week.dart';
import 'package:artriapp/utils/reminder_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final scheduler = ReminderScheduler();

  group('ReminderScheduler.calculateNextSchedule', () {
    test('agenda para hoje quando horário ainda não passou (sem dias específicos)', () {
      final now = DateTime(2025, 3, 10, 7, 0); // Segunda, 07:00
      final result = scheduler.calculateNextSchedule(
        hourInt: 8,
        minuteInt: 0,
        daysOfWeek: [],
        now: now,
      );
      expect(result, DateTime(2025, 3, 10, 8, 0));
    });

    test('agenda para amanhã quando horário já passou (sem dias específicos)', () {
      final now = DateTime(2025, 3, 10, 21, 0); // Segunda, 21:00
      final result = scheduler.calculateNextSchedule(
        hourInt: 20,
        minuteInt: 0,
        daysOfWeek: [],
        now: now,
      );
      expect(result, DateTime(2025, 3, 11, 20, 0));
    });

    test('agenda para hoje quando é dia válido e horário não passou', () {
      final now = DateTime(2025, 3, 10, 7, 0); // Segunda, 07:00
      final result = scheduler.calculateNextSchedule(
        hourInt: 8,
        minuteInt: 0,
        daysOfWeek: [DaysOfWeek.monday, DaysOfWeek.wednesday, DaysOfWeek.friday],
        now: now,
      );
      expect(result, DateTime(2025, 3, 10, 8, 0));
    });

    test('agenda para próximo dia válido quando hoje não está na lista', () {
      final now = DateTime(2025, 3, 11, 7, 0); // Terça, 07:00
      final result = scheduler.calculateNextSchedule(
        hourInt: 8,
        minuteInt: 0,
        daysOfWeek: [DaysOfWeek.monday, DaysOfWeek.wednesday, DaysOfWeek.friday],
        now: now,
      );
      expect(result, DateTime(2025, 3, 12, 8, 0)); // Quarta
    });

    test('agenda para próxima segunda quando é sábado e o remédio é só segunda', () {
      final now = DateTime(2025, 3, 8, 10, 0); // Sábado
      final result = scheduler.calculateNextSchedule(
        hourInt: 8,
        minuteInt: 0,
        daysOfWeek: [DaysOfWeek.monday],
        now: now,
      );
      expect(result, DateTime(2025, 3, 10, 8, 0)); // Segunda
    });

    test('agenda para amanhã quando horário de hoje já passou mesmo em dia válido', () {
      final now = DateTime(2025, 3, 10, 21, 0); // Segunda, 21:00
      final result = scheduler.calculateNextSchedule(
        hourInt: 8,
        minuteInt: 0,
        daysOfWeek: [DaysOfWeek.monday, DaysOfWeek.tuesday],
        now: now,
      );
      expect(result, DateTime(2025, 3, 11, 8, 0)); // Terça
    });

    test('funciona com virada de mês', () {
      final now = DateTime(2025, 12, 31, 21, 0); // Quarta, 21:00
      final result = scheduler.calculateNextSchedule(
        hourInt: 8,
        minuteInt: 0,
        daysOfWeek: [DaysOfWeek.monday, DaysOfWeek.thursday],
        now: now,
      );
      expect(result, DateTime(2026, 1, 1, 8, 0)); // Quinta (próximo ano)
    });

    test('trata dias da semana corretamente na virada de semana', () {
      final now = DateTime(2025, 3, 9, 10, 0); // Domingo
      final result = scheduler.calculateNextSchedule(
        hourInt: 8,
        minuteInt: 0,
        daysOfWeek: [DaysOfWeek.monday],
        now: now,
      );
      expect(result, DateTime(2025, 3, 10, 8, 0)); // Segunda
    });

    test('retorna mesmo horário no dia seguinte quando daysOfWeek é vazio e horário passou', () {
      final now = DateTime(2025, 3, 10, 23, 0);
      final result = scheduler.calculateNextSchedule(
        hourInt: 8,
        minuteInt: 30,
        daysOfWeek: [],
        now: now,
      );
      expect(result, DateTime(2025, 3, 11, 8, 30));
    });
  });
}
