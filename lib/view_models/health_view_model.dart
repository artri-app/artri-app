import 'package:flutter/foundation.dart';

import 'package:artriapp/models/health_metric_type.dart';
import 'package:artriapp/models/local_health_metrics.dart';
import 'package:artriapp/services/health_sync_service.dart';

class HealthViewModel extends ChangeNotifier {
  final HealthSyncService _syncService;

  HealthViewModel({required HealthSyncService syncService})
      : _syncService = syncService;

  bool _isLoading = false;
  bool _isConnected = false;
  bool _isAvailable = false;
  bool _installNeeded = false;
  String? _errorMessage;

  Map<HealthMetricType, List<LocalHealthMetrics>> _weeklyMetrics = {};

  bool get isLoading => _isLoading;
  bool get isConnected => _isConnected;
  bool get isAvailable => _isAvailable;
  bool get installNeeded => _installNeeded;
  String? get errorMessage => _errorMessage;
  Map<HealthMetricType, List<LocalHealthMetrics>> get weeklyMetrics =>
      _weeklyMetrics;

  Future<void> initialize() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _isAvailable = await _syncService.isAvailable();
      _installNeeded = !_isAvailable;
      if (_isAvailable) {
        final hasPerms = await _syncService.hasPermissions();
        _isConnected = hasPerms;
        if (hasPerms) {
          await _loadWeeklyMetrics();
        }
      }
    } catch (e) {
      _errorMessage = 'Erro ao inicializar sincronização: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> connectHealth() async {
    _isAvailable = await _syncService.isAvailable();
    if (!_isAvailable) {
      _errorMessage = 'Health Connect não está disponível neste dispositivo.';
      notifyListeners();
      return false;
    }
    final alreadyHasPerms = await _syncService.hasPermissions();
    if (alreadyHasPerms) {
      _isConnected = true;
      await _syncService.fetchDailyMetrics();
      await _loadWeeklyMetrics();
      return true;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final granted = await _syncService.requestPermissions();
      if (!granted) {
        _errorMessage = 'Permissão negada. A sincronização requer acesso aos dados de saúde.';
        return false;
      }

      await _syncService.fetchDailyMetrics();
      _isConnected = true;
      await _loadWeeklyMetrics();
      return true;
    } catch (e) {
      _errorMessage = 'Erro ao conectar: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> installHealthConnect() async {
    try {
      await _syncService.installHealthConnect();
    } catch (_) {}
  }

  Future<void> disconnectHealth() async {
    _isConnected = false;
    _weeklyMetrics = {};
    notifyListeners();
  }

  Future<void> refreshMetrics() async {
    if (!_isConnected) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _syncService.fetchDailyMetrics();
      await _loadWeeklyMetrics();
    } catch (e) {
      _errorMessage = 'Erro ao atualizar dados: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> simulateData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _syncService.seedSimulatedData();
      await _loadWeeklyMetrics();
    } catch (e) {
      _errorMessage = 'Erro ao simular dados: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadWeeklyMetrics() async {
    _weeklyMetrics = await _syncService.getWeeklyMetrics();
  }

  /// Helper: aggregate metrics for a specific type for the chart
  Map<DateTime, double> getDailyAggregate(HealthMetricType type) {
    final metrics = _weeklyMetrics[type] ?? [];
    final dailyMap = <DateTime, List<double>>{};

    for (final metric in metrics) {
      final day = DateTime(
        metric.startTime.year,
        metric.startTime.month,
        metric.startTime.day,
      );
      dailyMap.putIfAbsent(day, () => []);
      dailyMap[day]!.add(metric.value);
    }

    return dailyMap.map(
      (day, values) {
        if (type == HealthMetricType.heartRate) {
          return MapEntry(day, values.reduce((a, b) => a + b) / values.length);
        }
        return MapEntry(day, values.fold(0.0, (a, b) => a + b));
      },
    );
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
