import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomExerciseSelectableTile extends StatelessWidget {
  final String exerciseName;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  const CustomExerciseSelectableTile({
    super.key,
    required this.exerciseName,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      child: Row(
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
          Expanded(
            child: Text(
              exerciseName,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: AppColors.darkGreen,
                ),
              ),
            ),
          ),
          Checkbox(
            value: isSelected,
            onChanged: (value) => onChanged(value ?? false),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: const BorderSide(color: AppColors.darkGreen, width: 2),
            activeColor: AppColors.mediumGreen,
          ),
        ],
      ),
    );
  }
}
