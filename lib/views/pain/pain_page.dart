import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class PainPage extends StatefulWidget {
  const PainPage({super.key});

  @override
  State<PainPage> createState() => _PainPageState();
}

class _PainPageState extends State<PainPage> {
  List<String> selecionados = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            onPressed: () => {},
            iconSize: 40,
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.darkGreen,
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
                    'Olá, Andressa!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 52,
                      color: AppColors.darkGreen,
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
                  const Gap(52),
                  const ScaleSelector(
                    label: 'Dor',
                  ),
                  const Gap(52),
                  Text(
                    'REMÉDIOS',
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      color: const Color(0xff026873),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.85,
                    child: Container(
                      decoration: BoxDecoration(
                        border: const CustomBoxBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                        // Border.all(
                        //   color: const Color(0xff0058aa),
                        //   width: 2,
                        // ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DIPIRONA 22:00H',
                                    style: GoogleFonts.montserrat(
                                      color: AppColors.darkGreen,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'IBUPROFENO 10:00H',
                                    style: GoogleFonts.montserrat(
                                      color: AppColors.darkGreen,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.edit_outlined,
                              size: 42,
                              color: Color(0xff525252),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
