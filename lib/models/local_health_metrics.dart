import 'package:artriapp/models/health_metric_type.dart';

class LocalHealthMetrics {
  final int? id;
  final HealthMetricType metricType;
  final double value;
  final DateTime startTime;
  final DateTime? endTime;
  final String unit;
  final bool isSynced;

  LocalHealthMetrics({
    this.id,
    required this.metricType,
    required this.value,
    required this.startTime,
    this.endTime,
    required this.unit,
    this.isSynced = false,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'metric_type': metricType.toDbString(),
      'value': value,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'unit': unit,
      'is_synced': isSynced ? 1 : 0,
    };
  }

  factory LocalHealthMetrics.fromMap(Map<String, dynamic> map) {
    return LocalHealthMetrics(
      id: map['id'] as int?,
      metricType: HealthMetricType.fromDbString(map['metric_type'] as String),
      value: (map['value'] as num).toDouble(),
      startTime: DateTime.parse(map['start_time'] as String),
      endTime: map['end_time'] != null
          ? DateTime.parse(map['end_time'] as String)
          : null,
      unit: map['unit'] as String,
      isSynced: (map['is_synced'] as int) == 1,
    );
  }

  LocalHealthMetrics copyWith({
    int? id,
    HealthMetricType? metricType,
    double? value,
    DateTime? startTime,
    DateTime? endTime,
    String? unit,
    bool? isSynced,
  }) {
    return LocalHealthMetrics(
      id: id ?? this.id,
      metricType: metricType ?? this.metricType,
      value: value ?? this.value,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      unit: unit ?? this.unit,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocalHealthMetrics &&
        other.id == id &&
        other.metricType == metricType &&
        other.value == value &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.unit == unit &&
        other.isSynced == isSynced;
  }

  @override
  int get hashCode {
    return Object.hash(id, metricType, value, startTime, endTime, unit, isSynced);
  }
}
