import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';

class TypePhysicalExercise extends StatelessWidget {
  final String title;
  final Widget child;

  const TypePhysicalExercise({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 48,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SessionTitle(
          title: title,
          size: 36,
        ),
        child,
      ],
    );
  }
}
