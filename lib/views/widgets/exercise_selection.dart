import 'package:artriapp/models/api_responses/exercise.dart';
import 'package:artriapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseSelection extends StatelessWidget {
  final Exercise exercise;
  final bool selected;
  final Function onClick;
  const ExerciseSelection({required this.exercise, required this.onClick, required this.selected, super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: AppColors.lightBrown,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 40,
          ),
        ),
            SizedBox(width: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width - 164,
              child: Text(exercise.name,
                style: GoogleFonts.montserrat(fontSize: 22, color: AppColors.darkGreen),
              ),
            ),
            Transform.scale(
              scale: 1.5,
              child: Checkbox(
                activeColor: AppColors.darkGreen,
                value: selected,
                onChanged: (value) {
                  onClick();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}