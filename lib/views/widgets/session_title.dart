import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionTitle extends StatelessWidget {
  final String title;
  const SessionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        fontSize: 28,
        color: AppColors.darkGreen,
      ),
    );
  }
}
