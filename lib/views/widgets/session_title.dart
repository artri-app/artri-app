import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double? size;
  const SessionTitle({
    super.key,
    required this.title,
    this.size = 28,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title.toUpperCase(),
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.visible,
          style: GoogleFonts.montserrat(
            fontSize: size,
            height: 1.25,
            color: AppColors.darkGreen,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle!.toUpperCase(),
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: GoogleFonts.montserrat(
              fontSize: size! * 0.70,
              height: 1.25,
              color: AppColors.mediumGreen,
            ),
          ),
      ],
    );
  }
}
