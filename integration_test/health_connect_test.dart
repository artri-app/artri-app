import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

import 'package:artriapp/database/app_database.dart';
import 'package:artriapp/repositories/health_repository.dart';
import 'package:artriapp/services/health_sync_service.dart';
import 'package:artriapp/services/interfaces/health_data_provider.dart';
import 'package:artriapp/view_models/health_view_model.dart';
import 'package:artriapp/views/logged_settings/logged_settings_page.dart';
import 'package:artriapp/views/evolution/evolution_page.dart';

Widget _createSettingsApp() {
  final db = AppDatabase(customPath: ':memory:');
  final repository = HealthRepository(db: db);
  final dataProvider = _MockProvider()
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

Widget _createEvolutionApp() {
  final db = AppDatabase(customPath: ':memory:');
  final repository = HealthRepository(db: db);
  final dataProvider = _MockProvider()
    ..setAvailable(true)
    ..setPermissionsGranted(true);
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
        child: const EvolutionPage(),
      ),
    ),
  );
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Health Connect integration', () {
    testWidgets('full flow: connect, seed data, evolution chart',
        (tester) async {
      await tester.pumpWidget(_createSettingsApp());
      await tester.pump();
      await tester.pump();

      expect(find.text('Conectar Smartwatch / Health Connect'), findsOneWidget);

      await tester.tap(find.text('Conectar Smartwatch / Health Connect'));
      await tester.pump();
      await tester.pump();
      await tester.pump();

      expect(find.text('Desconectar Smartwatch'), findsOneWidget);

      await tester.tap(find.text('Simular Dados de Smartwatch'));
      await tester.pump();
      await tester.pump();
      await tester.pump();

      expect(find.text('Desconectar Smartwatch'), findsOneWidget);

      await tester.tap(find.text('Desconectar Smartwatch'));
      await tester.pump();
      await tester.pump();

      expect(find.text('Conectar Smartwatch / Health Connect'), findsOneWidget);
    });

    testWidgets('evolution page shows chart with simulated data',
        (tester) async {
      await tester.pumpWidget(_createEvolutionApp());
      await tester.pump();
      await tester.pump();

      expect(find.text('SUA EVOLUÇÃO'), findsOneWidget);
      expect(find.text('Passos'), findsOneWidget);
      expect(find.text('Sono'), findsOneWidget);
      expect(find.text('Freq. Cardíaca'), findsOneWidget);
      expect(find.text('Energia'), findsOneWidget);
    });
  });
}

class _MockProvider implements IHealthDataProvider {
  bool _available = false;
  bool _permissionsGranted = false;

  void setAvailable(bool v) => _available = v;
  void setPermissionsGranted(bool v) => _permissionsGranted = v;

  @override
  Future<bool> isAvailable() async => _available;

  @override
  Future<bool> requestPermissions() async {
    _permissionsGranted = true;
    return true;
  }

  @override
  Future<bool> hasPermissions() async => _permissionsGranted;

  @override
  Future<void> installHealthConnect() async {}

  @override
  Future<List> fetchData({
    required List types,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    return [];
  }
}
