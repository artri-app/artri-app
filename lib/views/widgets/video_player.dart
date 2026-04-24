import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// Web
import 'package:youtube_player_iframe/youtube_player_iframe.dart' as iframe;

// Mobile
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as mobile;

// this widget is used to play youtube videos in the app, it should work for both web and mobile

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  dynamic _controller;

  @override
  void initState() {
    super.initState();

    final videoId = _getVideoId(widget.videoUrl);

    if (kIsWeb) {
      _controller = iframe.YoutubePlayerController.fromVideoId(
        videoId: videoId,
        params: const iframe.YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      );
    } else {
      _controller = mobile.YoutubePlayerController(
        initialVideoId: videoId,
        flags: const mobile.YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }
  }

  String _getVideoId(String url) {
    return mobile.YoutubePlayer.convertUrlToId(url) ??
        iframe.YoutubePlayerController.convertUrlToId(url) ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: kIsWeb
          ? iframe.YoutubePlayer(
              controller: _controller,
            )
          : mobile.YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
    );
  }
}