import 'package:artriapp/models/health_metric_type.dart';
import 'package:artriapp/models/local_health_metrics.dart';
import 'package:artriapp/view_models/health_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/mock_health_data_provider.dart';
import '../helpers/mock_health_repository.dart';
import '../helpers/mock_health_sync_service.dart';

void main() {
  late MockHealthSyncService syncService;
  late MockHealthRepository repository;
  late HealthViewModel viewModel;

  setUp(() {
    repository = MockHealthRepository();
    syncService = MockHealthSyncService(
      dataProvider: MockHealthDataProvider(),
      repository: repository,
    );
    viewModel = HealthViewModel(syncService: syncService);
  });

  group('HealthViewModel', () {
    test('initialize() sets isAvailable=true when HC is available', () async {
      syncService.setAvailable(true);
      syncService.setPermissionsGranted(false);

      await viewModel.initialize();

      expect(viewModel.isAvailable, isTrue);
      expect(viewModel.isConnected, isFalse);
      expect(viewModel.installNeeded, isFalse);
    });

    test('initialize() sets installNeeded=true when HC is unavailable', () async {
      syncService.setAvailable(false);

      await viewModel.initialize();

      expect(viewModel.installNeeded, isTrue);
      expect(viewModel.isAvailable, isFalse);
    });

    test('initialize() sets isAvailable=false when HC is unavailable', () async {
      syncService.setAvailable(false);

      await viewModel.initialize();

      expect(viewModel.isAvailable, isFalse);
      expect(viewModel.isConnected, isFalse);
      expect(viewModel.installNeeded, isTrue);
    });

    test('initialize() sets isConnected=true when permissions already granted',
        () async {
          syncService.setAvailable(true);
          syncService.setPermissionsGranted(true);

          await viewModel.initialize();

          expect(viewModel.isConnected, isTrue);
    });

    test('connectHealth() returns true and sets isConnected on success',
        () async {
      syncService.setAvailable(true);
      syncService.setPermissionsGranted(true);

      final result = await viewModel.connectHealth();

      expect(result, isTrue);
      expect(viewModel.isConnected, isTrue);
    });

    test('connectHealth() returns false when HC not available', () async {
      syncService.setAvailable(false);

      final result = await viewModel.connectHealth();

      expect(result, isFalse);
      expect(viewModel.isConnected, isFalse);
      expect(viewModel.errorMessage, isNotNull);
    });

    test('connectHealth() returns false when permissions denied', () async {
      syncService.setAvailable(true);
      syncService.setPermissionsGranted(false);

      final result = await viewModel.connectHealth();

      expect(result, isFalse);
      expect(viewModel.isConnected, isFalse);
      expect(viewModel.errorMessage, isNotNull);
    });

    test('disconnectHealth() clears connection state', () async {
      syncService.setAvailable(true);
      syncService.setPermissionsGranted(true);
      final connected = await viewModel.connectHealth();
      expect(connected, isTrue);

      await viewModel.disconnectHealth();

      expect(viewModel.isConnected, isFalse);
      expect(viewModel.weeklyMetrics, isEmpty);
    });

    test('refreshMetrics() does nothing when not connected', () async {
      await viewModel.refreshMetrics();
      expect(viewModel.isLoading, isFalse);
    });

    test('refreshMetrics() fetches data when connected', () async {
      syncService.setAvailable(true);
      syncService.setPermissionsGranted(true);
      final connected = await viewModel.connectHealth();
      expect(connected, isTrue);

      await viewModel.refreshMetrics();

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
    });

    test('getDailyAggregate() aggregates data by day', () async {
      final now = DateTime.now();
      syncService.setAvailable(true);
      syncService.setPermissionsGranted(true);
      syncService.setWeeklyResult({
        HealthMetricType.steps: [
          LocalHealthMetrics(
            metricType: HealthMetricType.steps,
            value: 3000.0,
            startTime: DateTime(now.year, now.month, now.day, 10, 0),
            unit: 'count',
          ),
          LocalHealthMetrics(
            metricType: HealthMetricType.steps,
            value: 4000.0,
            startTime: DateTime(now.year, now.month, now.day, 14, 0),
            unit: 'count',
          ),
        ],
      });

      final connected = await viewModel.connectHealth();
      expect(connected, isTrue);

      final aggregated = viewModel.getDailyAggregate(HealthMetricType.steps);
      final today = DateTime(now.year, now.month, now.day);
      expect(aggregated[today], 7000.0);
    });

    test('getDailyAggregate() averages heart rate values', () async {
      final now = DateTime.now();
      syncService.setAvailable(true);
      syncService.setPermissionsGranted(true);
      syncService.setWeeklyResult({
        HealthMetricType.heartRate: [
          LocalHealthMetrics(
            metricType: HealthMetricType.heartRate,
            value: 70.0,
            startTime: DateTime(now.year, now.month, now.day, 10, 0),
            unit: 'bpm',
          ),
          LocalHealthMetrics(
            metricType: HealthMetricType.heartRate,
            value: 80.0,
            startTime: DateTime(now.year, now.month, now.day, 11, 0),
            unit: 'bpm',
          ),
        ],
      });

      final connected = await viewModel.connectHealth();
      expect(connected, isTrue);

      final aggregated = viewModel.getDailyAggregate(HealthMetricType.heartRate);
      final today = DateTime(now.year, now.month, now.day);
      expect(aggregated[today], 75.0);
    });

    test('clearError() clears error message', () async {
      syncService.setAvailable(false);
      await viewModel.connectHealth();
      expect(viewModel.errorMessage, isNotNull);

      viewModel.clearError();

      expect(viewModel.errorMessage, isNull);
    });

    test('initialize handles errors gracefully', () async {
      syncService.setAvailable(true);
      syncService.setPermissionsGranted(true);

      await viewModel.initialize();

      expect(viewModel.errorMessage, isNull);
      expect(viewModel.isLoading, isFalse);
    });
  });
}
