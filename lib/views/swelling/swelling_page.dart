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
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            onPressed: () {
              // Dialog explicativo
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('O que é Inchaço?'),
                    content: const Text(
                        'O inchaço (edema) é o acúmulo de líquidos nas articulações, comum em crises de artrite. Indique a área afetada e a intensidade.'),
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
              Icons.help_outline, // Ícone trocado
              color: AppColors.darkGreen,
            ),
          ),
        ),
        Center(
          // Scroll inserido aqui
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
                    const SizedBox(height: 16),
                    Text(
                      'Local do inchaço:'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'De 0 a 10, qual o nível de inchaço nas mãos?'
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    CustomScaleSelectorWidget(
                      onChanged: (value) {
                        print('Valor selecionado: $value');
                      },
                    ),
                    const Gap(32),
                    // Botões de navegação adicionados
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