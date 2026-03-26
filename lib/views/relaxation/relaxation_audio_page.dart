import 'package:artriapp/views/widgets/clear_scaffold_view.dart';
import 'package:artriapp/views/widgets/session_title.dart';
import 'package:flutter/material.dart';

class RelaxationAudioPage extends StatelessWidget {
  final String audioName;

  const RelaxationAudioPage({
    super.key,
    required this.audioName,
  });

  @override
  Widget build(BuildContext context) {
    return ClearScaffoldView(
      child: Column(
        spacing: 32,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SessionTitle(
            title: audioName,
            size: 36,
          ),
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.image,
              size: 120,
            ),
          ),
        ],
      ),
    );
  }
}