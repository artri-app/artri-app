import 'package:artriapp/utils/custom_border.dart';
import 'package:artriapp/utils/enums/input_text_type.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputText extends StatefulWidget {
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
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(InputText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.85,
          child: Text(
            widget.label,
            style: GoogleFonts.jetBrainsMono(
              color: const Color(0xff737373),
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        TextField(
          controller: _controller,
          obscureText: widget.type == InputTextType.password,
          onChanged: (value) => widget.onValueChanged?.call(value),
          textAlign: TextAlign.center,
          style: GoogleFonts.jetBrainsMono(fontSize: 20),
          onTapUpOutside: (_) {
            widget.onValueChanged?.call(_controller.text);
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            labelStyle: GoogleFonts.jetBrainsMono(
              color: const Color(0xFFa6a6a6),
              fontSize: 20,
            ),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(widget.placeholder.toUpperCase())],
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            enabledBorder: const CustomInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF0058aa)),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            focusedBorder: const CustomInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF0058aa)),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            disabledBorder: const CustomInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF0058aa)),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            errorBorder: const CustomInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF0058aa)),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            focusedErrorBorder: const CustomInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF0058aa)),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            border: const CustomInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF0058aa)),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
          ),
        ),
      ],
    );
  }
}
