import 'package:artriapp/services/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/view_models/remedy_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:artriapp/view_models/diary_view_model.dart';

class GlobalProviders {
  final NotificationService notificationService;

  GlobalProviders(this.notificationService);

  List<SingleChildWidget> get _serviceProviders => <SingleChildWidget>[
        Provider(create: (context) => AuthService()),
        Provider(create: (context) => SecurityTokenService()),
        Provider(create: (context) => PhysicalExercisesService()),
        Provider.value(value: notificationService),
        Provider(
          create: (context) => RemedyService(
            Provider.of<SecurityTokenService>(context, listen: false),
            Provider.of<AuthService>(context, listen: false),
          ),
        ),
      ];

  List<SingleChildWidget> get _viewModelProviders => <SingleChildWidget>[
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
          create: (context) => RemedyViewModel(
            Provider.of<RemedyService>(context, listen: false),
            Provider.of<NotificationService>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(create: (_) => DiaryViewModel()),
      ];

  static List<SingleChildWidget> getProviders(
    NotificationService notificationService,
  ) {
    final instance = GlobalProviders(notificationService);
    return instance._serviceProviders
        .followedBy(instance._viewModelProviders)
        .toList();
  }
}
