import 'package:artriapp/database/app_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

var _counter = 0;

Future<AppDatabase> createTestDatabase() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  _counter++;
  final path = '$_counter';
  return AppDatabase(customPath: path);
}

Future<void> destroyTestDatabase(AppDatabase db) async {
  await db.close();
}
