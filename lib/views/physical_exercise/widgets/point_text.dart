import 'package:artriapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PointText extends StatelessWidget {
  final String text;
  final String? strongText;
  const PointText({required this.text, this.strongText, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, left: 16, right: 12),
          child: const SizedBox(
            height: 8,
            width: 8,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: (strongText == null) ? Text(
            text,
            textAlign: TextAlign.justify,
            style: GoogleFonts.montserrat(
              fontSize: 20,
            ),
          ) : Text.rich(
            textAlign: TextAlign.justify,
            TextSpan(
              children: [
                TextSpan(
                  text: text,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                  text: strongText,
                  style: GoogleFonts.montserrat(fontSize: 20, color: AppColors.importantTextYellow),
                ),
              ],
            ),
          ),
        ),
      ],);
  }
}