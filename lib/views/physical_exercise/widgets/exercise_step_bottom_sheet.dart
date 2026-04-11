import 'package:artriapp/utils/index.dart';
import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseStepBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        color: AppColors.lightBrown,
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 52,
              color: AppColors.darkGreen,
              onPressed: () => {},
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
              ),
            ),
            Expanded(
              child: CustomOutlinedButton(
                color: AppColors.darkGreen,
                text: 'Feito',
                onPressed: () => {},
                borderWidth: 4,
                textStyle: GoogleFonts.montserrat(
                  color: AppColors.darkGreen,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              iconSize: 52,
              color: AppColors.darkGreen,
              onPressed: () => {},
              icon: const Icon(
                Icons.arrow_circle_right_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
