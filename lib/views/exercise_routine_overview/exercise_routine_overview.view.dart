import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/exercise_routine_overview/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseRoutineOverviewView extends StatelessWidget {
  const ExerciseRoutineOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
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
        )
      ],
    );
  }
}
