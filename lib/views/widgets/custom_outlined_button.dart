import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final double borderRadius;
  final Color? color;
  final double? width;
  final TextStyle? textStyle;
  final double borderWidth;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.borderWidth,
    this.fontSize = 30.0,
    this.borderRadius = 30.0,
    this.color,
    this.width,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: color ?? Colors.blue,
          width: borderWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text.toUpperCase(),
          style: textStyle?.copyWith(color: color) ??
              GoogleFonts.montserrat(
                color: color ?? Colors.blue,
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }
}
