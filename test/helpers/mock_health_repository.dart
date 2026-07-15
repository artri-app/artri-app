import 'package:artriapp/models/health_metric_type.dart';
import 'package:artriapp/models/local_health_metrics.dart';
import 'package:artriapp/repositories/health_repository.dart';

class MockHealthRepository extends HealthRepository {
  final List<LocalHealthMetrics> _metrics = [];
  int _nextId = 1;

  MockHealthRepository() : super.mock();

  @override
  Future<int> insertMetric(LocalHealthMetrics metric) async {
    final withId = metric.copyWith(id: _nextId);
    _metrics.removeWhere(
      (m) =>
          m.metricType == metric.metricType &&
          m.startTime == metric.startTime,
    );
    _metrics.add(withId);
    _nextId++;
    return withId.id!;
  }

  @override
  Future<void> insertMetrics(List<LocalHealthMetrics> metrics) async {
    for (final m in metrics) {
      await insertMetric(m);
    }
  }

  @override
  Future<List<LocalHealthMetrics>> getMetrics({
    HealthMetricType? type,
    DateTime? from,
    DateTime? to,
    bool? isSynced,
    int? limit,
  }) async {
    var result = _metrics.toList();

    if (type != null) {
      result = result.where((m) => m.metricType == type).toList();
    }
    if (from != null) {
      result = result.where((m) => m.startTime.isAtSameMomentAs(from) || m.startTime.isAfter(from)).toList();
    }
    if (to != null) {
      result = result.where((m) => m.startTime.isBefore(to)).toList();
    }
    if (isSynced != null) {
      result = result.where((m) => m.isSynced == isSynced).toList();
    }

    result.sort((a, b) => a.startTime.compareTo(b.startTime));

    if (limit != null && result.length > limit) {
      result = result.sublist(0, limit);
    }

    return result;
  }

  @override
  Future<List<LocalHealthMetrics>> getUnsyncedMetrics() async {
    return _metrics.where((m) => !m.isSynced).toList();
  }

  @override
  Future<void> markAsSynced(int id) async {
    final index = _metrics.indexWhere((m) => m.id == id);
    if (index != -1) {
      _metrics[index] = _metrics[index].copyWith(isSynced: true);
    }
  }

  @override
  Future<void> markAllAsSynced(List<int> ids) async {
    for (final id in ids) {
      await markAsSynced(id);
    }
  }

  @override
  Future<void> deleteMetricsOlderThan(DateTime date) async {
    _metrics.removeWhere((m) => m.startTime.isBefore(date));
  }

  @override
  Future<int> getMetricsCount({HealthMetricType? type}) async {
    if (type == null) return _metrics.length;
    return _metrics.where((m) => m.metricType == type).length;
  }
}
