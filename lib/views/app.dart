import 'package:artriapp/services/auth_service.dart';
import 'package:artriapp/view_models/login_view_model.dart';
import 'package:artriapp/views/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData(textTheme: GoogleFonts.jetBrainsMonoTextTheme());

    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthService()),
        ChangeNotifierProvider(
            create: (context) => LoginViewModel(
                Provider.of<AuthService>(context, listen: false)))
      ],
      child: MaterialApp(
        title: 'ArtriApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        home: const LoginPage(title: 'ArtriApp'),
      ),
    );
  }
}
