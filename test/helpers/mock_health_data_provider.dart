import 'package:health/health.dart';

import 'package:artriapp/services/interfaces/health_data_provider.dart';

class MockHealthDataProvider implements IHealthDataProvider {
  bool _available = true;
  bool _permissionsGranted = true;
  List<HealthDataPoint> _dataPoints = [];

  MockHealthDataProvider();

  void setAvailable(bool value) => _available = value;
  void setPermissionsGranted(bool value) => _permissionsGranted = value;
  void setDataPoints(List<HealthDataPoint> points) => _dataPoints = points;

  @override
  Future<bool> isAvailable() async => _available;

  @override
  Future<bool> requestPermissions() async => _permissionsGranted;

  @override
  Future<bool> hasPermissions() async => _permissionsGranted;

  @override
  Future<void> installHealthConnect() async {}

  @override
  Future<List<HealthDataPoint>> fetchData({
    required List<HealthDataType> types,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    return _dataPoints.where((p) => types.contains(p.type)).toList();
  }
}
