import 'package:flutter/material.dart';

class CustomSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color>? gradientColors;
  final double fontSize;
  final double borderRadius;
  final double horizontalPadding;
  final Color? color;
  final bool _hasGradient;
  final double? width;
  final Color? textColor;
  final TextStyle? textStyle;

  const CustomSolidButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.gradientColors,
    this.fontSize = 30.0,
    this.borderRadius = 30.0,
    this.horizontalPadding = 16,
    this.color,
    this.width,
    this.textColor,
    this.textStyle,
  }) : _hasGradient = gradientColors != null && gradientColors.length >= 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: _hasGradient
            ? LinearGradient(
                colors: gradientColors!,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(borderRadius),
        color: !_hasGradient ? color ?? Colors.blue : null,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 4),
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ),
    );
  }
}
