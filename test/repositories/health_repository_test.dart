import 'package:artriapp/models/health_metric_type.dart';
import 'package:artriapp/models/local_health_metrics.dart';
import 'package:artriapp/repositories/health_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/mock_health_repository.dart';

void main() {
  late MockHealthRepository repository;

  setUp(() {
    repository = MockHealthRepository();
  });

  group('HealthRepository', () {
    test('insertMetric() and getMetrics() work correctly', () async {
      final metric = LocalHealthMetrics(
        metricType: HealthMetricType.steps,
        value: 5000.0,
        startTime: DateTime(2024, 1, 1, 10, 0),
        unit: 'count',
      );

      final id = await repository.insertMetric(metric);
      expect(id, greaterThan(0));

      final metrics = await repository.getMetrics(
        type: HealthMetricType.steps,
      );
      expect(metrics.length, 1);
      expect(metrics.first.value, 5000.0);
      expect(metrics.first.id, id);
    });

    test('insertMetrics() batch inserts correctly', () async {
      final metrics = [
        LocalHealthMetrics(
          metricType: HealthMetricType.steps,
          value: 1000.0,
          startTime: DateTime(2024, 1, 1, 10, 0),
          unit: 'count',
        ),
        LocalHealthMetrics(
          metricType: HealthMetricType.steps,
          value: 2000.0,
          startTime: DateTime(2024, 1, 1, 11, 0),
          unit: 'count',
        ),
        LocalHealthMetrics(
          metricType: HealthMetricType.sleep,
          value: 7.5,
          startTime: DateTime(2024, 1, 1, 0, 0),
          endTime: DateTime(2024, 1, 1, 7, 30),
          unit: 'hours',
        ),
      ];

      await repository.insertMetrics(metrics);

      final all = await repository.getMetrics();
      expect(all.length, 3);

      final stepsMetrics = await repository.getMetrics(
        type: HealthMetricType.steps,
      );
      expect(stepsMetrics.length, 2);

      final sleepMetrics = await repository.getMetrics(
        type: HealthMetricType.sleep,
      );
      expect(sleepMetrics.length, 1);
    });

    test('insertMetric replaces duplicate (type + start_time)', () async {
      final startTime = DateTime(2024, 1, 1, 10, 0);
      final metric1 = LocalHealthMetrics(
        metricType: HealthMetricType.steps,
        value: 1000.0,
        startTime: startTime,
        unit: 'count',
      );
      final metric2 = LocalHealthMetrics(
        metricType: HealthMetricType.steps,
        value: 2000.0,
        startTime: startTime,
        unit: 'count',
      );

      await repository.insertMetric(metric1);
      await repository.insertMetric(metric2);

      final count = await repository.getMetricsCount(
        type: HealthMetricType.steps,
      );
      expect(count, 1);

      final results = await repository.getMetrics(
        type: HealthMetricType.steps,
      );
      expect(results.length, 1);
      expect(results.first.value, 2000.0);
    });

    test('getMetrics filters by date range', () async {
      await repository.insertMetrics([
        LocalHealthMetrics(
          metricType: HealthMetricType.steps,
          value: 100.0,
          startTime: DateTime(2024, 1, 1),
          unit: 'count',
        ),
        LocalHealthMetrics(
          metricType: HealthMetricType.steps,
          value: 200.0,
          startTime: DateTime(2024, 1, 2),
          unit: 'count',
        ),
        LocalHealthMetrics(
          metricType: HealthMetricType.steps,
          value: 300.0,
          startTime: DateTime(2024, 1, 3),
          unit: 'count',
        ),
      ]);

      final filtered = await repository.getMetrics(
        type: HealthMetricType.steps,
        from: DateTime(2024, 1, 2),
        to: DateTime(2024, 1, 3),
      );
      expect(filtered.length, 1);
      expect(filtered.first.value, 200.0);
    });

    test('getUnsyncedMetrics() returns only unsynced records', () async {
      final synced = LocalHealthMetrics(
        metricType: HealthMetricType.steps,
        value: 100.0,
        startTime: DateTime(2024, 1, 1),
        unit: 'count',
        isSynced: true,
      );
      final unsynced = LocalHealthMetrics(
        metricType: HealthMetricType.steps,
        value: 200.0,
        startTime: DateTime(2024, 1, 2),
        unit: 'count',
      );

      await repository.insertMetric(synced);
      await repository.insertMetric(unsynced);

      final unsyncedList = await repository.getUnsyncedMetrics();
      expect(unsyncedList.length, 1);
      expect(unsyncedList.first.value, 200.0);
    });

    test('markAsSynced() updates is_synced flag', () async {
      final metric = LocalHealthMetrics(
        metricType: HealthMetricType.steps,
        value: 100.0,
        startTime: DateTime(2024, 1, 1),
        unit: 'count',
      );

      final id = await repository.insertMetric(metric);
      await repository.markAsSynced(id);

      final synced = await repository.getMetrics(isSynced: true);
      expect(synced.length, 1);
      expect(synced.first.id, id);
    });

    test('markAllAsSynced() updates multiple records', () async {
      final ids = <int>[];
      for (int i = 0; i < 3; i++) {
        final id = await repository.insertMetric(
          LocalHealthMetrics(
            metricType: HealthMetricType.steps,
            value: (i + 1) * 100.0,
            startTime: DateTime(2024, 1, i + 1),
            unit: 'count',
          ),
        );
        ids.add(id);
      }

      await repository.markAllAsSynced(ids);

      final synced = await repository.getMetrics(isSynced: true);
      expect(synced.length, 3);
    });

    test('deleteMetricsOlderThan() removes old records', () async {
      await repository.insertMetric(
        LocalHealthMetrics(
          metricType: HealthMetricType.steps,
          value: 100.0,
          startTime: DateTime(2024, 1, 1),
          unit: 'count',
        ),
      );
      await repository.insertMetric(
        LocalHealthMetrics(
          metricType: HealthMetricType.steps,
          value: 200.0,
          startTime: DateTime(2024, 1, 15),
          unit: 'count',
        ),
      );

      await repository.deleteMetricsOlderThan(DateTime(2024, 1, 10));

      final remaining = await repository.getMetrics();
      expect(remaining.length, 1);
      expect(remaining.first.value, 200.0);
    });

    test('getMetricsCount() returns correct count', () async {
      await repository.insertMetrics([
        LocalHealthMetrics(
          metricType: HealthMetricType.steps,
          value: 100.0,
          startTime: DateTime(2024, 1, 1),
          unit: 'count',
        ),
        LocalHealthMetrics(
          metricType: HealthMetricType.sleep,
          value: 7.0,
          startTime: DateTime(2024, 1, 1),
          unit: 'hours',
        ),
      ]);

      final totalCount = await repository.getMetricsCount();
      expect(totalCount, 2);

      final stepsCount = await repository.getMetricsCount(
        type: HealthMetricType.steps,
      );
      expect(stepsCount, 1);
    });

    test('getMetrics returns empty list when no data', () async {
      final metrics = await repository.getMetrics(
        type: HealthMetricType.heartRate,
      );
      expect(metrics, isEmpty);
    });

    test('getUnsyncedMetrics returns empty list when all synced', () async {
      final metric = LocalHealthMetrics(
        metricType: HealthMetricType.steps,
        value: 100.0,
        startTime: DateTime(2024, 1, 1),
        unit: 'count',
        isSynced: true,
      );
      await repository.insertMetric(metric);

      final unsynced = await repository.getUnsyncedMetrics();
      expect(unsynced, isEmpty);
    });
  });
}
