import 'package:artriapp/utils/custom_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputText extends StatefulWidget {
  final String placeholder;
  final String label;

  const InputText({super.key, required this.placeholder, this.label = ''});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  String _placeholder = r'Placeholder';
  String _label = '';

  @override
  void initState() {
    super.initState();
    _placeholder = widget.placeholder;
    _label = widget.label;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.85,
          child: Text(
            _label,
            style: GoogleFonts.jetBrainsMono(
                color: const Color(0xff737373), fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        TextField(
            textAlign: TextAlign.center,
            style: GoogleFonts.jetBrainsMono(fontSize: 20),
            decoration: InputDecoration(
                labelStyle: GoogleFonts.jetBrainsMono(
                    color: const Color(0xFFa6a6a6), fontSize: 20),
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(_placeholder.toUpperCase())],
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: const CustomInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF0058aa)),
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                focusedBorder: const CustomInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF0058aa)),
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                disabledBorder: const CustomInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF0058aa)),
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                errorBorder: const CustomInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF0058aa)),
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                focusedErrorBorder: const CustomInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF0058aa)),
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                border: const CustomInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF0058aa)),
                    borderRadius: BorderRadius.all(Radius.circular(24))))),
      ],
    );
  }
}
