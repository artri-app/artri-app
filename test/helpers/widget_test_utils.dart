import 'package:artriapp/database/app_database.dart';
import 'package:artriapp/repositories/health_repository.dart';
import 'package:artriapp/services/health_sync_service.dart';
import 'package:artriapp/view_models/health_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'mock_health_data_provider.dart';

Widget createTestApp({
  required Widget child,
  bool healthAvailable = true,
  bool permissionsGranted = false,
}) {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final db = AppDatabase(customPath: inMemoryDatabasePath);
  final repository = HealthRepository(db: db);
  final dataProvider = MockHealthDataProvider()
    ..setAvailable(healthAvailable)
    ..setPermissionsGranted(permissionsGranted);
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
        child: Material(child: child),
      ),
    ),
  );
}
