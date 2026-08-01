import 'package:health/health.dart';

import 'package:artriapp/models/health_metric_type.dart';
import 'package:artriapp/models/local_health_metrics.dart';
import 'package:artriapp/services/health_sync_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/mock_health_data_provider.dart';
import '../helpers/mock_health_repository.dart';

HealthDataPoint _createDataPoint({
  required num value,
  required HealthDataType type,
  required HealthDataUnit unit,
  required DateTime dateFrom,
  DateTime? dateTo,
}) {
  return HealthDataPoint(
    uuid: 'test-uuid-${DateTime.now().millisecondsSinceEpoch}-$value',
    value: NumericHealthValue(numericValue: value),
    type: type,
    unit: unit,
    dateFrom: dateFrom,
    dateTo: dateTo ?? dateFrom,
    sourcePlatform: HealthPlatformType.googleHealthConnect,
    sourceDeviceId: 'test-device',
    sourceId: 'test-source',
    sourceName: 'Test Source',
  );
}

void main() {
  late HealthSyncService service;
  late MockHealthDataProvider dataProvider;
  late MockHealthRepository repository;

  setUp(() {
    repository = MockHealthRepository();
    dataProvider = MockHealthDataProvider();
    service = HealthSyncService(
      dataProvider: dataProvider,
      repository: repository,
    );
  });

  group('HealthSyncService', () {
    test('isAvailable() returns true when Health Connect is available', () async {
      dataProvider.setAvailable(true);
      final result = await service.isAvailable();
      expect(result, isTrue);
    });

    test('isAvailable() returns false when Health Connect is unavailable', () async {
      dataProvider.setAvailable(false);
      final result = await service.isAvailable();
      expect(result, isFalse);
    });

    test('requestPermissions() returns true when granted', () async {
      dataProvider.setPermissionsGranted(true);
      final result = await service.requestPermissions();
      expect(result, isTrue);
    });

    test('requestPermissions() returns false when denied', () async {
      dataProvider.setPermissionsGranted(false);
      final result = await service.requestPermissions();
      expect(result, isFalse);
    });

    test('hasPermissions() returns true when permissions are granted', () async {
      dataProvider.setPermissionsGranted(true);
      final result = await service.hasPermissions();
      expect(result, isTrue);
    });

    test('fetchDailyMetrics() stores data and returns counts', () async {
      dataProvider.setDataPoints([
        _createDataPoint(
          value: 5000,
          type: HealthDataType.STEPS,
          unit: HealthDataUnit.COUNT,
          dateFrom: DateTime(2024, 1, 15, 10, 0),
        ),
        _createDataPoint(
          value: 7.5,
          type: HealthDataType.SLEEP_ASLEEP,
          unit: HealthDataUnit.MINUTE,
          dateFrom: DateTime(2024, 1, 15, 0, 0),
          dateTo: DateTime(2024, 1, 15, 7, 30),
        ),
      ]);

      final result = await service.fetchDailyMetrics();

      expect(result[HealthMetricType.steps], 1);
      expect(result[HealthMetricType.sleep], 1);

      final storedMetrics = await repository.getMetrics(
        type: HealthMetricType.steps,
      );
      expect(storedMetrics.length, 1);
      expect(storedMetrics.first.value, 5000.0);
    });

    test('fetchDailyMetrics() handles empty data gracefully', () async {
      dataProvider.setDataPoints([]);
      final result = await service.fetchDailyMetrics();

      for (final entry in result.entries) {
        expect(entry.value, 0);
      }
    });

    test('getWeeklyMetrics() returns metrics grouped by type', () async {
      await repository.insertMetrics([
        _buildMetric(HealthMetricType.steps, 5000, hoursAgo: 24),
        _buildMetric(HealthMetricType.steps, 6000, hoursAgo: 48),
        _buildMetric(HealthMetricType.sleep, 7.5, hoursAgo: 12),
      ]);

      final weekly = await service.getWeeklyMetrics();

      expect(weekly[HealthMetricType.steps]!.length, 2);
      expect(weekly[HealthMetricType.sleep]!.length, 1);
      expect(weekly[HealthMetricType.heartRate]!.length, 0);
    });

    test('getWeeklyMetrics() returns empty lists when no data', () async {
      final weekly = await service.getWeeklyMetrics();

      for (final type in HealthMetricType.values) {
        expect(weekly[type], isEmpty);
      }
    });

    test('getUnsyncedMetrics() delegates to repository', () async {
      await repository.insertMetric(
        _buildMetric(HealthMetricType.steps, 100, hoursAgo: 1),
      );

      final unsynced = await service.getUnsyncedMetrics();
      expect(unsynced.length, 1);
    });

    test('clearOldData() removes data older than 30 days', () async {
      await repository.insertMetrics([
        LocalHealthMetrics(
          metricType: HealthMetricType.steps,
          value: 100.0,
          startTime: DateTime.now().subtract(const Duration(days: 60)),
          unit: 'count',
        ),
        LocalHealthMetrics(
          metricType: HealthMetricType.steps,
          value: 200.0,
          startTime: DateTime.now().subtract(const Duration(days: 1)),
          unit: 'count',
        ),
      ]);

      await service.clearOldData();

      final remaining = await repository.getMetrics();
      expect(remaining.length, 1);
      expect(remaining.first.value, 200.0);
    });
  });
}

LocalHealthMetrics _buildMetric(HealthMetricType type, double value, {int hoursAgo = 0}) {
  return LocalHealthMetrics(
    metricType: type,
    value: value,
    startTime: DateTime.now().subtract(Duration(hours: hoursAgo)),
    unit: _unitForType(type),
  );
}

String _unitForType(HealthMetricType t) {
  switch (t) {
    case HealthMetricType.steps:
      return 'count';
    case HealthMetricType.sleep:
      return 'min';
    case HealthMetricType.heartRate:
      return 'bpm';
    case HealthMetricType.activeEnergy:
      return 'kcal';
  }
}
