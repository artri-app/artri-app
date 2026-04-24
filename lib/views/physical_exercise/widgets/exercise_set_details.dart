import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseSetDetails extends StatelessWidget {
  const ExerciseSetDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      constraints: BoxConstraints(
        minHeight: 180,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkGreenSurface,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Instruções/Observações:',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              color: AppColors.darkGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Faça o exercício devagar, controlando o movimento e a respiração. Mantenha a postura correta para evitar lesões.',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
