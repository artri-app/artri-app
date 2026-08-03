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
            onPressed: () {
              // Dialog com a explicação adicionado
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('O que é Dor?'),
                    content: const Text(
                        'A dor é avaliada em uma escala de intensidade para acompanharmos a evolução do seu tratamento e alívio dos sintomas.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Entendi'),
                      ),
                    ],
                  );
                },
              );
            },
            iconSize: 40,
            icon: const Icon(
              Icons.help_outline, // Ícone trocado para "?"
              color: AppColors.darkGreen,
            ),
          ),
        ),
        Center(
          // Scroll inserido aqui para a escala de 0 a 10 ter espaço
          child: SingleChildScrollView(
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
                              Column(
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
                              const Icon(
                                Icons.edit_outlined,
                                size: 42,
                                color: Color(0xff525252),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(32),
                    // Botões de ação
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Voltar',
                            style: GoogleFonts.montserrat(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Salvar',
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}