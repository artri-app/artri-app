import 'package:artriapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RelaxationTile extends StatelessWidget {
  final String audioName;
  final VoidCallback? onTap;

  const RelaxationTile({
    super.key,
    required this.audioName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.spa),
        title: Text(
          audioName,
          style: GoogleFonts.montserrat(
            fontSize: 18,
            color: AppColors.darkGreen,
          ),
        ),
        trailing: const Icon(Icons.play_arrow),
        onTap: onTap,
      ),
    );
  }
}