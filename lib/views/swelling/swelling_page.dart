import 'package:artriapp/views/config/config_page.dart';
import 'package:artriapp/views/widgets/navbar.dart';
import 'package:artriapp/views/widgets/custom_scale_selector.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SwellingPage extends StatefulWidget {
  const SwellingPage({super.key});

  @override
  State<SwellingPage> createState() => _SwellingPageState();
}

class _SwellingPageState extends State<SwellingPage> {
  List<String> selecionados = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ConfigPage()),
            ),
            icon: const Icon(
              Icons.settings,
              color: Color(0xff025940),
              size: 30,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.85,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xff025940),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 110,
                      ),
                    ),
                    const Gap(46),
                    Text(
                      'Olá, Usuário!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        color: const Color(0xff025940),
                      ),
                    ),
                    Text(
                      'Como você está hoje?'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(40),
                    Text(
                      'Inchaço'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        color: const Color(0xff025940),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Local do inchaço:'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'De 0 a 10, qual o nível de inchaço nas mãos?'
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    CustomScaleSelectorWidget(
                      label: 'Inchaço',
                      onChanged: (value) {
                        print('Valor selecionado: $value');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
