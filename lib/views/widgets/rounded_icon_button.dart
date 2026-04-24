import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RoundedButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const RoundedButton({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            minimumSize: const Size(64, 64), // Fixed size
            shape: const CircleBorder(), // Circular shape
            padding: const EdgeInsets.all(16), // Adjust padding for icon size
          ),
          child: Icon(icon, size: 46, color: Colors.white), // Centered icon
        ),
        const Gap(4), // Space between icon and label
        Text(
          label,
          style: TextStyle(fontSize: 14, color: color),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
