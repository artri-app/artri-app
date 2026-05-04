import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:artriapp/views/widgets/video_player.dart';

/* o que faz:
✔ já cria layout padrão
✔ já coloca vídeo
✔ já coloca scroll
✔ só mandar o conteúdo
*/

class InfoTemplatePage extends StatelessWidget {
  final String title;
  final String videoUrl;
  final List<Widget> sections;

  const InfoTemplatePage({
    super.key,
    required this.title,
    required this.videoUrl,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoPlayerWidget(videoUrl: videoUrl),

              const Gap(24),

              ...sections,

              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }
}