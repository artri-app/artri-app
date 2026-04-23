import 'package:artriapp/services/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:artriapp/view_models/remedy_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class GlobalProviders {
  final _serviceProviders = <SingleChildWidget>[
    Provider(create: (context) => AuthService()),
    Provider(create: (context) => SecurityTokenService()),
  ];

  final _viewModelProviders = <SingleChildWidget>[
    ChangeNotifierProvider(
      create: (context) => LoginViewModel(
        Provider.of<AuthService>(context, listen: false),
        Provider.of<SecurityTokenService>(context, listen: false),
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => RemedyViewModel(),
    ),
  ];

  static List<SingleChildWidget> getProviders() {
    return GlobalProviders()
        ._serviceProviders
        .followedBy(GlobalProviders()._viewModelProviders)
        .toList();
  }
}
