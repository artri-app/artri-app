import 'package:artriapp/database/app_database.dart';
import 'package:artriapp/models/health_metric_type.dart';
import 'package:artriapp/models/local_health_metrics.dart';
import 'package:sqflite/sqflite.dart';

class HealthRepository {
  final AppDatabase? _db;

  HealthRepository({required AppDatabase db}) : _db = db;

  HealthRepository.mock() : _db = null;

  AppDatabase get _requiredDb => _db!;

  Future<int> insertMetric(LocalHealthMetrics metric) async {
    final db = await _requiredDb.database;
    return db.insert(
      'health_metrics',
      metric.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMetrics(List<LocalHealthMetrics> metrics) async {
    final db = await _requiredDb.database;
    final batch = db.batch();
    for (final metric in metrics) {
      batch.insert(
        'health_metrics',
        metric.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<LocalHealthMetrics>> getMetrics({
    HealthMetricType? type,
    DateTime? from,
    DateTime? to,
    bool? isSynced,
    int? limit,
  }) async {
    final db = await _requiredDb.database;
    final conditions = <String>[];
    final args = <Object?>[];

    if (type != null) {
      conditions.add('metric_type = ?');
      args.add(type.toDbString());
    }
    if (from != null) {
      conditions.add('start_time >= ?');
      args.add(from.toIso8601String());
    }
    if (to != null) {
      conditions.add('start_time < ?');
      args.add(to.toIso8601String());
    }
    if (isSynced != null) {
      conditions.add('is_synced = ?');
      args.add(isSynced ? 1 : 0);
    }

    final where = conditions.isNotEmpty ? conditions.join(' AND ') : null;

    final maps = await db.query(
      'health_metrics',
      where: where,
      whereArgs: args.isNotEmpty ? args : null,
      orderBy: 'start_time ASC',
      limit: limit,
    );

    return maps.map((m) => LocalHealthMetrics.fromMap(m)).toList();
  }

  Future<List<LocalHealthMetrics>> getUnsyncedMetrics() async {
    return getMetrics(isSynced: false);
  }

  Future<void> markAsSynced(int id) async {
    final db = await _requiredDb.database;
    await db.update(
      'health_metrics',
      {'is_synced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> markAllAsSynced(List<int> ids) async {
    final db = await _requiredDb.database;
    final batch = db.batch();
    for (final id in ids) {
      batch.update(
        'health_metrics',
        {'is_synced': 1},
        where: 'id = ?',
        whereArgs: [id],
      );
    }
    await batch.commit(noResult: true);
  }

  Future<void> deleteMetricsOlderThan(DateTime date) async {
    final db = await _requiredDb.database;
    await db.delete(
      'health_metrics',
      where: 'start_time < ?',
      whereArgs: [date.toIso8601String()],
    );
  }

  Future<int> getMetricsCount({HealthMetricType? type}) async {
    final db = await _requiredDb.database;
    final conditions = <String>[];
    final args = <Object?>[];

    if (type != null) {
      conditions.add('metric_type = ?');
      args.add(type.toDbString());
    }

    final where = conditions.isNotEmpty ? conditions.join(' AND ') : null;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM health_metrics${where != null ? ' WHERE $where' : ''}',
      args.isNotEmpty ? args : null,
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}
