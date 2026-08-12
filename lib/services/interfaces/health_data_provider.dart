import 'package:flutter/foundation.dart';
import 'package:health/health.dart';

abstract class IHealthDataProvider {
  Future<bool> isAvailable();
  Future<bool> requestPermissions();
  Future<bool> hasPermissions();
  Future<void> installHealthConnect();
  Future<List<HealthDataPoint>> fetchData({
    required List<HealthDataType> types,
    required DateTime startTime,
    required DateTime endTime,
  });
}

class HealthDataProvider implements IHealthDataProvider {
  final Health _health;
  bool _configured = false;

  HealthDataProvider({Health? health})
      : _health = health ?? Health();

  Future<void> _ensureConfigured() async {
    if (_configured) return;
    try {
      await _health.configure();
      _configured = true;
    } catch (e) {
      debugPrint('HealthDataProvider: configure() failed — $e');
    }
  }

  static final _neededTypes = [
    HealthDataType.STEPS,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.HEART_RATE,
    HealthDataType.ACTIVE_ENERGY_BURNED,
  ];

  @override
  Future<bool> isAvailable() async {
    await _ensureConfigured();
    try {
      final status = await _health.getHealthConnectSdkStatus();
      if (status == HealthConnectSdkStatus.sdkAvailable) return true;
      debugPrint('HealthDataProvider: getHealthConnectSdkStatus = $status');
    } catch (e) {
      debugPrint('HealthDataProvider: getHealthConnectSdkStatus() threw — $e');
    }
    try {
      final available = await _health.isHealthConnectAvailable();
      if (available) return true;
    } catch (e) {
      debugPrint('HealthDataProvider: isHealthConnectAvailable() threw — $e');
    }
    return false;
  }

  @override
  Future<bool> requestPermissions() async {
    await _ensureConfigured();
    try {
      return await _health.requestAuthorization(_neededTypes);
    } catch (e) {
      debugPrint('HealthDataProvider: requestAuthorization() threw — $e');
      return false;
    }
  }

  @override
  Future<bool> hasPermissions() async {
    await _ensureConfigured();
    try {
      final result = await _health.hasPermissions(_neededTypes);
      return result ?? false;
    } catch (e) {
      debugPrint('HealthDataProvider: hasPermissions() threw — $e');
      return false;
    }
  }

  @override
  Future<void> installHealthConnect() async {
    await _ensureConfigured();
    try {
      await _health.installHealthConnect();
    } catch (e) {
      debugPrint('HealthDataProvider: installHealthConnect() threw — $e');
    }
  }

  @override
  Future<List<HealthDataPoint>> fetchData({
    required List<HealthDataType> types,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    await _ensureConfigured();
    try {
      return await _health.getHealthDataFromTypes(
        types: types,
        startTime: startTime,
        endTime: endTime,
      );
    } catch (e) {
      debugPrint('HealthDataProvider: fetchData() threw — $e');
      return [];
    }
  }
}
