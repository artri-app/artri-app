import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TypePhysicalExerciseView extends StatelessWidget {
  final String title;

  const TypePhysicalExerciseView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClearScaffoldView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 48,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SessionTitle(
              title: title,
              size: 36,
            ),
            Text(
              'Escolha um nível de dificuldade para iniciar os exercícios:',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 24,
                  color: AppColors.darkGreen,
                ),
              ),
            ),
            ExerciseButton(
              onClick: () => const {},
              side: ExerciseButtonSide.left,
              buttonText: 'Iniciante',
              color: AppColors.neutral,
              width: screenWidth * 0.65,
            ),
            ExerciseButton(
              onClick: () => const {},
              side: ExerciseButtonSide.left,
              buttonText: 'Intermediário',
              color: AppColors.neutral,
              width: screenWidth * 0.65,
            ),
            ExerciseButton(
              onClick: () => context.go(
                AppRoutes.exerciseRoutineStep
                    .replaceFirst(':id', 'advanced_$title'),
              ),
              buttonText: 'Avançado',
              color: AppColors.neutral,
              side: ExerciseButtonSide.left,
              width: screenWidth * 0.65,
            ),
          ],
        ),
      ),
    );
  }
}
