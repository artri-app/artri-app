import 'package:artriapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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

  // Extracts the YouTube video ID from the URL and constructs the thumbnail URL.
  String _getThumbnail(String url) {
    final videoId =
        YoutubePlayerController.convertUrlToId(url) ?? '';
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

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
                _getThumbnail(videoUrl),
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