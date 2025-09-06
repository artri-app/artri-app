import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artriapp/views/login/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData(textTheme: GoogleFonts.jetBrainsMonoTextTheme());

    return MaterialApp(
      title: 'ArtriApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
