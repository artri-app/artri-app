import 'package:artriapp/models/health_metric_type.dart';
import 'package:artriapp/models/local_health_metrics.dart';
import 'package:artriapp/repositories/health_repository.dart';
import 'package:artriapp/services/health_sync_service.dart';
import 'package:artriapp/services/interfaces/health_data_provider.dart';

class MockHealthSyncService extends HealthSyncService {
  MockHealthSyncService({
    required IHealthDataProvider dataProvider,
    required HealthRepository repository,
  }) : super(dataProvider: dataProvider, repository: repository);

  bool _available = true;
  bool _permissionsGranted = true;
  Map<HealthMetricType, int> _fetchResult = {};
  Map<HealthMetricType, List<LocalHealthMetrics>> _weeklyResult = {};

  void setAvailable(bool value) => _available = value;
  void setPermissionsGranted(bool value) => _permissionsGranted = value;
  void setFetchResult(Map<HealthMetricType, int> result) => _fetchResult = result;
  void setWeeklyResult(
    Map<HealthMetricType, List<LocalHealthMetrics>> result,
  ) =>
      _weeklyResult = result;

  @override
  Future<bool> isAvailable() async => _available;

  @override
  Future<bool> requestPermissions() async => _permissionsGranted;

  @override
  Future<bool> hasPermissions() async => _permissionsGranted;

  @override
  Future<void> installHealthConnect() async {}

  @override
  Future<Map<HealthMetricType, int>> fetchDailyMetrics() async => _fetchResult;

  @override
  Future<Map<HealthMetricType, List<LocalHealthMetrics>>>
      getWeeklyMetrics() async => _weeklyResult;
}
