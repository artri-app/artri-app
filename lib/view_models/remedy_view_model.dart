import 'package:flutter/material.dart';
import 'package:artriapp/models/api_responses/remedy.dart';
import 'package:artriapp/models/api_responses/remedy_intake.dart';
import 'package:artriapp/services/notification_service.dart';
import 'package:artriapp/services/remedy_service.dart';
import 'package:artriapp/utils/enums/days_of_week.dart';

class RemedyViewModel extends ChangeNotifier {
  final RemedyService _remedyService;
  final NotificationService _notificationService;

  RemedyViewModel(this._remedyService, this._notificationService);

  List<Remedy> _allRemedies = [];
  List<Remedy> get remedies => _allRemedies;

  List<RemedyIntake> _todayIntakes = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DaysOfWeek get _today => DaysOfWeek.values[DateTime.now().weekday - 1];

  bool isScheduledToday(Remedy remedy) =>
      remedy.daysOfWeek.contains(_today);

  bool isTaken(int remedyId) =>
      _todayIntakes.any((intake) => intake.remedyId == remedyId);

  Future<void> toggleTaken(int remedyId) async {
    final existing = _todayIntakes.where(
      (intake) => intake.remedyId == remedyId,
    );

    try {
      if (existing.isNotEmpty) {
        await _remedyService.deleteIntake(existing.first.id);
        _todayIntakes = _todayIntakes
            .where((intake) => intake.remedyId != remedyId)
            .toList();
      } else {
        final created = await _remedyService.createIntake(
          remedyId,
          DateTime.now(),
        );
        _todayIntakes = [..._todayIntakes, created];
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao atualizar registro de uso: $e');
    }
  }

  Future<void> fetchTodayIntakes() async {
    try {
      _todayIntakes = await _remedyService.getIntakes(DateTime.now());
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao buscar registros de uso: $e');
    }
  }

  Future<void> addRemedy({
    required String name,
    required String quantity,
    required String hour,
    required Set<DaysOfWeek> daysOfWeek,
    required bool reminderEnabled,
  }) async {
    try {
      final created = await _remedyService.addRemedy(
        Remedy(
          id: 0,
          name: name,
          description: '',
          quantity: quantity,
          hour: hour,
          daysOfWeek: daysOfWeek.toList(),
          reminderEnabled: reminderEnabled,
        ),
      );

      _allRemedies = [..._allRemedies, created];
      notifyListeners();

      await _notificationService.scheduleRemedyReminders(created);
    } catch (e) {
      debugPrint('Erro ao adicionar medicamento: $e');
    }
  }

  Future<void> updateRemedy({
    required int id,
    required String name,
    required String quantity,
    required String hour,
    required Set<DaysOfWeek> daysOfWeek,
    required bool reminderEnabled,
  }) async {
    try {
      final updated = await _remedyService.updateRemedy(
        Remedy(
          id: id,
          name: name,
          description: '',
          quantity: quantity,
          hour: hour,
          daysOfWeek: daysOfWeek.toList(),
          reminderEnabled: reminderEnabled,
        ),
      );

      _allRemedies = [
        for (final remedy in _allRemedies)
          if (remedy.id == id) updated else remedy,
      ];
      notifyListeners();

      await _notificationService.scheduleRemedyReminders(updated);
    } catch (e) {
      debugPrint('Erro ao atualizar medicamento: $e');
    }
  }

  Future<void> deleteRemedy(int id) async {
    try {
      await _remedyService.deleteRemedy(id);
      _allRemedies = _allRemedies.where((remedy) => remedy.id != id).toList();
      notifyListeners();

      await _notificationService.cancelRemedyReminders(id);
    } catch (e) {
      debugPrint('Erro ao remover medicamento: $e');
    }
  }

  Future<void> fetchRemedies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allRemedies = await _remedyService.getRemedies();
    } catch (e) {
      debugPrint('Erro ao buscar medicamentos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
