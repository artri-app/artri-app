import 'package:flutter/material.dart';

class FadeButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double elevation;

  const FadeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width = 160,
    this.height = 48,
    this.elevation = 4, // Default elevation value
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation,
      shadowColor: Colors.grey.withAlpha(153),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(height / 2),
        right: Radius.circular(height / 2),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(height / 2),
          right: Radius.circular(height / 2),
        ),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(height / 2),
              right: Radius.circular(height / 2),
            ),
            border: Border.all(
              color: const Color(0xff026873),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff026873),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
