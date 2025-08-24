import 'package:artriapp/utils/custom_border.dart';
import 'package:artriapp/utils/enums/input_text_type.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputText extends StatelessWidget {
  final String placeholder;
  final String label;
  final String value;
  final ValueChanged<String>? onValueChanged;
  final InputTextType type;

  const InputText({
    super.key,
    required this.placeholder,
    this.onValueChanged,
    this.label = '',
    this.value = '',
    this.type = InputTextType.text,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: value);

    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.85,
          child: Text(
            label,
            style: GoogleFonts.jetBrainsMono(
                color: const Color(0xff737373), fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        TextField(
            controller: controller,
            obscureText: type == InputTextType.password,
            onChanged: (value) => onValueChanged!(value),
            textAlign: TextAlign.center,
            style: GoogleFonts.jetBrainsMono(fontSize: 20),
            onTapUpOutside: (_) => {
                  onValueChanged!(controller.text),
                  FocusManager.instance.primaryFocus?.unfocus(),
                },
            decoration: InputDecoration(
                labelStyle: GoogleFonts.jetBrainsMono(
                    color: const Color(0xFFa6a6a6), fontSize: 20),
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(placeholder.toUpperCase())],
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
