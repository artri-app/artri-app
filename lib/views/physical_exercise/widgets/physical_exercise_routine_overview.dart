import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/physical_exercise/widgets/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PhysicalExerciseRoutineOverview extends StatelessWidget {
  const PhysicalExerciseRoutineOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).uri.path;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        Text(
          'Você levará aproximadamente x minutos para realizar os exercícios',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 22,
            color: AppColors.darkGreen,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Scrollbar(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: 30,
              itemBuilder: (context, index) => ExerciseTile(
                exerciseName: 'aaaa',
              ),
            ),
          ),
        ),
        CustomSolidButton(
          text: 'Começar'.toUpperCase(),
          onPressed: () => context.go('$currentPath/0'),
          gradientColors: AppGradients.greenGradient,
          textStyle: GoogleFonts.montserrat(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
