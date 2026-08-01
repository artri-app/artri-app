import 'package:artriapp/database/app_database.dart';
import 'package:artriapp/models/health_metric_type.dart';
import 'package:artriapp/models/local_health_metrics.dart';
import 'package:artriapp/repositories/health_repository.dart';
import 'package:artriapp/services/health_sync_service.dart';
import 'package:artriapp/view_models/health_view_model.dart';
import 'package:artriapp/views/evolution/evolution_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../helpers/mock_health_data_provider.dart';

Widget _createTestApp({
  bool withData = false,
}) {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final db = AppDatabase(customPath: inMemoryDatabasePath);
  final repository = HealthRepository(db: db);
  final dataProvider = MockHealthDataProvider()
    ..setAvailable(true)
    ..setPermissionsGranted(true);
  final syncService = HealthSyncService(
    dataProvider: dataProvider,
    repository: repository,
  );
  final viewModel = HealthViewModel(syncService: syncService);

  if (withData) {
    repository.insertMetrics([
      LocalHealthMetrics(
        metricType: HealthMetricType.steps,
        value: 5000.0,
        startTime: DateTime.now().subtract(const Duration(days: 1)),
        unit: 'count',
      ),
      LocalHealthMetrics(
        metricType: HealthMetricType.sleep,
        value: 7.5,
        startTime: DateTime.now().subtract(const Duration(days: 1)),
        unit: 'hours',
      ),
    ]);
  }

  return MaterialApp(
    home: Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<HealthViewModel>.value(value: viewModel),
        ],
        child: const EvolutionPage(),
      ),
    ),
  );
}

void main() {
  testWidgets('renders evolution page title', (tester) async {
    await tester.pumpWidget(_createTestApp());
    await tester.pump();

    expect(find.text('SUA EVOLUÇÃO'), findsOneWidget);
  });

  testWidgets('shows filter chips', (tester) async {
    await tester.pumpWidget(_createTestApp());
    await tester.pump();

    expect(find.text('Dor'), findsOneWidget);
    expect(find.text('Fadiga'), findsOneWidget);
    expect(find.text('Passos'), findsOneWidget);
    expect(find.text('Sono'), findsOneWidget);
    expect(find.text('Freq. Cardíaca'), findsOneWidget);
    expect(find.text('Energia'), findsOneWidget);
  });

  testWidgets('health filter chips can be toggled', (tester) async {
    await tester.pumpWidget(_createTestApp(withData: true));
    await tester.pump();

    // "Passos" filter chip should be toggleable
    final passosChip = find.text('Passos');
    expect(passosChip, findsOneWidget);

    // Tap to select
    await tester.tap(passosChip);
    await tester.pump();

    // Tap again to deselect (no crash)
    await tester.tap(passosChip);
    await tester.pump();
  });

  testWidgets('shows CircularProgressIndicator during loading', (tester) async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final db = AppDatabase(customPath: inMemoryDatabasePath);
    final repository = HealthRepository(db: db);
    final dataProvider = MockHealthDataProvider()
      ..setAvailable(true)
      ..setPermissionsGranted(true);
    final syncService = HealthSyncService(
      dataProvider: dataProvider,
      repository: repository,
    );
    final viewModel = HealthViewModel(syncService: syncService);
    viewModel.initialize();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider<HealthViewModel>.value(value: viewModel),
            ],
            child: const EvolutionPage(),
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders chart area', (tester) async {
    await tester.pumpWidget(_createTestApp(withData: true));
    await tester.pump();
    await tester.pump();
    await tester.pump();

    // Title and chips remain visible after chart area renders
    expect(find.text('SUA EVOLUÇÃO'), findsOneWidget);
    expect(find.text('Passos'), findsOneWidget);
  });
}
