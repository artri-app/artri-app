import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseSetProperties extends StatelessWidget {
  const ExerciseSetProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      constraints: BoxConstraints(
        minHeight: 60,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutral,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                'Séries: 3',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Repetições: 12',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Descanso: 60s',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
