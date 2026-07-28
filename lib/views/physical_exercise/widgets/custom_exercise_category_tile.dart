import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomExerciseCategoryTile extends StatelessWidget {
  final String prefixText;
  final String categoryName;
  final VoidCallback onEdit;

  const CustomExerciseCategoryTile({
    super.key,
    required this.prefixText,
    required this.categoryName,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        GestureDetector(
          onTap: onEdit,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.darkGreen),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.edit_outlined,
              color: AppColors.darkGreen,
              size: 22,
            ),
          ),
        ),
        Flexible(
          child: Text.rich(
            TextSpan(
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: AppColors.darkGreen,
                ),
              ),
              children: [
                TextSpan(text: '$prefixText '),
                TextSpan(
                  text: categoryName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
