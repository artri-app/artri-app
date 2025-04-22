import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const RoundedButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
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
            shape: const CircleBorder(), // Circular shape
            padding: const EdgeInsets.all(16), // Adjust padding for icon size
          ),
          child: Icon(icon, size: 24, color: Colors.white), // Centered icon
        ),
        // const SizedBox(height: 8), // Space between icon and label
        Text(
          label,
          style: TextStyle(fontSize: 14, color: color),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
