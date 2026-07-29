enum HealthMetricType {
  steps,
  sleep,
  heartRate,
  activeEnergy;

  String toDbString() {
    switch (this) {
      case HealthMetricType.steps:
        return 'steps';
      case HealthMetricType.sleep:
        return 'sleep';
      case HealthMetricType.heartRate:
        return 'heart_rate';
      case HealthMetricType.activeEnergy:
        return 'active_energy';
    }
  }

  static HealthMetricType fromDbString(String value) {
    switch (value) {
      case 'steps':
        return HealthMetricType.steps;
      case 'sleep':
        return HealthMetricType.sleep;
      case 'heart_rate':
        return HealthMetricType.heartRate;
      case 'active_energy':
        return HealthMetricType.activeEnergy;
      default:
        throw ArgumentError('Unknown HealthMetricType: $value');
    }
  }
}
