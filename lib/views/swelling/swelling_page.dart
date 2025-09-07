import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
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
    return Stack(
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
                      color: AppColors.darkGreen,
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
                      color: AppColors.darkGreen,
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
                      color: AppColors.darkGreen,
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
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     actions: [
    //       IconButton(
    //         onPressed: () => Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) => const ConfigPage()),
    //         ),
    //         icon: const Icon(
    //           Icons.settings,
    //           color: AppColors.darkGreen,
    //           size: 30,
    //         ),
    //       ),
    //     ],
    //   ),
    //   bottomNavigationBar: const NavBar(),
    // );
  }
}
