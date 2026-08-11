import 'package:artriapp/models/index.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/services/index.dart';
import 'package:fl_chart/fl_chart.dart';

class EvolutionViewModel extends ChangeNotifier {
  final List<int> _fatigueLevels = [];
  List<int> get fatigueLevels => _fatigueLevels;

  final List<int> _sleepLevels = [];
  List<int> get sleepLevels => _sleepLevels;

  final List<int> _painLevelsOnlyNumbers = [];
  List<int> get painLevelsOnlyNumbers => _painLevelsOnlyNumbers;

  final List<int> _swellingLevelsOnlyNumbers = [];
  List<int> get swellingLevelsOnlyNumbers => _swellingLevelsOnlyNumbers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isConnected = false;
  bool get isConnected => _isConnected;
  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;
  bool _installNeeded = false;
  bool get installNeeded => _installNeeded;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  Map<HealthMetricType, List<LocalHealthMetrics>> _weeklyMetrics = {};
  Map<HealthMetricType, List<LocalHealthMetrics>> get weeklyMetrics =>
      _weeklyMetrics;

  final HealthSyncService _syncService;
  final UserDiaryService _diaryService = UserDiaryService();

  EvolutionViewModel({required HealthSyncService syncService})
      : _syncService = syncService {
    loadPainData();
    loadFatigueData();
    loadSleepData();
    loadSwellingData();
  }

  Future<void> loadPainData() async {
    try {
      final painData = await _diaryService.getPainLevels();

      _painLevelsOnlyNumbers.clear();
      _painLevelsOnlyNumbers.addAll(painData);

      notifyListeners();
    } catch (e) {
      log('Erro ao carregar dados: $e');
    }
  }

  Future<void> loadFatigueData() async {
    try {
      final fatigueData = await _diaryService.getFatigueLevels();

      _fatigueLevels.clear();
      _fatigueLevels.addAll(fatigueData);

      notifyListeners();
    } catch (e) {
      log('Erro ao carregar dados: $e');
    }
  }

  Future<void> loadSleepData() async {
    try {
      final sleepData = await _diaryService.getSleepLevels();

      _sleepLevels.clear();
      _sleepLevels.addAll(sleepData);

      notifyListeners();
    } catch (e) {
      log('Erro ao carregar dados: $e');
    }
  }

  Future<void> loadSwellingData() async {
    try {
      final swellingData = await _diaryService.getSwellingLevels();

      _swellingLevelsOnlyNumbers.clear();
      _swellingLevelsOnlyNumbers.addAll(swellingData);

      notifyListeners();
    } catch (e) {
      log('Erro ao carregar dados: $e');
    }
  }

  Future<void> addPainLevel(BodyOptions bodyOption, int? newLevel) async {
    try {
      if (newLevel == null) return;

      await _diaryService.addPainLevel(bodyOption.toString(), newLevel);
      _painLevelsOnlyNumbers.add(newLevel);
      notifyListeners();
    } catch (e) {
      log('Erro ao salvar: $e');
    }
  }

  Future<void> addFatigueLevel(int? newLevel, String? description) async {
    try {
      if (newLevel == null) return;
      description ??= 'novo nível de fadiga';
      await _diaryService.addFatigueLevel(newLevel, description);
      _fatigueLevels.add(newLevel);
      notifyListeners();
    } catch (e) {
      log('Erro ao salvar: $e');
    }
  }

  Future<void> addSleepLevel(int? newLevel, int? duration) async {
    try {
      if (newLevel == null) return;
      duration ??= -1;
      await _diaryService.addSleepLevel(newLevel, duration);
      _sleepLevels.add(newLevel);
      notifyListeners();
    } catch (e) {
      log('Erro ao salvar: $e');
    }
  }

  Future<void> addSwellingLevel(BodyOptions bodyOption, int newLevel) async {
    try {
      await _diaryService.addSwellingLevel(bodyOption.toString(), newLevel);
      _swellingLevelsOnlyNumbers.add(newLevel);
      notifyListeners();
    } catch (e) {
      log('Erro ao salvar: $e');
    }
  }

  List<FlSpot> getLast7PainLevels() {
    List<FlSpot> last7PainSpots = [];
    int spotIndex = 0;
    int levelIndex = _painLevelsOnlyNumbers.length >= 7
        ? _painLevelsOnlyNumbers.length - 7
        : 0;

    for (;
        levelIndex < _painLevelsOnlyNumbers.length && spotIndex < 7;
        levelIndex++, spotIndex++) {
      last7PainSpots.add(
        FlSpot(
          spotIndex.toDouble(),
          _painLevelsOnlyNumbers[levelIndex].toDouble(),
        ),
      );
    }

    return last7PainSpots;
  }

  List<FlSpot> getLast7FatigueLevels() {
    List<FlSpot> last7FatigueSpots = [];
    int spotIndex = 0;
    int levelIndex = _fatigueLevels.length >= 7 ? _fatigueLevels.length - 7 : 0;

    for (;
        levelIndex < _fatigueLevels.length && spotIndex < 7;
        levelIndex++, spotIndex++) {
      last7FatigueSpots.add(
        FlSpot(spotIndex.toDouble(), _fatigueLevels[levelIndex].toDouble()),
      );
    }

    return last7FatigueSpots;
  }

  List<FlSpot> getLast7SleepLevels() {
    List<FlSpot> last7SleepSpots = [];
    int spotIndex = 0;
    int levelIndex = _sleepLevels.length >= 7 ? _sleepLevels.length - 7 : 0;

    for (;
        levelIndex < _sleepLevels.length && spotIndex < 7;
        levelIndex++, spotIndex++) {
      last7SleepSpots.add(
        FlSpot(spotIndex.toDouble(), _sleepLevels[levelIndex].toDouble()),
      );
    }

    return last7SleepSpots;
  }

  List<FlSpot> getLast7SwellingLevels() {
    List<FlSpot> last7SwellingSpots = [];
    int spotIndex = 0;
    int levelIndex = _swellingLevelsOnlyNumbers.length >= 7
        ? _swellingLevelsOnlyNumbers.length - 7
        : 0;

    for (;
        levelIndex < _swellingLevelsOnlyNumbers.length && spotIndex < 7;
        levelIndex++, spotIndex++) {
      last7SwellingSpots.add(
        FlSpot(
          spotIndex.toDouble(),
          _swellingLevelsOnlyNumbers[levelIndex].toDouble(),
        ),
      );
    }

    return last7SwellingSpots;
  }

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
        _errorMessage =
            'Permissão negada. A sincronização requer acesso aos dados de saúde.';
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
