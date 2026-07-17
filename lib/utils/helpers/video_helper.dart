import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoHelper {
  static String getYoutubeVideoThumbnail(String videoUrl) {
    final videoId = YoutubePlayerController.convertUrlToId(videoUrl) ?? '';
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  static String getYoutubeVideoId(String url) {
    return YoutubePlayerController.convertUrlToId(url) ?? '';
  }
}
