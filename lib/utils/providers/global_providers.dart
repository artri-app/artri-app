import 'package:artriapp/services/index.dart';
import 'package:artriapp/view_models/diary_view_model.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class GlobalProviders {
  final _serviceProviders = <SingleChildWidget>[
    Provider(create: (context) => AuthService()),
    Provider(create: (context) => SecurityTokenService()),
    Provider(create: (context) => PhysicalExercisesService()),
    Provider(create: (context) => NotificationService.instance),
    Provider(create: (context) => RemedyService()),
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
      create: (context) => RemedyViewModel(
        notificationService: Provider.of<NotificationService>(context, listen: false),
        remedyService: Provider.of<RemedyService>(context, listen: false),
      ),
    ),
    ChangeNotifierProvider(create: (_) => DiaryViewModel()),
  ];

  static List<SingleChildWidget> getProviders() {
    return GlobalProviders()
        ._serviceProviders
        .followedBy(GlobalProviders()._viewModelProviders)
        .toList();
  }
}