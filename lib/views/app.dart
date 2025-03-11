import 'package:artriapp/views/home_page/home_page.dart';
import 'package:artriapp/views/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      home: const Menu(),
    );
  }
}
