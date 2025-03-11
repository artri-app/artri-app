import 'package:artriapp/views/menu/widgets/checkboxList.dart';
import 'package:artriapp/views/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
                      'Dor'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 52,
                        color: const Color(0xff025940),
                      ),
                    ),
                    Text(
                      'Local da Dor:'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    CheckboxGroup(
                      onChanged: (List<String> selecionados) {
                        setState(() {
                          this.selecionados = selecionados;
                        });
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
