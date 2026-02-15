import 'package:artriapp/views/widgets/index.dart';
import 'package:flutter/material.dart';

class TypePhysicalExercise extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const TypePhysicalExercise({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SessionTitle(
          title: title,
          size: 36,
          subtitle: subtitle,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: child,
        ),
      ],
    );
  }
}
