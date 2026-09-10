import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GreenActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final AlignmentGeometry alignment;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const GreenActionButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width = 300,
    this.height = 50,
    this.alignment = Alignment.center,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkGreen,
          alignment: alignment,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: textStyle ??
              GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
