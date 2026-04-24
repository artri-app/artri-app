import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  const ExerciseTile({super.key, required this.exerciseName});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Row(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: width * 0.15,
          width: width * 0.15,
          decoration: BoxDecoration(
            color: AppColors.lightBrown,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: width * 0.1,
          ),
        ),
        Text(
          exerciseName,
          style: GoogleFonts.montserrat(fontSize: 32),
        ),
      ],
    );
  }
}
