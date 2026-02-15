import 'package:artriapp/views/index.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseRoutineStepView extends StatelessWidget {
  final int exerciseId;
  const ExerciseRoutineStepView({super.key, required this.exerciseId});

  @override
  Widget build(BuildContext context) {
    var videoController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
            'https://www.youtube.com/watch?v=IxX_QHay02M',
          ) ??
          'IxX_QHay02M',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: true,
      ),
    );

    return Column(
      spacing: 16,
      children: [
        YoutubePlayer(controller: videoController),
        SessionTitle(title: 'Nome exercício'),
        ExerciseSetProperties(),
        ExerciseSetDetails(),
      ],
    );
  }
}
