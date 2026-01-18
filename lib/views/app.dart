import 'package:artriapp/routes/index.dart';
import 'package:artriapp/services/index.dart';
import 'package:artriapp/utils/providers/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  App({super.key});
  final _router = GoRouter(
    initialLocation: SecurityTokenService().userLoggedIn()
        ? LoggedRoutes.diary
        : NotLoggedRoutes.login,
    routes: AppRoutes.getGoRoutes(),
  );

  @override
  Widget build(BuildContext context) {
    ThemeData(textTheme: GoogleFonts.jetBrainsMonoTextTheme());

    return MultiProvider(
      providers: GlobalProviders.getProviders(),
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'ArtriApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
      ),
    );
  }
}
