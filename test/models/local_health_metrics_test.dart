import 'package:artriapp/models/health_metric_type.dart';
import 'package:artriapp/models/local_health_metrics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocalHealthMetrics', () {
    test('toMap() and fromMap() round-trip correctly', () {
      final now = DateTime.now();
      final metric = LocalHealthMetrics(
        id: 1,
        metricType: HealthMetricType.steps,
        value: 5432.0,
        startTime: now,
        endTime: now.add(const Duration(hours: 1)),
        unit: 'count',
        isSynced: false,
      );

      final map = metric.toMap();
      final restored = LocalHealthMetrics.fromMap(map);

      expect(restored.id, metric.id);
      expect(restored.metricType, metric.metricType);
      expect(restored.value, metric.value);
      expect(restored.startTime, metric.startTime);
      expect(restored.endTime, metric.endTime);
      expect(restored.unit, metric.unit);
      expect(restored.isSynced, metric.isSynced);
    });

    test('fromMap() handles null endTime and isSynced correctly', () {
      final map = <String, dynamic>{
        'id': 2,
        'metric_type': 'sleep',
        'value': 7.5,
        'start_time': DateTime(2024, 1, 15).toIso8601String(),
        'end_time': null,
        'unit': 'hours',
        'is_synced': 0,
      };

      final metric = LocalHealthMetrics.fromMap(map);

      expect(metric.id, 2);
      expect(metric.metricType, HealthMetricType.sleep);
      expect(metric.value, 7.5);
      expect(metric.endTime, isNull);
      expect(metric.isSynced, false);
    });

    test('toMap() excludes id when null', () {
      final metric = LocalHealthMetrics(
        metricType: HealthMetricType.heartRate,
        value: 72.0,
        startTime: DateTime.now(),
        unit: 'bpm',
      );

      final map = metric.toMap();

      expect(map.containsKey('id'), false);
    });

    test('copyWith() creates modified copy', () {
      final metric = LocalHealthMetrics(
        id: 1,
        metricType: HealthMetricType.steps,
        value: 5000.0,
        startTime: DateTime(2024, 1, 1),
        unit: 'count',
      );

      final modified = metric.copyWith(value: 6000.0, isSynced: true);

      expect(modified.id, 1);
      expect(modified.value, 6000.0);
      expect(modified.isSynced, true);
      expect(modified.metricType, HealthMetricType.steps);
    });

    test('equality operator works correctly', () {
      final now = DateTime.now();
      final a = LocalHealthMetrics(
        id: 1,
        metricType: HealthMetricType.steps,
        value: 100.0,
        startTime: now,
        unit: 'count',
      );
      final b = LocalHealthMetrics(
        id: 1,
        metricType: HealthMetricType.steps,
        value: 100.0,
        startTime: now,
        unit: 'count',
      );
      final c = LocalHealthMetrics(
        id: 2,
        metricType: HealthMetricType.steps,
        value: 100.0,
        startTime: now,
        unit: 'count',
      );

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('hashCode consistency', () {
      final now = DateTime.now();
      final metric = LocalHealthMetrics(
        id: 1,
        metricType: HealthMetricType.steps,
        value: 100.0,
        startTime: now,
        unit: 'count',
      );

      expect(metric.hashCode, metric.hashCode);
    });
  });

  group('HealthMetricType', () {
    test('toDbString() returns correct values', () {
      expect(HealthMetricType.steps.toDbString(), 'steps');
      expect(HealthMetricType.sleep.toDbString(), 'sleep');
      expect(HealthMetricType.heartRate.toDbString(), 'heart_rate');
      expect(HealthMetricType.activeEnergy.toDbString(), 'active_energy');
    });

    test('fromDbString() returns correct enum values', () {
      expect(
        HealthMetricType.fromDbString('steps'),
        HealthMetricType.steps,
      );
      expect(
        HealthMetricType.fromDbString('sleep'),
        HealthMetricType.sleep,
      );
      expect(
        HealthMetricType.fromDbString('heart_rate'),
        HealthMetricType.heartRate,
      );
      expect(
        HealthMetricType.fromDbString('active_energy'),
        HealthMetricType.activeEnergy,
      );
    });

    test('fromDbString() throws on unknown value', () {
      expect(
        () => HealthMetricType.fromDbString('unknown_type'),
        throwsArgumentError,
      );
    });
  });
}
