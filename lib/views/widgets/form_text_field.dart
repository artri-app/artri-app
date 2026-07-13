import 'package:artriapp/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final String value;
  final TextEditingController? controller;
  final ValueChanged<String>? onValueChanged;
  final bool obscureText;

  const FormTextField({
    super.key,
    required this.label,
    this.placeholder = '',
    this.value = '',
    this.controller,
    this.onValueChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveController = controller ?? TextEditingController(text: value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: AppColors.darkGreen,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: effectiveController,
          obscureText: obscureText,
          onChanged: onValueChanged,
          style: GoogleFonts.montserrat(fontSize: 16),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.neutral,
            hintText: placeholder,
            hintStyle: GoogleFonts.montserrat(color: Colors.grey.shade500),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: AppColors.darkGreen, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
