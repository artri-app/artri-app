import 'package:artriapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectExercisesCard extends StatelessWidget {
  final String text;
  const SelectExercisesCard({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    List<String> splitText = text.split(" ");
    String normalText = '${splitText[0]} ';
    String boldText = splitText.last;

    for (int i = 1; i < splitText.length - 1; i++) {
      normalText = '$normalText${splitText[i]} ';
    }

    return Flexible(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit_square, size: 64, color: AppColors.lightBrown,),
              SizedBox(width: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width - 128,
                child: Text.rich(
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: normalText,
                        style: GoogleFonts.montserrat(fontSize: 22, color: AppColors.darkGreen),
                      ),
                      TextSpan(
                        text: boldText,
                        style: GoogleFonts.montserrat(fontSize: 22, color: AppColors.darkGreen, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}