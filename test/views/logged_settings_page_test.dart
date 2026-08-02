import 'package:artriapp/database/app_database.dart';
import 'package:artriapp/repositories/health_repository.dart';
import 'package:artriapp/services/health_sync_service.dart';
import 'package:artriapp/view_models/health_view_model.dart';
import 'package:artriapp/views/logged_settings/logged_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../helpers/mock_health_data_provider.dart';

Widget _createTestApp() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final db = AppDatabase(customPath: inMemoryDatabasePath);
  final repository = HealthRepository(db: db);
  final dataProvider = MockHealthDataProvider()
    ..setAvailable(true)
    ..setPermissionsGranted(false);
  final syncService = HealthSyncService(
    dataProvider: dataProvider,
    repository: repository,
  );
  final viewModel = HealthViewModel(syncService: syncService);

  return MaterialApp(
    home: Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<HealthViewModel>.value(value: viewModel),
        ],
        child: const LoggedSettingsPage(),
      ),
    ),
  );
}

void main() {
  testWidgets('renders settings page title and buttons', (tester) async {
    await tester.pumpWidget(_createTestApp());
    await tester.pump();

    expect(find.text('Configurações'), findsOneWidget);
    expect(find.text('Alterar Email'), findsOneWidget);
    expect(find.text('Alterar Senha'), findsOneWidget);
    expect(find.text('Conectar Smartwatch / Health Connect'), findsOneWidget);
  });

  testWidgets('shows health connect button', (tester) async {
    await tester.pumpWidget(_createTestApp());
    await tester.pump();

    expect(find.text('Conectar Smartwatch / Health Connect'), findsOneWidget);
  });

  testWidgets('shows install button when health connect not available', (tester) async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final db = AppDatabase(customPath: inMemoryDatabasePath);
    final repository = HealthRepository(db: db);
    final dataProvider = MockHealthDataProvider()
      ..setAvailable(false)
      ..setPermissionsGranted(false);
    final syncService = HealthSyncService(
      dataProvider: dataProvider,
      repository: repository,
    );
    final viewModel = HealthViewModel(syncService: syncService);

    // Set error directly on viewModel before building widget
    viewModel.initialize();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider<HealthViewModel>.value(value: viewModel),
            ],
            child: const LoggedSettingsPage(),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(
      find.text('Instalar Health Connect'),
      findsOneWidget,
    );
  });
}
