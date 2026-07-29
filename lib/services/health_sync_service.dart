import 'dart:math';

import 'package:health/health.dart';

import 'package:artriapp/models/health_metric_type.dart';
import 'package:artriapp/models/local_health_metrics.dart';
import 'package:artriapp/repositories/health_repository.dart';
import 'package:artriapp/services/interfaces/health_data_provider.dart';

class HealthSyncService {
  final IHealthDataProvider _dataProvider;
  final HealthRepository _repository;

  HealthSyncService({
    required IHealthDataProvider dataProvider,
    required HealthRepository repository,
  })  : _dataProvider = dataProvider,
        _repository = repository;

  Future<bool> isAvailable() => _dataProvider.isAvailable();

  Future<bool> requestPermissions() => _dataProvider.requestPermissions();

  Future<bool> hasPermissions() => _dataProvider.hasPermissions();

  Future<void> installHealthConnect() => _dataProvider.installHealthConnect();

  Future<Map<HealthMetricType, int>> fetchDailyMetrics() async {
    final now = DateTime.now();
    final start = now.subtract(const Duration(hours: 24));
    final result = <HealthMetricType, int>{};

    for (final entry in _typeMapping.entries) {
      final points = await _dataProvider.fetchData(
        types: [entry.key],
        startTime: start,
        endTime: now,
      );

      if (points.isEmpty) continue;

      final metrics = points.map((point) {
        final numericValue = point.value is NumericHealthValue
            ? (point.value as NumericHealthValue).numericValue.toDouble()
            : 0.0;
        return LocalHealthMetrics(
          metricType: entry.value,
          value: numericValue,
          startTime: point.dateFrom,
          endTime: point.dateTo,
          unit: _unitToString(point.unit),
        );
      }).toList();

      await _repository.insertMetrics(metrics);
      result[entry.value] = metrics.length;
    }

    return result;
  }

  Future<Map<HealthMetricType, List<LocalHealthMetrics>>> getWeeklyMetrics() async {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    final result = <HealthMetricType, List<LocalHealthMetrics>>{};

    for (final type in HealthMetricType.values) {
      final metrics = await _repository.getMetrics(
        type: type,
        from: weekAgo,
        to: now,
      );
      result[type] = metrics;
    }

    return result;
  }

  Future<List<LocalHealthMetrics>> getUnsyncedMetrics() {
    return _repository.getUnsyncedMetrics();
  }

  Future<void> clearOldData() async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    await _repository.deleteMetricsOlderThan(thirtyDaysAgo);
  }

  Future<void> seedSimulatedData() async {
    final now = DateTime.now();
    final random = Random(42);
    final metrics = <LocalHealthMetrics>[];

    for (int day = 6; day >= 0; day--) {
      final date = DateTime(now.year, now.month, now.day - day);

      metrics.addAll([
        LocalHealthMetrics(
          metricType: HealthMetricType.steps,
          value: (3000 + random.nextDouble() * 7000).roundToDouble(),
          startTime: date,
          unit: 'count',
        ),
        LocalHealthMetrics(
          metricType: HealthMetricType.sleep,
          value: (5 + random.nextDouble() * 4).roundToDouble(),
          startTime: date,
          unit: 'hours',
        ),
        LocalHealthMetrics(
          metricType: HealthMetricType.heartRate,
          value: (65 + random.nextDouble() * 30).roundToDouble(),
          startTime: date,
          unit: 'bpm',
        ),
        LocalHealthMetrics(
          metricType: HealthMetricType.activeEnergy,
          value: (150 + random.nextDouble() * 400).roundToDouble(),
          startTime: date,
          unit: 'kcal',
        ),
      ]);
    }

    await _repository.insertMetrics(metrics);
  }

  static const _typeMapping = {
    HealthDataType.STEPS: HealthMetricType.steps,
    HealthDataType.SLEEP_ASLEEP: HealthMetricType.sleep,
    HealthDataType.HEART_RATE: HealthMetricType.heartRate,
    HealthDataType.ACTIVE_ENERGY_BURNED: HealthMetricType.activeEnergy,
  };

  String _unitToString(HealthDataUnit unit) {
    switch (unit) {
      case HealthDataUnit.BEATS_PER_MINUTE:
        return 'bpm';
      case HealthDataUnit.KILOCALORIE:
        return 'kcal';
      case HealthDataUnit.COUNT:
        return 'count';
      case HealthDataUnit.MINUTE:
        return 'min';
      case HealthDataUnit.HOUR:
        return 'hours';
      case HealthDataUnit.METER:
        return 'm';
      case HealthDataUnit.PERCENT:
        return '%';
      case HealthDataUnit.MILLIGRAM_PER_DECILITER:
        return 'mg/dL';
      default:
        return 'unknown';
    }
  }
}
