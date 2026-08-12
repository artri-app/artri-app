import 'package:artriapp/models/api_responses/remedy.dart';
import 'package:artriapp/routes/not_logged.routes.dart';
import 'package:artriapp/services/notification_service.dart';
import 'package:artriapp/services/remedy_service.dart';
import 'package:artriapp/utils/enums/days_of_week.dart';
import 'package:artriapp/utils/exceptions.dart';
import 'package:artriapp/utils/router_keys.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class RemedyViewModel extends ChangeNotifier {
  final NotificationService _notificationService;
  final RemedyService _remedyService;

  RemedyViewModel({
    required NotificationService notificationService,
    required RemedyService remedyService,
  })  : _notificationService = notificationService,
        _remedyService = remedyService;

  List<Remedy> _allRemedies = [];
  List<Remedy> get remedies => _allRemedies;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final Map<int, bool> _checklistStatus = {};

  bool isTaken(int id) => _checklistStatus[id] ?? false;

  void toggleTaken(int id) {
    _checklistStatus[id] = !isTaken(id);
    notifyListeners();
  }

  Future<void> fetchRemedies() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allRemedies = await _remedyService.getRemedies();
      await _scheduleAllRemedies();
    } catch (e) {
      if (e is AuthExpiredException) {
        debugPrint('[RemedyViewModel] Auth expired, redirecting to login');
        RouterKeys.appRoutesKey.currentContext?.go(NotLoggedRoutes.login);
        return;
      }
      debugPrint('Erro ao buscar medicamentos: $e');
      _errorMessage = 'Erro ao carregar medicamentos. Verifique sua conexão.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveRemedy({
    required String name,
    required String description,
    required int quantity,
    required String hour,
    required List<DaysOfWeek> daysOfWeek,
  }) async {
    _errorMessage = null;

    try {
      final createdRemedies = <Remedy>[];
      for (final day in daysOfWeek) {
        final remedy = await _remedyService.createRemedy(
          name: name,
          description: description,
          quantity: quantity,
          hour: hour,
          dayOfWeek: day,
        );
        createdRemedies.add(remedy);
      }
      _allRemedies.addAll(createdRemedies);
      for (final remedy in createdRemedies) {
        await _notificationService.scheduleRemedyReminder(
          remedyId: remedy.id,
          remedyName: remedy.name,
          hour: remedy.hour,
          daysOfWeek: remedy.daysOfWeek,
        );
      }
      notifyListeners();
    } catch (e) {
      if (e is AuthExpiredException) {
        RouterKeys.appRoutesKey.currentContext?.go(NotLoggedRoutes.login);
        return;
      }
      debugPrint('Erro ao salvar medicamento: $e');
      _errorMessage = 'Erro ao salvar medicamento. Tente novamente.';
      notifyListeners();
    }
  }

  Future<void> deleteRemedy(int id) async {
    _errorMessage = null;

    try {
      await _remedyService.deleteRemedy(id);
      _allRemedies.removeWhere((r) => r.id == id);
      await _notificationService.cancelReminder(id);
      notifyListeners();
    } catch (e) {
      if (e is AuthExpiredException) {
        RouterKeys.appRoutesKey.currentContext?.go(NotLoggedRoutes.login);
        return;
      }
      debugPrint('Erro ao deletar medicamento: $e');
      _errorMessage = 'Erro ao deletar medicamento. Tente novamente.';
      notifyListeners();
    }
  }

  Future<void> _scheduleAllRemedies() async {
    for (final remedy in _allRemedies) {
      await _notificationService.scheduleRemedyReminder(
        remedyId: remedy.id,
        remedyName: remedy.name,
        hour: remedy.hour,
        daysOfWeek: remedy.daysOfWeek,
      );
    }
  }
}