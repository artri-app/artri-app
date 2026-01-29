import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelExerciseSelector extends StatelessWidget {
  const LevelExerciseSelector({super.key});

  static const whichLevelDialog = SimpleDialog(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.priority_high),
        Text('ATENÇÃO'),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 40,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
          onClick: () => {},
          buttonText: 'Avançado',
          color: AppColors.neutral,
          side: ExerciseButtonSide.left,
          width: screenWidth * 0.65,
        ),
        CustomButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => whichLevelDialog,
          ),
          text: 'Qual devo escolher?',
          color: AppColors.lightBrown,
          width: screenWidth * 0.80,
          textColor: Colors.black,
        ),
      ],
    );
  }
}
