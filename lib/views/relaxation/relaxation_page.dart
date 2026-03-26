//import 'package:artriapp/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RelaxationPage extends StatelessWidget {
  const RelaxationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClearScaffoldView(
      child: Column(
        spacing: 32,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SessionTitle(
            title: 'RELAXAMENTO',
            size: 36,
          ),
          Text(
            'Aqui você terá acesso a técnicas de relaxamento guiado por meio de áudios e técnicas de respiração que poderão te ajudar a relaxar. Clique e experimente:',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 24,
                color: AppColors.darkGreen,
              ),
            ),
          ),
          ExerciseButton(
            onClick: () => context.go('/relaxation/guided'),
            gradientColors: AppGradients.greenToNeutral,
            buttonText: 'Relaxamento guiado',
          ),
          ExerciseButton(
            onClick: () => context.go('/relaxation/breathing'),
            gradientColors: AppGradients.greenToNeutral,
            buttonText: 'Técnicas de respiração',
          ),
        ],
      ),
    );
  }
}