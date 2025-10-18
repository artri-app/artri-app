import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionTitle extends StatelessWidget {
  final String title;
  final double? size;
  const SessionTitle({
    super.key,
    required this.title,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        fontSize: size,
        color: AppColors.darkGreen,
      ),
    );
  }
}
