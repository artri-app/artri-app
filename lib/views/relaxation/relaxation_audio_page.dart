import 'package:artriapp/models/api_responses/exercise.dart';
import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/views/widgets/clear_scaffold_view.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:artriapp/views/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class RelaxationAudioPage extends StatelessWidget {
  final Exercise exercise;

  const RelaxationAudioPage({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return ClearScaffoldView(
      child: Column(
        spacing: 32,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SessionTitle(
            title: exercise.name,
            size: 36,
          ),

          // 🎬 PLAYER REUTILIZÁVEL
          VideoPlayerWidget(
            videoUrl: exercise.link,
          ),

          Text(
            exercise.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppColors.darkGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}