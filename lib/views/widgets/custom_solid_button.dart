import 'package:flutter/material.dart';

import 'package:artriapp/utils/index.dart';

class CustomSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final List<Color>? gradientColors;
  final double fontSize;
  final double borderRadius;
  final Color? color;
  final bool _hasGradient;
  final double? width;
  final Color? textColor;
  final TextStyle? textStyle;

  const CustomSolidButton({
    super.key,
    required this.text,
    this.onPressed,
    this.gradientColors,
    this.fontSize = 30.0,
    this.borderRadius = 30.0,
    this.color,
    this.width,
    this.textColor,
    this.textStyle,
  }) : _hasGradient = gradientColors != null && gradientColors.length >= 2;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;

    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: _hasGradient && isEnabled
            ? LinearGradient(
                colors: gradientColors!,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(borderRadius),
        color: !isEnabled
          ? AppColors.grey // Cinza apenas se estiver desabilitado
          : (_hasGradient ? null : (color ?? AppColors.darkBlue)),
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
          padding: const EdgeInsets.symmetric(),
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  color: textColor ?? AppColors.neutral,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ),
    );
  }
}
