import 'package:artriapp/utils/enums/index.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class CustomRoutineLevelSelectPage extends StatelessWidget {
  const CustomRoutineLevelSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenHelper.getScreenWidth(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 40,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Escolha um nível de dificuldade para iniciar os exercícios personalizados:',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 24,
                color: AppColors.darkGreen,
              ),
            ),
          ),
          ExerciseButton(
            onClick: () => context.push('/custom_routine/overview/iniciante'),
            side: ExerciseButtonSide.left,
            buttonText: 'Iniciante',
            color: AppColors.neutral,
            width: screenWidth * 0.65,
          ),
          ExerciseButton(
            onClick: () => context.push('/custom_routine/overview/intermediario'),
            side: ExerciseButtonSide.left,
            buttonText: 'Intermediário',
            color: AppColors.neutral,
            width: screenWidth * 0.65,
          ),
          ExerciseButton(
            onClick: () => context.push('/custom_routine/overview/avancado'),
            buttonText: 'Avançado',
            color: AppColors.neutral,
            side: ExerciseButtonSide.left,
            width: screenWidth * 0.65,
          ),
          CustomSolidButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const LevelSelectorDialog(),
            ),
            text: 'Qual devo escolher?',
            color: AppColors.lightBrown,
            width: screenWidth * 0.80,
            textStyle: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
