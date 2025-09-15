import 'package:artriapp/services/index.dart';
import 'package:artriapp/utils/providers/index.dart';
import 'package:artriapp/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData(textTheme: GoogleFonts.jetBrainsMonoTextTheme());

    return MultiProvider(
      providers: GlobalProviders.getProviders(),
      child: MaterialApp(
        routes: Routes.getRoutes(),
        title: 'ArtriApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        initialRoute: SecurityTokenService().userLoggedIn()
            ? Routes.loggedPage
            : Routes.login,
      ),
    );
  }
}
