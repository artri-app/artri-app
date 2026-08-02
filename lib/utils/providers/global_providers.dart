import 'package:artriapp/database/app_database.dart';
import 'package:artriapp/repositories/health_repository.dart';
import 'package:artriapp/services/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/view_models/remedy_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:artriapp/view_models/diary_view_model.dart';

class GlobalProviders {
  final _serviceProviders = <SingleChildWidget>[
    Provider(create: (context) => AuthService()),
    Provider(create: (context) => SecurityTokenService()),
    Provider(create: (context) => PhysicalExercisesService()),
    Provider(create: (_) => AppDatabase()),
    Provider(
      create: (context) => HealthRepository(
        db: Provider.of<AppDatabase>(context, listen: false),
      ),
    ),
    Provider(
      create: (_) => HealthDataProvider() as IHealthDataProvider,
    ),
    Provider(
      create: (context) => HealthSyncService(
        dataProvider: Provider.of<IHealthDataProvider>(context, listen: false),
        repository: Provider.of<HealthRepository>(context, listen: false),
      ),
    ),
  ];

  final _viewModelProviders = <SingleChildWidget>[
    ChangeNotifierProvider(
      create: (context) => LoginViewModel(
        Provider.of<AuthService>(context, listen: false),
        Provider.of<SecurityTokenService>(context, listen: false),
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => PhysicalExercisesViewModel(
        Provider.of<PhysicalExercisesService>(context, listen: false),
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => RemedyViewModel(),
    ),
    ChangeNotifierProvider(create: (_) => DiaryViewModel()),
    ChangeNotifierProvider(
      create: (context) => HealthViewModel(
        syncService: Provider.of<HealthSyncService>(context, listen: false),
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => CustomRoutineViewModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => CustomRoutineAdvancedViewModel(),
    ),
  ];

  static List<SingleChildWidget> getProviders() {
    return GlobalProviders()
        ._serviceProviders
        .followedBy(GlobalProviders()._viewModelProviders)
        .toList();
  }
}
