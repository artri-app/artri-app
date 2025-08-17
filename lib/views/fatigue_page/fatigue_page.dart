import 'package:artriapp/views/widgets/checkboxList.dart';
import 'package:artriapp/views/widgets/navbar.dart';
import 'package:artriapp/views/widgets/painScaleSelector.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FatiguePage extends StatefulWidget {
  const FatiguePage({super.key});

  @override
  State<FatiguePage> createState() => _FatgiuePageState();
}

class _FatgiuePageState extends State<FatiguePage> {
  List<String> selecionados = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () => {},
              iconSize: 40,
              icon: const Icon(
                Icons.settings_outlined,
                color: Color(0xff025940),
              ),
            ),
          ),
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
                        fontSize: 52,
                        color: const Color(0xff025940),
                      ),
                    ),
                    Text(
                      'Como você está hoje?'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(40),
                    Text(
                      'Fadiga'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 52,
                        color: const Color(0xff025940),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'De 0 a 10, como esta seu nível de fadiga hoje?'
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    PainScaleSelectorWidget(
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
