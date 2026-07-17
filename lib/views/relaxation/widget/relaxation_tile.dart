import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/utils/helpers/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RelaxationTile extends StatelessWidget {
  final String title;
  final String videoUrl;
  final VoidCallback? onTap;

  const RelaxationTile({
    super.key,
    required this.title,
    required this.videoUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // 🎬 THUMBNAIL
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: Image.network(
                VideoHelper.getYoutubeVideoThumbnail(videoUrl),
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 16),

            // 📝 TEXTO
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: AppColors.darkGreen,
                ),
              ),
            ),

            const Icon(Icons.play_arrow),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
